fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

shared_script '@ox_lib/init.lua'

client_script 'client/*.lua'

server_script 'config.lua'

server_script 'server/*.lua'

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
	"CheckEqual"
} 

server_export "IsRolePresent"
server_export "GetRoles"

lua54 "yes"