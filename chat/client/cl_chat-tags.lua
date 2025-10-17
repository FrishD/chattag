Citizen.CreateThread(function()
    -- Wait for the Config and MenuV to be available
    while Config == nil or Config.ChatRoles == nil or MenuV == nil do
        Citizen.Wait(100)
    end

    -- All variables are local to this thread to prevent scope issues
    local MenuOpened = false
    local TagMenu = MenuV:CreateMenu(false, Config.ChatRoles.Menu.Design.Header, 'topcenter', Config.ChatRoles.Menu.Design.Color.r, Config.ChatRoles.Menu.Design.Color.g, Config.ChatRoles.Menu.Design.Color.b, 'size-'..tostring(Config.ChatRoles.Menu.Design.Size)..'')
    local SelectedTag = Config.ChatRoles.DefaultTag

    -- All functions are local to this thread
    local function notify(msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(true, false)
    end

    local function SelectTag(ID)
        TriggerServerEvent('ChatRoles:Change', ID)
    end

    -- All event handlers are registered inside this thread
    RegisterNetEvent('ChatRoles:Return')
    AddEventHandler('ChatRoles:Return', function(Found, Roles)
        TagMenu:ClearItems()
        if Found then
            for i = 1, #Roles do
                local ChangeTag = TagMenu:AddButton({icon = 'CHAR_DEFAULT', label = Roles[i].Name, description = 'Press [Enter] To Select ' .. Roles[i].Name})
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

    -- All commands are registered inside this thread
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

    -- Trigger the initial server event only after everything is set up
    TriggerServerEvent('ChatRoles:Joined')
end)