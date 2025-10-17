local chatInputActive = false
local chatInputActivating = false
local chatHidden = true
local chatLoaded = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')


RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:messageEntered')

AddEventHandler('__cfx_internal:serverPrint', function(msg)	
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			templateId = 'print',
			multiline = true,
			args = { msg }
		}
	})
end)

local chatStatus;
chatStatus = true;

RegisterCommand("chat", function()
	if chatStatus then
		chatStatus = false
		chatStatus2 = "^1Disabled"
	else
		chatStatus = true
		chatStatus2 = "^2Enabled"
	end
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = {
			template = '<div style="padding: 0.1vw; margin: 0.1vw; background-color: rgba(11, 51, 212, 0.5); width: auto; box-shadow: 0px 0px 4px rgba(11, 51, 212, 0.5); border-radius: 50px;"><i class="fa-solid fa-circle-exclamation"></i> {0}: {1}</div>',
			args = { "SYSTEM", "Chat has been " .. tostring(chatStatus2)}
		}
	})
end)

AddEventHandler('chat:addMessage', function(message)
	if chatStatus then
		SendNUIMessage({
			type = 'ON_MESSAGE',
			message = message
		})
	end
end)

AddEventHandler('chat:addMessagesv', function(message)
	SendNUIMessage({
		type = 'ON_MESSAGE',
		message = message
	})
end)


AddEventHandler('chat:addSuggestion', function(name, help, params)
	SendNUIMessage({
		type = 'ON_SUGGESTION_ADD',
		suggestion = {
			name = name,
			help = help,
			params = params or nil
		}
	})
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
	for _, suggestion in ipairs(suggestions) do
		SendNUIMessage({
			type = 'ON_SUGGESTION_ADD',
			suggestion = suggestion
		})
	end
end)

AddEventHandler('chat:removeSuggestion', function(name)
	SendNUIMessage({
		type = 'ON_SUGGESTION_REMOVE',
		name = name
	})
end)

AddEventHandler('chat:addTemplate', function(id, html)
	SendNUIMessage({
		type = 'ON_TEMPLATE_ADD',
		template = {
			id = id,
			html = html
		}
	})
end)

AddEventHandler('chat:clear', function(name)
	SendNUIMessage({
		type = 'ON_CLEAR'
	})
end)

local canSendMessage = true
RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)
	
	if not data.canceled then
		local id = PlayerId()
		
		--deprecated
		local r, g, b = 0, 0x99, 255
		
		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			
			if canSendMessage then
				TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
				
				
			end
			
		end
	end
	
	cb('ok')
end)

local function refreshCommands()
	if GetRegisteredCommands then
		local registeredCommands = GetRegisteredCommands()
		
		local suggestions = {}
		
		for _, command in ipairs(registeredCommands) do
			if IsAceAllowed(('command.%s'):format(command.name)) then
				table.insert(suggestions, {
					name = '/' .. command.name,
					help = ''
				})
			end
		end
		
		TriggerEvent('chat:addSuggestions', suggestions)
	end
end

local function refreshThemes()
	local themes = {}
	
	for resIdx = 0, GetNumResources() - 1 do
		local resource = GetResourceByFindIndex(resIdx)
		
		if GetResourceState(resource) == 'started' then
			local numThemes = GetNumResourceMetadata(resource, 'chat_theme')
			
			if numThemes > 0 then
				local themeName = GetResourceMetadata(resource, 'chat_theme')
				local themeData = json.decode(GetResourceMetadata(resource, 'chat_theme_extra') or 'null')
				
				if themeName and themeData then
					themeData.baseUrl = 'nui://' .. resource .. '/'
					themes[themeName] = themeData
				end
			end
		end
	end
	
	SendNUIMessage({
		type = 'ON_UPDATE_THEMES',
		themes = themes
	})
end

AddEventHandler('onClientResourceStart', function(resName)
	Wait(500)
	
	refreshCommands()
	refreshThemes()
end)

AddEventHandler('onClientResourceStop', function(resName)
	Wait(500)
	
	refreshCommands()
	refreshThemes()
end)

RegisterNUICallback('loaded', function(data, cb)
	TriggerServerEvent('chat:init');
	
	refreshCommands()
	refreshThemes()
	
	chatLoaded = true
	
	cb('ok')
end)
Citizen.CreateThread(
function()
	SetTextChatEnabled(false)
	SetNuiFocus(false)
	local function keybind(name, key, cb)
		RegisterCommand("+" .. name, function()
			cb()
		end)
		RegisterCommand("-" .. name, function()
			cb()
		end)
		RegisterKeyMapping("+" .. name, name, 'keyboard', key)
	end
	keybind("chatOpen", "t", function()
		if not chatInputActive then
			if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
			chatInputActive = true
			chatInputActivating = true
			
			SendNUIMessage(
			{
				type = "ON_OPEN"
			}
		)
	end
end
end)
while true do
	Citizen.Wait(250)
	if chatLoaded then
		local shouldBeHidden = false
		
		if _G.active then
			shouldBeHidden = true
		end
		
		if (shouldBeHidden and not chatHidden) or (not shouldBeHidden and chatHidden) then
			chatHidden = shouldBeHidden
			
			SendNUIMessage(
			{
				type = "ON_SCREEN_STATE_CHANGE",
				shouldHide = shouldBeHidden
			}
		)
	end
	
	if chatInputActivating then
		if not IsControlPressed(0, 245) then
			SetNuiFocus(true)
			
			chatInputActivating = false
		end
	end
else
	Citizen.Wait(500)
end
end
end
)


Citizen.CreateThread(function()
	while true do
		_G.active = (IsScreenFadedOut() or IsPauseMenuActive())
		Citizen.Wait(1000)
	end
end)