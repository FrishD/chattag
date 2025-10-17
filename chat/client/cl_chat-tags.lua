local MenuOpened = false
local TagMenu = MenuV:CreateMenu(false, Config.ChatRoles.Menu.Design.Header, 'topcenter', Config.ChatRoles.Menu.Design.Color.r, Config.ChatRoles.Menu.Design.Color.g, Config.ChatRoles.Menu.Design.Color.b, 'size-'..tostring(Config.ChatRoles.Menu.Design.Size)..'')
local SelectedTag = Config.ChatRoles.DefaultTag

function SelectTag(ID)
    TriggerServerEvent('ChatRoles:Change', ID)
end

Citizen.CreateThread(function()
    Citizen.Wait(500)
    TriggerServerEvent('ChatRoles:Joined')
end)

RegisterNetEvent('ChatRoles:Return')
AddEventHandler('ChatRoles:Return', function(Found, Roles)
    local Role, ChangeTag = nil, nil
    if Found then
        for i = 1, #Roles do
            ChangeTag = TagMenu:AddButton({icon = 'CHAR_DEFAULT', label = Roles[i].Name, description = 'Press [Enter] To Select ' ..Roles[i].Name.. ''})
            ChangeTag:On('select', function()
                SelectTag(Roles[i].ID)
                notify('Tag Selected!')
            end)
        end
    end
end)

TagMenu:On('open', function()
    TagMenu:ClearItems()
    TriggerServerEvent('ChatRoles:Get')
end)

TagMenu:On('close', function()
    MenuOpened = false
end)

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end

RegisterCommand(Config.ChatRoles.Menu.OpenCommand, function()
    if not MenuOpened then
        TagMenu:Open()
        MenuOpened = true
    else
        TagMenu:Close()
        MenuOpened = false
    end
end)

RegisterKeyMapping(Config.ChatRoles.Menu.OpenCommand, 'Chat Roles', 'keyboard', Config.ChatRoles.Menu.Keybind)