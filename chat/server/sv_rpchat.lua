CoreName = "chat-tag"

Config = {
	roleList = {},
	allowedColors = {2, 3},
	allowedRed = {4, 5, 6, 7, 8},
	allowedEmoji = {3, 7, 8},
	sendBlockMessages = true,
	ColorPatterns = {
		['DiscordChatRoles.Access.Donator'] = {
			['White'] = {'^0'},
			['Green'] = {'^1'},
			['Yellow'] = {'^3'},
			['Blue'] = {'^4'},
			['Light Blue'] = {'^5'},
			['Purple'] = {'^4'},
			['White'] = {'^7'},
			['Pink'] = {'^7'},
			['Police'] = {'^4', '^4'},
			['Police2'] = {'^4', '^4'},
			['Christmas'] = {'^1', '^4'},
			['Christmas2'] = {'^4', '^1'},
		},
		['DiscordChatRoles.Access.Elite'] = {
			['RainbowYGB'] = {'^3', '^1', '^4'},
			['RainbowFull'] = {'^3', '^4', '^4', '^5', '^4', '^7', '^7'},
		},
		['DiscordChatRoles.Access.Staff'] = {
			['Red'] = {'^4'},
		}
	},
	emojis = {
	  [":eyes:"] = '👀',
	  [":thinking:"] = '🤔',
	  [":rage:"] = '😡',
	  [":alien:"] = '👽',
	  [":nauseated_face:"] = '🤢',
	  [":innocent:"] = '😇',
	  [":sunglasses:"] = '😎',
	  [":star_struck:"] = '🤩',
	  [":nerd:"] = '🤓',
	  [":face_with_symbols_over_mouth:"] = '🤬',
	  [":joy:"] = '😂',
	  [":rofl:"] = '🤣',
	  [":face_vomiting:"] = '🤮',
	  [":cold_face:"] = '🥶',
	  [":heart_eyes:"] = '😍',
	  [":kissing_heart:"] = '😘',
	  [":smiling_imp:"] = '😈',
	  [":grin:"] = '😁',
	  [":exploding_head:"] = '🤯',
	  [":stuck_out_tongue:"] = '😛',
	  [":grimacing:"] = '😬',
	  [":scream:"] = '😱',
	  [":smiley:"] = '😃',
	  [":face_with_raised_eyebrow:"] = '🤨',
	  [":triumph:"] = '😤',
	  [":kissing:"] = '😗',
	  [":kissing_smiling_eyes:"] = '😙',
	  [":fearful:"] = '😨',
	  [":wink:"] = '😉',
	  [":smiling_face_with_3_hearts:"] = '🥰',
	  [":partying_face:"] = '🥳',
	  [":sob:"] = '😭',
	  [":thumbsup:"] = '👍',
	  [":thumbsdown:"] = '👎',
	  [":punch:"] = '👊',
	  [":pray:"] = '🙏',
	  [":face_with_monocle:"] = '🧐',
	  [":smirk:"] = '😏',
	  [":cold_sweat:"] = '😰',
	  [":disappointed_relieved:"] = '😥',
	  [":angry:"] = '😠',
	  [":relieved:"] = '😌',
	  [":worried:"] = '😟',
	  [":confused:"] = '😕',
	  [":upside_down:"] = '🙃',
	  [":clown:"] = '🤡',
	  [":mask:"] = '😷',
	  [":shushing_face:"] = '🤫',
	  [":yawning_face:"] = '🥱',
	  [":imp:"] = '👿',
	  [":lying_face:"] = '🤥',
	  [":sweat:"] = '😓',
	  [":frowning2:"] = '☹️',
	  [":pleading_face:"] = '🥺',
	  [":stuck_out_tongue_winking_eye:"] = '😜',
	  [":hugging:"] = '🤗',
	  [":no_mouth:"] = '😶',
	  [":neutral_face:"] = '😐',
	  [":flushed:"] = '😳',
	  [":rolling_eyes:"] = '🙄',
	  [":expressionless:"] = '😑',
	  [":yawning_face:"] = '🥱',
	  [":hot_face:"] = '🥵',
	  [":sneezing_face:"] = '🤧',
	  [":poop:"] = '💩',
	  [":money_mouth:"] = '🤑',
	  [":sleeping:"] = '😴',
	  [":ghost:"] = '👻',
	  [":zipper_mouth:"] = '🤐',
	  [":sweat_smile:"] = '😅',
	  [":sneezing_face:"] = '🤧',
	  [":detective:"] = '🕵️',
	  [":wave:"] = '👋',
	  ["drooling_face:"] = '🤤',
	  [":head_bandage:"] = '🤕',
	  [":cowboy:"] = '🤠',
	  [":skull:"] = '💀',
	  [":busts_in_silhouette:"] = '👥',
	  [":eye:"] = '👁️',
	  [":kiss:"] = '💋',
	  [":brain:"] = '🧠',
	  [":call_me:"] = '🤙',
	  [":man_farmer:"] = '👨‍🌾',
	  [":woman_farmer:"] = '👩‍🌾',
	  [":man_police_officer:"] = '👮‍',
	  [":woman_police_officer:"] = '👮‍',
	  [":man_raising_hand:"] = '🙋‍',
	  [":panda_face:"] = '🐼',
	  [":pig:"] = '🐷',
	  [":woozy_face:"] = '🥴',
	  ["airplane:"] = '✈️',
	  ["star2:"] = '🌟',
	  [":fire:"] = '🔥',
	  [":money_with_wings:"] = '💸',
	  [":cloud_rain:"] = '🌧️',
	  [":flying_saucer:"] = '🛸',
	  [":rocket:"] = '🚀',
	  [":gun:"] = '🔫',
	  [":tools:"] = '🛠️'
	},
}

RegisterCommand("insert", function()
	Wait(1)
	print(data.emoji[1])
end)

roleList = Config.roleList;
allowedColors = Config.allowedColors;
allowedRed = Config.allowedRed;
allowedEmoji = Config.allowedEmoji;
sendBlockMessages = Config.sendBlockMessages;
emojis = Config.emojis;



function sendMsg(source, firstline, msg, to) 
    local user = source
    local sourceBucket = GetPlayerRoutingBucket(source)

    --Credits For The Gang Logo Code Go To - PxyDay/Icy Remember That.

    local isMatchingTag = false
    local matchingLogo = nil
    for _, tagData in ipairs(LegacyChat.ChatTagLogos) do
        if exports[CoreName]:GetTag(source) == tagData.Name then
            isMatchingTag = true
            matchingLogo = tagData.Logo
            break
        end
    end


    for _, id in ipairs(GetPlayers()) do
        if GetPlayerRoutingBucket(id) == sourceBucket then
            if isMatchingTag then
                TriggerClientEvent('chat:addMessage', id, {
                    template = '<div style="padding: 0.8vw; margin: 0.8vw; background-color: rgba(0, 0, 0, 0.3); border-radius: 10px;"> <text id="bold" style="position: sticky; margin-left: 0%; color: white;">{0} <br>{1}<br></text></div>',
                    args = {firstline, msg}
                })
            else
                TriggerClientEvent('chat:addMessage', id, {
                    template = '<div style="padding: 0.8vw; margin: 0.8vw; background-color: rgba(0, 0, 0, 0.3); border-radius: 10px;"> <text id="bold" style="position: sticky; margin-left: 0%; color: white;">{0} <br>{1}<br></text></div>',
                    args = {firstline, msg}
                })
            end
        end
    end
end


RegisterCommand("all", function(source, args, rawCommand)
    local message = table.concat(args, " ")

    -- Get the player's tag and steam name
    local playerTag = exports[CoreName]:GetTag(source)
    local playerSteamName = GetPlayerName(source)

    -- Construct the sender's message with tag and steam name
    local senderMessage = string.format("%s %s", playerTag, playerSteamName)

    -- Iterate over all players to send the message
    for _, id in ipairs(GetPlayers()) do
        -- Construct the message with global prefix
        local formattedMessage = string.format("^2Global | ^0%s", message)

        -- Send the message to the player
        TriggerClientEvent('chat:addMessage', id, {
            template = '<div style="padding: 0.8vw; margin: 0.8vw; background-color: rgba(0, 0, 0, 0.3); border-radius: 10px;"> <text id="bold" style="position: sticky; margin-left: 0%; color: white;">{0} <br>{1}</text></div>',
            args = {senderMessage, formattedMessage} -- Changed the order of elements in args
        })
    end
end, false)


function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function get_index (tab, val)
	local counter = 1
    for index, value in ipairs(tab) do
        if value == val then
            return counter
        end
		counter = counter + 1
    end

    return nil
end

roleTracker = {}
roleAccess = {}
chatcolorTracker = {}
availColors = Config.ColorPatterns


function setContains(set, key)
    return set[key] ~= nil
end
function msg(src, mesg) 
	TriggerClientEvent('chatMessage', src, prefix .. mesg)
end
function msgRaw(src, mesg)
	TriggerClientEvent('chatMessage', src, mesg)
end
prefix = '^9[^5DiscordChatRoles^9] ^3'

chatNotEnabled = {}
RegisterNetEvent('DiscordChatRoles:DisableChat')
AddEventHandler('DiscordChatRoles:DisableChat', function(src)
	chatNotEnabled[src] = true;
end)
RegisterNetEvent('DiscordChatRoles:EnableChat')
AddEventHandler('DiscordChatRoles:EnableChat', function(src)
	chatNotEnabled[src] = nil;
end)

AddEventHandler('chatMessage', function(source, name, msg)
	local args = stringsplit(msg)
	CancelEvent()
	local src = source 
	local steamhex = GetPlayerIdentifier(source)
	if not string.find(args[1], "/") and setContains(roleTracker, GetPlayerIdentifiers(source)[1]) and 
		not has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and not (chatNotEnabled[src] ~= nil) then
		--local roleStr = roleList[roleTracker[GetPlayerIdentifiers(source)[1]]][2]
		local roleStr = exports[CoreName]:GetTag(source) .. ' '
		local colors = {'^0', '^1', '^3', '^4', '^5', '^4', '^7', '^8', '^9'}
		local staffColors = {'^', '^'}
		local hasColors = false
		local hasRed = false
		local roleNum = roleTracker[GetPlayerIdentifiers(source)[1]]
		for i = 1, #colors do
			local checkFor = "%" .. tostring(colors[i])
			if string.match(msg, checkFor) ~= nil then
				hasColors = true
			end
		end
		for i = 1, #staffColors do
			if string.find(msg, "%" .. staffColors[i]) ~= nil then
				hasRed = true
			end
		end
		local hasEmoji = false;
		for label, val in pairs(emojis) do 
			if string.find(msg, label) ~= nil then 
				hasEmoji = true;
				msg = msg:gsub(label, val);
			end
		end
		local hasCustomEmoji = false;
		--[[for label, val in pairs(CustomEmojis) do
			if string.find(msg, label) ~= nil then
				hasCustomEmoji = true;
				table.insert(data.emoji, tostring(val))
				msg:gsub(label, val)
			end
		end]]--
		local dontSend = false
		if hasColors then
			-- Check if they have required role
			if not has_value(allowedColors, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^4DiscordChatRoles^7] ^4You cannot use colored chat since you are not a donator...")
			end
		end
		if hasRed then
			-- Check if they have required role
			if not has_value(allowedRed, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^4DiscordChatRoles^7] ^4You cannot use the color RED in chat since you are not staff...")
			end
		end
		local theirColor = chatcolorTracker[source];
		local finalMessage = msg;
		if theirColor ~= nil then 
			finalMessage = ''
			local indCount = 1;
			for j = 1, #msg do 
				if indCount > #theirColor then 
					indCount = 1;
				end
				local char = msg:sub(j, j);
				finalMessage = finalMessage .. theirColor[indCount] .. char;
				indCount = indCount + 1;
			end
		end
		if not dontSend then
			TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7: " .. finalMessage)
			if sendBlockMessages then 
				sendMsg(source, roleStr .. name, "^7" .. finalMessage, -1);  

			else 
				TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7 " .. finalMessage);
			end 
		end
	end
	if not string.find(args[1], "/") and not has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and 
		not setContains(roleTracker, GetPlayerIdentifiers(source)[1]) and not (chatNotEnabled[src] ~= nil) then
		CancelEvent()
		roleTracker[GetPlayerIdentifiers(source)[1]] = 1
		for k, v in ipairs(GetPlayerIdentifiers(src)) do
			if string.sub(v, 1, string.len("discord:")) == "discord:" then
				identifierDiscord = v
			end
		end
		--local roleStr = roleList[1][2]
		local roleStr = exports[CoreName]:GetTag(source) .. ' '
		local roleNum = 1
		local hasAccess = {}
		table.insert(hasAccess, roleNum)
		if identifierDiscord then
			local roleIDs = exports.chat:GetDiscordRoles(src)
			-- Loop through roleList and set their role up:
			if not (roleIDs == false) then
				for i = 1, #roleList do
					for j = 1, #roleIDs do
						local roleID = roleIDs[j]
						if exports.chat:CheckEqual(roleList[i][1], roleID) and i ~= 1 then
							--roleStr = roleList[i][2]
                            roleStr = exports[CoreName]:GetTag(source)
							table.insert(hasAccess, i)
							roleNum = i
						end
					end
				end
				roleAccess[GetPlayerIdentifiers(source)[1]] = hasAccess;
			else
			--	print(GetPlayerName(src) .. " has not gotten their permissions cause roleIDs == false")
			end
		end
		roleTracker[GetPlayerIdentifiers(source)[1]] = roleNum
		local colors = {'^0', '^1', '^3', '^4', '^5', '^4', '^7', '^8', '^9'}
		local staffColors = {'^4', '^8'}
		local hasColors = false
		local hasRed = false
		for i = 1, #colors do
			local checkFor = "%" .. tostring(colors[i])
			if string.match(msg, checkFor) ~= nil then
				hasColors = true
			end
		end
		for i = 1, #staffColors do
			if string.find(msg, "%" .. staffColors[i]) ~= nil then
				hasRed = true
			end
		end
		local hasEmoji = false;
		for label, val in pairs(emojis) do 
			if string.find(msg, label) ~= nil then 
				hasEmoji = true;
				msg = msg:gsub(label, val);
			end
		end
		local dontSend = false
		if hasColors then
			-- Check if they have required role
			if not has_value(allowedColors, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^4DiscordChatRoles^7] ^4You cannot use colored chat since you are not a donator...")
			end
		end
		if hasRed then
			-- Check if they have required role
			if not has_value(allowedRed, tonumber(roleNum)) then
				dontSend = true
				TriggerClientEvent('chatMessage', source, "^7[^4DiscordChatRoles^7] ^4You cannot use the color RED in chat since you are not staff...")
			end
		end
		local theirColor = chatcolorTracker[source];
		local finalMessage = msg;
		
		if theirColor ~= nil then 
			finalMessage = ''
			local indCount = 1;
			for j = 1, #msg do 
				if indCount > #theirColor then 
					indCount = 1;
				end
				local char = msg:sub(j, j);
				finalMessage = finalMessage .. theirColor[indCount] .. char;
				indCount = indCount + 1;
			end
		end
		if not dontSend then
			--local roleStr = roleList[roleTracker[GetPlayerIdentifiers(source)[1]]][2]
			local roleStr = exports[CoreName]:GetTag(source) .. ' '
			--TriggerClientEvent('chatMessage', -1, roleStr .. name .. "^7: " .. finalMessage)

			if (sendBlockMessages) then
				sendMsg(source, roleStr .. name, "^7" .. finalMessage, -1);  
			else
				TriggerClientEvent('chatMessage', -1, roleStr .. name, ": ^7" .. finalMessage);
			end 
		end
	elseif has_value(inStaffChat, GetPlayerIdentifiers(source)[1]) and not string.find(args[1], "/") and not (chatNotEnabled[src] ~= nil) then
		CancelEvent()
		msg = "^7[^4StaffChat^7] ^5(^4" .. name .. "^5) ^9" .. msg
		TriggerClientEvent('Permissions:CheckPermsClient', -1, msg)
	end
end)


inStaffChat = {}
RegisterNetEvent("DiscordChatRoles:CheckPerms")
AddEventHandler("DiscordChatRoles:CheckPerms", function(msg)
	-- Check if they have permissions
	--print("It gets to start")
	local src = source
	if IsPlayerAceAllowed(src, "StaffChat.Toggle") then
		TriggerClientEvent('chatMessage', src, msg)
		--print("It gets to end")
	else
		-- Doesn't have perms
	end
end)