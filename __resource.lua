resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description '[ESX] Airlinepilot'
version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'client/menus.lua',
	'client/misc.lua',
	'client/main.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/main.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua'
}