fx_version 'cerulean'
description 'ADVANCED HUD SYSTEM'
author 'TS SCRIPTS | THOMAS | LILPUP3'
lua54 'yes'
game 'gta5'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/utils/*.lua',
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/utils/*.lua',
    'server/*.lua',
}

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
}