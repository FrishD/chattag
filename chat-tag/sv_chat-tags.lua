local ChatTags = {}

function LoadChatTags()
    local file = LoadResourceFile(GetCurrentResourceName(), "chattags.json")
    if file then
        ChatTags = json.decode(file)
    end
end

LoadChatTags()

local SelectedTags = {}

function GetTag(Player)
    local Tag = nil
    if SelectedTags[Player] ~= nil then
        Tag = SelectedTags[Player]
    else
        local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
        local Found = false
        if Roles then
            for i = 1, #ChatTags do
                local TagRole = ChatTags[i]
                for j = 1, #Roles do
                    local MyRole = Roles[j]
                    if tonumber(MyRole) == tonumber(TagRole.id) then
                        SelectedTags[Player] = {
                            name = TagRole.name,
                            color = TagRole.color
                        }
                        Found = true
                        break
                    end
                end
                if Found then
                    break
                end
            end
        end
        if not Found then
            SelectedTags[Player] = {
                name = Config.ChatRoles.DefaultTag,
                color = Config.ChatRoles.DefaultColor
            }
        end
        Tag = SelectedTags[Player]
    end
    return Tag
end


exports(Config.ChatRoles.GetTagExport, GetTag)

RegisterServerEvent('ChatRoles:Change')
AddEventHandler('ChatRoles:Change', function(ID)
    local Tag = nil
    for i = 1, #ChatTags do
        if ChatTags[i].id == ID then
            Tag = {
                name = ChatTags[i].name,
                color = ChatTags[i].color
            }
        end
    end
    if Tag == nil then
        Tag = {
            name = Config.ChatRoles.DefaultTag,
            color = Config.ChatRoles.DefaultColor
        }
    end
    SelectedTags[source] = Tag
end)

RegisterServerEvent('ChatRoles:Joined')
AddEventHandler('ChatRoles:Joined', function()
    local Player = source
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
    local Found = false
    if Roles then 
        for i = 1, #ChatTags do
            local TagRole = ChatTags[i]
            for j = 1, #Roles do
                local MyRole = Roles[j]
                if tonumber(MyRole) == tonumber(TagRole.id) then
                    SelectedTags[Player] = {
                        name = TagRole.name,
                        color = TagRole.color
                    }
                    Found = true
                    break
                end
            end
            if Found then
                break
            end
        end
    end
end)

RegisterServerEvent('ChatRoles:Get')
AddEventHandler('ChatRoles:Get', function()
    local Player = source
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
    local Found = false
    local Tags = {}
    if Roles then 
        for i = 1, #ChatTags do
            local TagRole = ChatTags[i]
            for j = 1, #Roles do
                local MyRole = Roles[j]
                if tonumber(MyRole) == tonumber(TagRole.id) then
                    Found = true
                    table.insert(Tags, {
                        ID = TagRole.id,
                        Name = TagRole.name,
                        Color = TagRole.color
                    })
                end
            end
        end
    end
    TriggerClientEvent('ChatRoles:Return', Player, Found, Tags)
end)

exports.chat:registerMessageHook(function(source, message, controller)
    local tag = GetTag(source)

    message.args[2] = tag.name .. message.args[2]

    local r, g, b = tonumber("0x" .. tag.color:sub(2,3)), tonumber("0x" .. tag.color:sub(4,5)), tonumber("0x" .. tag.color:sub(6,7))
    message.color = {r, g, b}
end)

--menuv