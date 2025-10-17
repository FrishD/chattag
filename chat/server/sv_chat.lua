RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end


    TriggerEvent('chatMessage', source, author, message)
end, false)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
        TriggerClientEvent('chatMessage', -1, name, { 255, 255, 255 }, '/' .. command) 
    end

    CancelEvent()
end)

--[[AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.4vw; margin: 0.4vw; width: 100px; min-width: fit-content; background-color: rgba(109, 0, 0, 0.4); border: 1.5px solid rgb(109, 0, 0); border-radius: 5px;"><i class="fas fa-users"></i> <b>'.. GetPlayerName(source) ..'</b> <i>has left the server!</i></div>'
    })
end)]]

-- command suggestions for clients
local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}

        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    name = '/' .. command.name,
                    help = ''
                })
            end
        end

        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    refreshCommands(source)
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)

    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)


RegisterCommand('clearall', function(source)
    if exports[CoreName]:HasRole(source, "Staff") or exports[CoreName]:HasRole(source, "Co-Owner") or exports[CoreName]:HasRole(source, "Owner") then
        TriggerClientEvent('chat:clear', -1)
		Wait(1000)
		TriggerClientEvent('chat:addMessage', -1, {template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0,0,0,0.5); border: 2px solid rgba(255,255,255,0.5); border-radius: 5px;"><i class="fas fa-exclamation-circle"></i></i> {0}</div>', args = {"The chat was cleared by "..GetPlayerName(source).." (ID - "..source..")"}})
    else
		lib.notify(source, {
            title = "Error",
            description = "You Do Not Have Permisson To Do This!",
            type = "error",
            position = 'top-right'
        })
    end 
end)

RegisterCommand('clear', function(source)
	TriggerClientEvent('chat:clear', source)
	lib.notify(source, {
		title = "Success",
		description = "Chat Cleared!",
		type = "success",
		position = 'top-right'
	})
end)
