fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

shared_script '@ox_lib/init.lua'

client_scripts {
    '@menuv/menuv.lua',
    'client/cl_chat.lua',
    'client/cl_chat-tags.lua'
}

server_scripts {
    'config.lua',
    'server/sv_chat.lua'
}

files {
  'html/**'
}

server_exports { 
	"GetDiscordRoles",
	"GetRoleIdFromRoleName",
	"GetDiscordAvatar",
	"GetDiscordName",
	"GetDiscordEmail",
	"IsDiscordEmailVerified",
	"GetDiscordNickname",
	"GetGuildIcon",
	"GetGuildSplash",
	"GetGuildName",
	"GetGuildDescription",
	"GetGuildMemberCount",
	"GetGuildOnlineMemberCount",
	"GetGuildRoleList",
	"ResetCaches",
	"CheckEqual",
    "IsRolePresent",
    "GetRoles"
} 

lua54 "yes"
server_scripts { '@mysql-async/lib/MySQL.lua' }