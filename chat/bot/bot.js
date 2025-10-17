const { Client, GatewayIntentBits, REST, Routes, SlashCommandBuilder } = require('discord.js');
const fs = require('fs');
const path = require('path');

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

const TOKEN = "YOUR_BOT_TOKEN";
const CLIENT_ID = "1353763727807221812";
const GUILD_ID = "1052668757044105266";
const PERMISSION_ROLE_ID = "1109826341127331892";
const CHAT_TAG_CHANNEL_ID = "1428734693527781407";
const CHAT_TAG_LIST_CHANNEL_ID = "1425472675266039990";

const chattagsPath = path.join(__dirname, '../chattags.json');

const commands = [
    new SlashCommandBuilder()
        .setName('createnewtag')
        .setDescription('Creates a new chat tag')
        .addStringOption(option =>
            option.setName('name')
                .setDescription('The name of the tag')
                .setRequired(true))
        .addStringOption(option =>
            option.setName('tag')
                .setDescription('The chat tag to display')
                .setRequired(true))
        .addRoleOption(option =>
            option.setName('role')
                .setDescription('The Discord role for the tag')
                .setRequired(true))
        .addNumberOption(option =>
            option.setName('slots')
                .setDescription('The number of slots for the tag')
                .setRequired(true))
        .addUserOption(option =>
            option.setName('owner')
                .setDescription('The owner of the tag')
                .setRequired(true))
        .addStringOption(option =>
            option.setName('color')
                .setDescription('The hex color code for the tag (e.g., #FF0000)')
                .setRequired(true)),
    new SlashCommandBuilder()
        .setName('chattagstatus')
        .setDescription('Check the status of your chat tag'),
    new SlashCommandBuilder()
        .setName('givetag')
        .setDescription('Give a chat tag to a user')
        .addUserOption(option =>
            option.setName('user')
                .setDescription('The user to give the tag to')
                .setRequired(true))
        .addRoleOption(option =>
            option.setName('role')
                .setDescription('The role to give')
                .setRequired(true)),
].map(command => command.toJSON());

const rest = new REST({ version: '10' }).setToken(TOKEN);

(async () => {
    try {
        console.log('Started refreshing application (/) commands.');

        await rest.put(
            Routes.applicationGuildCommands(CLIENT_ID, GUILD_ID),
            { body: commands },
        );

        console.log('Successfully reloaded application (/) commands.');
    } catch (error) {
        console.error(error);
    }
})();

client.on('ready', async () => {
    console.log(`Logged in as ${client.user.tag}!`);

    const channel = await client.channels.fetch(CHAT_TAG_LIST_CHANNEL_ID);
    if (!channel) return;

    const chattags = JSON.parse(fs.readFileSync(chattagsPath));
    for (const roleId in chattags) {
        const tag = chattags[roleId];
        const role = await channel.guild.roles.fetch(roleId);
        const owner = await channel.guild.members.fetch(tag.owner);

        const embed = {
            title: tag.name,
            fields: [
                { name: 'Role', value: role.toString(), inline: true },
                { name: 'Owner', value: owner.toString(), inline: true },
                { name: 'Slots', value: `${tag.slots}`, inline: true },
            ],
            color: 0x00ff00
        };

        channel.send({ embeds: [embed] });
    }
});

client.on('interactionCreate', async interaction => {
    if (!interaction.isChatInputCommand()) return;

    const { commandName } = interaction;

    if (commandName === 'createnewtag') {
        if (!interaction.member.roles.cache.has(PERMISSION_ROLE_ID)) {
            return interaction.reply({ content: 'You do not have permission to use this command.', ephemeral: true });
        }

        await interaction.deferReply({ ephemeral: true });

        const name = interaction.options.getString('name');
        const tag = interaction.options.getString('tag');
        const role = interaction.options.getRole('role');
        const slots = interaction.options.getNumber('slots');
        const owner = interaction.options.getUser('owner');
        const color = interaction.options.getString('color');

        const chattags = JSON.parse(fs.readFileSync(chattagsPath));

        chattags[role.id] = {
            name: name,
            tag: tag,
            owner: owner.id,
            slots: slots,
            color: color
        };

        fs.writeFileSync(chattagsPath, JSON.stringify(chattags, null, 4));

        await interaction.editReply({ content: `Chat tag ${name} created with role ${role.name} and ${slots} slots.` });
    } else if (commandName === 'chattagstatus') {
        await interaction.deferReply({ ephemeral: true });
        const chattags = JSON.parse(fs.readFileSync(chattagsPath));
        const userTags = [];
        for (const roleId in chattags) {
            const tag = chattags[roleId];
            if (tag.owner === interaction.user.id) {
                const role = await interaction.guild.roles.fetch(roleId);
                const members = await interaction.guild.members.fetch();
                const membersWithRole = members.filter(member => member.roles.cache.has(role.id));
                userTags.push({ ...tag, roleName: role.name, usedSlots: membersWithRole.size });
            }
        }

        if (userTags.length === 0) {
            return interaction.editReply({ content: 'You are not the owner of any chat tags.' });
        }

        const embeds = userTags.map(tag => {
            const availableSlots = tag.slots - tag.usedSlots;
            return {
                title: tag.name,
                fields: [
                    { name: 'Role', value: tag.roleName, inline: true },
                    { name: 'Total Slots', value: `${tag.slots}`, inline: true },
                    { name: 'Available Slots', value: `${availableSlots > 0 ? availableSlots : 'FULL'}`, inline: true },
                ],
                color: 0x00ff00
            };
        });

        await interaction.editReply({ embeds: embeds });

    } else if (commandName === 'givetag') {
        if (!interaction.member.roles.cache.has(PERMISSION_ROLE_ID)) {
            return interaction.reply({ content: 'You do not have permission to use this command.', ephemeral: true });
        }

        await interaction.deferReply({ ephemeral: true });

        const user = interaction.options.getUser('user');
        const roleToGive = interaction.options.getRole('role');

        const chattags = JSON.parse(fs.readFileSync(chattagsPath));
        const tag = chattags[roleToGive.id];

        if (!tag) {
            return interaction.editReply({ content: 'This role is not a chat tag role.' });
        }

        const members = await interaction.guild.members.fetch();
        const membersWithRole = members.filter(member => member.roles.cache.has(roleToGive.id));

        if (membersWithRole.size >= tag.slots) {
            return interaction.editReply({ content: 'There are no available slots for this chat tag.' });
        }

        const member = await interaction.guild.members.fetch(user.id);
        await member.roles.add(roleToGive);

        await interaction.editReply({ content: `Gave the ${roleToGive.name} role to ${user.tag}.` });
    }
});

client.login(TOKEN);