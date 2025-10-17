fx_version 'adamant'
game 'gta5'

author 'xv'

shared_script '@fiveguard/shared_fg-obfuscated.lua'
shared_script '@fiveguard/ai_module_fg-obfuscated.lua'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'sv_chat-tags.lua'
}

client_scripts {
    '@menuv/menuv.lua',
    'config.lua',
    'cl_chat-tags.lua'
}

depends_on {
    'chat'
}