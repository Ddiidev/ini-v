module tests

import os
import ini { deserialize, read_ini, serrialize, write_ini }

const ini_file_temp = 'temp_ini/test.ini'

fn test_serrialize() {
	restart()

	ini_str := r'
		[conf]
		key=value
		key2= value2
	'

	pini := deserialize(ini_str)

	ini_read := serrialize(pini)

	assert ini_read.contains('[conf]')
	assert ini_read.contains('key=value')
	assert ini_read.contains('key2= value2')

	restart()
}

fn test_read_ini() {
	restart()

	ini_str := r'
		[conf]
		key=value
		key2= value2

		[new_conf]
		key1= my_key
		key2= my_key2
	'
	os.write_file(tests.ini_file_temp, ini_str) or {
		panic('could not write ${tests.ini_file_temp}')
	}

	pini := read_ini(tests.ini_file_temp) or { panic('could not read ${tests.ini_file_temp}') }

	assert pini.len == 2
	assert pini['conf'].len == 2
	assert pini['new_conf'].len == 2
	restart()
}

fn test_write_ini() {
	restart()

	mut mini := map[string]map[string]string{}

	mini['conf'] = {
		'key':  'value'
		'key2': ' value2'
	}

	write_ini(mini, tests.ini_file_temp) or { panic('could not write ${tests.ini_file_temp}') }

	pini := read_ini(tests.ini_file_temp) or { panic('could not read ${tests.ini_file_temp}') }

	assert os.exists(tests.ini_file_temp)
	assert pini.len == 1
	assert pini['conf'].len == 2

	restart()
}

fn restart() {
	if !os.exists('temp_ini') {
		os.mkdir('temp_ini') or { panic('temp_ini directory already exists') }
	} else {
		if os.exists(tests.ini_file_temp) {
			os.rm(tests.ini_file_temp) or { panic('could not remove temp ini file') }
		}
		os.rmdir('temp_ini') or { panic('could not remove temp_ini directory') }
	}
}
