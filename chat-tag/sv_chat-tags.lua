local SelectedTags = {}

-- Helper function to convert hex to RGB table
local function hexToRgb(hex)
    if not hex or type(hex) ~= 'string' then return { 255, 255, 255 } end
    hex = hex:gsub("#", "")
    return {
        tonumber("0x" .. hex:sub(1, 2)),
        tonumber("0x" .. hex:sub(3, 4)),
        tonumber("0x" .. hex:sub(5, 6))
    }
end

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
exports.chat:registerMessageHook(function(source, message, update)
    local player = source
    local tagData = getPlayerTagData(player)

    if not tagData then
        tagData = { text = Config.ChatRoles.DefaultTag.text, color = Config.ChatRoles.DefaultTag.color }
    end

    -- Update the message with the tag and color
    update.updateMessage({
        -- The template prepends the tag to the player's name {0} and their message {1}
        template = '<div style="color: {2}; display: inline-block; margin-right: 5px;">{3}</div> <strong>{0}:</strong> {1}',
        params = {
            -- Note: The chat resource itself handles escaping, so we don't do it here.
            ['2'] = tagData.color,
            ['3'] = tagData.text,
        }
    })
end)


-- Event handler for when a player changes their tag via the menu
RegisterServerEvent('ChatRoles:Change')
AddEventHandler('ChatRoles:Change', function(ID)
    local tagData = nil
    for _, tagInfo in ipairs(Config.ChatRoles.Tags) do
        if type(tagInfo) == "table" and tagInfo.roleID and tonumber(tagInfo.roleID) == tonumber(ID) then
            -- Store the raw hex color, we will convert it in the hook
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