fx_version 'cerulean'
games { 'gta5' }

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',

  'server/main.lua'
}

client_scripts {
  'client/main.lua'
}

ui_page 'nui/index.html'

files {
  'nui/index.html',
  'nui/*.png',
  'nui/js/*.js',

}