fx_version 'cerulean'
game 'gta5' 

author 'vmojolip'
description 'vmojolip-rent'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css.css',
    'html/script.js',
    'html/img/*.png'
}

shared_scripts {
    'config.lua'
}

client_scripts {
	'client.lua'
}
server_scripts {
    'server.lua'
}