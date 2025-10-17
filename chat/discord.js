const { Client, GatewayIntentBits, REST, Routes, SlashCommandBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, StringSelectMenuBuilder, ModalBuilder, TextInputBuilder, TextInputStyle, EmbedBuilder } = require('discord.js');
const fs = require('fs');

const client = new Client({ intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages, GatewayIntentBits.GuildMembers] });

let config = {};
let tags = [];

on('chat:setConfig', (newConfig) => {
    config = newConfig;
    client.login(config.token);
});

fs.readFile('chattags.json', 'utf8', (err, data) => {
    if (err) {
        if (err.code === 'ENOENT') {
            fs.writeFile('chattags.json', '[]', (err) => {
                if (err) {
                    console.error(err);
                }
            });
        } else {
            console.error(err);
        }
        return;
    }

    tags = JSON.parse(data);
});

const commands = [
    new SlashCommandBuilder()
        .setName('createtag')
        .setDescription('Creates a new chat tag.')
        .addStringOption(option => option.setName('owner_discord_id').setDescription('The Discord ID of the chat tag owner.').setRequired(true))
        .addStringOption(option => option.setName('role_name').setDescription('The name of the chat tag role.').setRequired(true))
        .addStringOption(option => option.setName('hex_color').setDescription('The hex color of the chat tag.').setRequired(true))
        .addStringOption(option => option.setName('tag_name').setDescription('The name of the chat tag.').setRequired(true))
        .addIntegerOption(option => option.setName('slots').setDescription('The number of slots for the chat tag.').setRequired(true)),
    new SlashCommandBuilder()
        .setName('addslots')
        .setDescription('Adds slots to a chat tag.')
        .addRoleOption(option => option.setName('role').setDescription('The role of the chat tag.').setRequired(true))
        .addIntegerOption(option => option.setName('slots').setDescription('The number of slots to add.').setRequired(true)),
    new SlashCommandBuilder()
        .setName('removeslots')
        .setDescription('Removes slots from a chat tag.')
        .addRoleOption(option => option.setName('role').setDescription('The role of the chat tag.').setRequired(true))
        .addIntegerOption(option => option.setName('slots').setDescription('The number of slots to remove.').setRequired(true)),
].map(command => command.toJSON());

client.on('ready', async () => {
    console.log(`Logged in as ${client.user.tag}!`);

    const rest = new REST({ version: '10' }).setToken(config.token);

    try {
        console.log('Started refreshing application (/) commands.');

        await rest.put(
            Routes.applicationCommands(client.application.id),
            { body: commands },
        );

        console.log('Successfully reloaded application (/) commands.');
    } catch (error) {
        console.error(error);
    }

    const channel = await client.channels.fetch(config.tagManagementChannel);
    if (channel) {
        const row = new ActionRowBuilder()
            .addComponents(
                new ButtonBuilder()
                    .setCustomId('who_in_tag')
                    .setLabel('Who is in my chat tag?')
                    .setStyle(ButtonStyle.Primary),
                new ButtonBuilder()
                    .setCustomId('add_to_tag')
                    .setLabel('Add to my chat tag')
                    .setStyle(ButtonStyle.Success),
            );

        await channel.send({ content: 'Manage your chat tags:', components: [row] });
    }

    updateTagList();
    setInterval(updateTagList, 30 * 60 * 1000); // 30 minutes
});

async function updateTagList() {
    const channel = await client.channels.fetch(config.tagListChannel);
    if (channel) {
        await channel.messages.fetch({ limit: 100 }).then(messages => {
            channel.bulkDelete(messages);
        });

        for (const tag of tags) {
            const owner = await client.users.fetch(tag.ownerId);
            const embed = new EmbedBuilder()
                .setTitle(tag.tagName)
                .setColor(tag.hexColor)
                .addFields(
                    { name: 'Owner', value: owner.toString() },
                    { name: 'Slots', value: `${tag.members.length}/${tag.slots}` }
                );
            await channel.send({ embeds: [embed] });
        }
    }
}

client.on('interactionCreate', async interaction => {
    if (!interaction.isCommand()) return;

    const { commandName } = interaction;

    if (commandName === 'createtag') {
        if (!interaction.member.roles.cache.has(config.adminRole)) {
            return interaction.reply({ content: 'You do not have permission to use this command.', ephemeral: true });
        }

        const ownerId = interaction.options.getString('owner_discord_id');
        const roleName = interaction.options.getString('role_name');
        const hexColor = interaction.options.getString('hex_color');
        const tagName = interaction.options.getString('tag_name');
        const slots = interaction.options.getInteger('slots');

        try {
            const role = await interaction.guild.roles.create({
                name: roleName,
                color: hexColor,
            });

            const owner = await interaction.guild.members.fetch(ownerId);
            await owner.roles.add(config.tagManagerRole);

            const newTag = {
                ownerId,
                roleId: role.id,
                hexColor,
                tagName,
                slots,
                members: [],
            };

            tags.push(newTag);

            fs.writeFile('chattags.json', JSON.stringify(tags, null, 2), err => {
                if (err) {
                    console.error(err);
                    return interaction.reply({ content: 'An error occurred while creating the chat tag.', ephemeral: true });
                }

                interaction.reply({ content: `Chat tag "${tagName}" created successfully!`, ephemeral: true });
                emit('chat:refreshTags');
            });
        } catch (error) {
            console.error(error);
            interaction.reply({ content: 'An error occurred while creating the chat tag.', ephemeral: true });
        }
    } else if (commandName === 'addslots' || commandName === 'removeslots') {
        if (!interaction.member.roles.cache.has(config.adminRole)) {
            return interaction.reply({ content: 'You do not have permission to use this command.', ephemeral: true });
        }

        const role = interaction.options.getRole('role');
        const slots = interaction.options.getInteger('slots');

        const tag = tags.find(t => t.roleId === role.id);

        if (!tag) {
            return interaction.reply({ content: 'That role is not a chat tag role.', ephemeral: true });
        }

        if (commandName === 'addslots') {
            tag.slots += slots;
        } else {
            tag.slots -= slots;
        }

        fs.writeFile('chattags.json', JSON.stringify(tags, null, 2), err => {
            if (err) {
                console.error(err);
                return interaction.reply({ content: 'An error occurred while updating the chat tag.', ephemeral: true });
            }

            interaction.reply({ content: `Chat tag "${tag.tagName}" updated successfully!`, ephemeral: true });
            emit('chat:refreshTags');
        });
    } else if (interaction.isButton()) {
        const ownedTags = tags.filter(t => t.ownerId === interaction.user.id);

        if (ownedTags.length === 0) {
            return interaction.reply({ content: 'You do not own any chat tags.', ephemeral: true });
        }

        if (interaction.customId.startsWith('who_in_tag_') || interaction.customId.startsWith('add_to_tag_')) {
            const roleId = interaction.customId.split('_')[3];
            const tag = tags.find(t => t.roleId === roleId);

            if (!tag) {
                return interaction.reply({ content: 'That chat tag no longer exists.', ephemeral: true });
            }

            if (interaction.customId.startsWith('who_in_tag_')) {
                const members = tag.members.map(m => `<@${m}>`).join('\n');
                interaction.reply({ content: `**Members in ${tag.tagName}:**\n${members}\n\n**Slots:** ${tag.members.length}/${tag.slots}`, ephemeral: true });
            } else if (interaction.customId.startsWith('add_to_tag_')) {
                const modal = new ModalBuilder()
                    .setCustomId(`add_to_tag_modal_${tag.roleId}`)
                    .setTitle(`Add to ${tag.tagName}`);

                const userIdInput = new TextInputBuilder()
                    .setCustomId('user_id_input')
                    .setLabel("User's Discord ID")
                    .setStyle(TextInputStyle.Short);

                const firstActionRow = new ActionRowBuilder().addComponents(userIdInput);

                modal.addComponents(firstActionRow);

                await interaction.showModal(modal);
            }
        } else if (ownedTags.length > 1) {
            const row = new ActionRowBuilder();
            const options = ownedTags.map(tag => {
                return {
                    label: tag.tagName,
                    value: tag.roleId,
                };
            });

            row.addComponents(
                new StringSelectMenuBuilder()
                    .setCustomId('select_tag')
                    .setPlaceholder('Select a tag to manage')
                    .addOptions(options),
            );

            return interaction.reply({ content: 'You own multiple chat tags. Please select one to manage:', components: [row], ephemeral: true });
        } else {
            const tag = ownedTags[0];

            if (interaction.customId === 'who_in_tag') {
                const members = tag.members.map(m => `<@${m}>`).join('\n');
                interaction.reply({ content: `**Members in ${tag.tagName}:**\n${members}\n\n**Slots:** ${tag.members.length}/${tag.slots}`, ephemeral: true });
            } else if (interaction.customId === 'add_to_tag') {
                const modal = new ModalBuilder()
                    .setCustomId(`add_to_tag_modal_${tag.roleId}`)
                    .setTitle(`Add to ${tag.tagName}`);

                const userIdInput = new TextInputBuilder()
                    .setCustomId('user_id_input')
                    .setLabel("User's Discord ID")
                    .setStyle(TextInputStyle.Short);

                const firstActionRow = new ActionRowBuilder().addComponents(userIdInput);

                modal.addComponents(firstActionRow);

                await interaction.showModal(modal);
            }
        }
    } else if (interaction.isStringSelectMenu() && interaction.customId === 'select_tag') {
        const roleId = interaction.values[0];
        const tag = tags.find(t => t.roleId === roleId);

        if (!tag) {
            return interaction.reply({ content: 'That chat tag no longer exists.', ephemeral: true });
        }

        const row = new ActionRowBuilder()
            .addComponents(
                new ButtonBuilder()
                    .setCustomId(`who_in_tag_${tag.roleId}`)
                    .setLabel('Who is in my chat tag?')
                    .setStyle(ButtonStyle.Primary),
                new ButtonBuilder()
                    .setCustomId(`add_to_tag_${tag.roleId}`)
                    .setLabel('Add to my chat tag')
                    .setStyle(ButtonStyle.Success),
            );

        interaction.reply({ content: `You are now managing the "${tag.tagName}" chat tag.`, components: [row], ephemeral: true });
    } else if (interaction.isModalSubmit() && interaction.customId.startsWith('add_to_tag_modal')) {
        const userId = interaction.fields.getTextInputValue('user_id_input');
        const roleId = interaction.customId.split('_')[4];
        const tag = tags.find(t => t.roleId === roleId);

        if (!tag) {
            return interaction.reply({ content: 'That chat tag no longer exists.', ephemeral: true });
        }

        if (tag.members.length >= tag.slots) {
            return interaction.reply({ content: 'That chat tag is full.', ephemeral: true });
        }

        try {
            const member = await interaction.guild.members.fetch(userId);
            await member.roles.add(tag.roleId);
            tag.members.push(userId);

            fs.writeFile('chattags.json', JSON.stringify(tags, null, 2), err => {
                if (err) {
                    console.error(err);
                    return interaction.reply({ content: 'An error occurred while adding the user to the chat tag.', ephemeral: true });
                }

                interaction.reply({ content: `Successfully added <@${userId}> to ${tag.tagName}!`, ephemeral: true });
                emit('chat:refreshTags');
            });
        } catch (error) {
            console.error(error);
            interaction.reply({ content: 'An error occurred while adding the user to the chat tag. Make sure you entered a valid Discord ID.', ephemeral: true });
        }
    }
});