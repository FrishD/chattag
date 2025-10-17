local SelectedTags = {}
local ChatTags = {}

-- Load and parse the chattags.json file
local function loadChatTags()
    local jsonString = LoadResourceFile(GetCurrentResourceName(), "chattags.json")
    if jsonString then
        ChatTags = json.decode(jsonString)
        if type(ChatTags) ~= "table" then
            print("^[chat-tag] ERROR: Failed to decode chattags.json. Make sure it is a valid JSON format.")
            ChatTags = {}
        end
    else
        print("^[chat-tag] ERROR: chattags.json not found.")
    end
end

-- Load the tags when the script starts
loadChatTags()

-- This function gets the full tag string for a player
local function getPlayerTag(player)
    -- 1. Check for a manually selected tag
    if SelectedTags[player] then
        return SelectedTags[player]
    end

    -- 2. If no manual selection, find the highest-priority role-based tag
    local tagString = nil
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(player)
    if Roles and ChatTags then
        for _, tagInfo in ipairs(ChatTags) do
            if type(tagInfo) == "table" and tagInfo.roleId then
                for _, userRole in ipairs(Roles) do
                    if tostring(userRole) == tostring(tagInfo.roleId) then
                        -- Found a matching role, construct the tag string and cache it
                        tagString = "^" .. tagInfo.hexColor:gsub("#", "") .. tagInfo.tagName .. "^r"
                        SelectedTags[player] = tagString
                        return tagString
                    end
                end
            end
        end
    end

    -- 3. If no role-based tag is found, return the default
    return Config.ChatRoles.DefaultTag
end

-- Export for backward compatibility
exports('GetTag', function(player)
    return getPlayerTag(player)
end)

-- Register a hook to modify chat messages
CreateThread(function()
    Wait(500)
    if exports.chat and exports.chat.registerMessageHook then
        exports.chat:registerMessageHook(function(source, message, update)
            local player = source
            local tag = getPlayerTag(player)

            -- Prepend the tag to the message itself (args[2]), not before the name (args[1])
            if #message.args >= 1 then
                -- The first arg is the player name, the second is the message
                -- We prepend the tag to the player's name argument.
                message.args[1] = tag .. " " .. message.args[1]
            else
                -- Handle cases with no message, just a name
                table.insert(message.args, tag)
            end

            -- Update the message with the new arguments
            update(message)
        end)
    else
        print("^[chat-tag] ERROR: The 'chat' resource or its 'registerMessageHook' export was not found.")
    end
end)


-- Event handler for when a player changes their tag via the menu
RegisterServerEvent('ChatRoles:Change')
AddEventHandler('ChatRoles:Change', function(ID)
    local tagString = nil
    if ChatTags then
        for _, tagInfo in ipairs(ChatTags) do
            if type(tagInfo) == "table" and tagInfo.roleId and tostring(tagInfo.roleId) == tostring(ID) then
                tagString = "^" .. tagInfo.hexColor:gsub("#", "") .. tagInfo.tagName .. "^r"
                break
            end
        end
    end

    SelectedTags[source] = tagString or Config.ChatRoles.DefaultTag
end)

-- Event handler for when a player joins, to set their initial tag
RegisterServerEvent('ChatRoles:Joined')
AddEventHandler('ChatRoles:Joined', function()
    -- Clear any previously selected tag to ensure the role-based one is used
    SelectedTags[source] = nil
    -- The getPlayerTag function will now determine the correct tag on the first message
end)


-- Event handler to get available tags for the player's menu
RegisterServerEvent('ChatRoles:Get')
AddEventHandler('ChatRoles:Get', function()
    local Player = source
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
    local hasTags = false
    local availableTags = {}

    if Roles and ChatTags then
        for _, tagInfo in ipairs(ChatTags) do
            local hasRole = false
            if type(tagInfo) == "table" and tagInfo.roleId then
                for _, userRole in ipairs(Roles) do
                    if tostring(userRole) == tostring(tagInfo.roleId) then
                        hasRole = true
                        break
                    end
                end
            end

            if hasRole then
                hasTags = true
                table.insert(availableTags, {
                    ID = tagInfo.roleId,
                    Name = tagInfo.tagName
                })
            end
        end
    end
    TriggerClientEvent('ChatRoles:Return', Player, hasTags, availableTags)
end)