fx_version 'cerulean'
game 'gta5'

author 'Your Name'
description 'QB-Core Vehicle Rental Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'ox_lib'
}

lua54 'yes'

