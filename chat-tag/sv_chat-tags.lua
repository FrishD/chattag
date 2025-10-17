local SelectedTags = {}

-- This function gets the tag data for a player
local function getPlayerTagData(player)
    if SelectedTags[player] then
        return SelectedTags[player]
    end

    local tagData = nil
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(player)
    if Roles then
        for _, tagInfo in ipairs(Config.ChatRoles.Tags) do
            if type(tagInfo) == "table" and tagInfo.roleID then
                for _, userRole in ipairs(Roles) do
                    if tonumber(userRole) == tonumber(tagInfo.roleID) then
                        tagData = { text = tagInfo.chatTag, color = tagInfo.color }
                        break
                    end
                end
            end
            if tagData then break end
        end
    end
    return tagData
end

-- Register a hook to modify chat messages
CreateThread(function()
    -- Wait a bit to ensure all resources are loaded
    Wait(500)
    if exports.chat and exports.chat.registerMessageHook then
        exports.chat:registerMessageHook(function(source, message, update)
            local player = source
            local tagData = getPlayerTagData(player)

            if not tagData then
                -- Fallback to default tag if no specific tag is found
                tagData = { text = Config.ChatRoles.DefaultTag.text, color = Config.ChatRoles.DefaultTag.color }
            end

            -- The 'update' is a function that takes a table.
            -- We are overriding the default template to inject our own.
            update({
                template = '<div style="color: ' .. tagData.color .. '; display: inline-block; margin-right: 5px;">' .. tagData.text .. '</div><strong>{0}:</strong> {1}',
                args = message.args
            })
        end)
    else
        print("^[chat-tag] ERROR: The 'chat' resource or its 'registerMessageHook' export was not found. Make sure the 'chat' resource is started and the dependency is set correctly.")
    end
end)


-- Event handler for when a player changes their tag via the menu
RegisterServerEvent('ChatRoles:Change')
AddEventHandler('ChatRoles:Change', function(ID)
    local tagData = nil
    for _, tagInfo in ipairs(Config.ChatRoles.Tags) do
        if type(tagInfo) == "table" and tagInfo.roleID and tonumber(tagInfo.roleID) == tonumber(ID) then
            tagData = { text = tagInfo.chatTag, color = tagInfo.color }
            break
        end
    end

    if not tagData then
        tagData = { text = Config.ChatRoles.DefaultTag.text, color = Config.ChatRoles.DefaultTag.color }
    end
    SelectedTags[source] = tagData
end)

-- Event handler for when a player joins, to set their initial tag
RegisterServerEvent('ChatRoles:Joined')
AddEventHandler('ChatRoles:Joined', function()
    -- We don't need to select a tag here anymore,
    -- the message hook will dynamically fetch it.
    -- We can clear the selected tag to ensure the default role-based one is used.
    SelectedTags[source] = nil
end)


-- Event handler to get available tags for the player's menu
RegisterServerEvent('ChatRoles:Get')
AddEventHandler('ChatRoles:Get', function()
    local Player = source
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
    local hasTags = false
    local availableTags = {}

    if Roles then
        for _, tagInfo in ipairs(Config.ChatRoles.Tags) do
            local hasRole = false
            if type(tagInfo) == "table" and tagInfo.roleID then
                for _, userRole in ipairs(Roles) do
                    if tonumber(userRole) == tonumber(tagInfo.roleID) then
                        hasRole = true
                        break
                    end
                end
            end

            if hasRole then
                hasTags = true
                table.insert(availableTags, {
                    ID = tagInfo.roleID,
                    Name = tagInfo.displayName
                })
            end
        end
    end
    TriggerClientEvent('ChatRoles:Return', Player, hasTags, availableTags)
end)