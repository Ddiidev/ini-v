module ini

import os

// serrialize Serialize map ini into string in ini format.
//
// Example:
// ```v
// c := reader_ini('./file.ini')!
// s := serrialize(c)
// println(s)
// ```
pub fn serrialize(content map[string]map[string]string) string {
	mut data := ''
	for section in content.keys() {
		data += '[${section}]\n'
		for key in content[section].keys() {
			value := content[section][key]
			data += '${key}=${value}\n'
		}
	}

	return data
}

// write_ini writes the ini object to an ini format file.
//
// Example:
// ```v
// mut c := reader_ini('./file.ini')!
// c['conf']['conf1'] = 'false'
// write_ini(c, './file.ini')
// // OR
// write_ini({
// 	'conf': {
// 		'conf1': 'false'
// 	}	
// }, './file.ini')!
// ```
pub fn write_ini(content map[string]map[string]string, path string) ! {
	os.write_file(path, serrialize(content))!
}

// reader_ini Deserialize the file of the ini format to map.
//
// Example:
// ```v
// c := reader_ini('./file.ini')!
// println(c['conf']['conf1'])
// ```
pub fn read_ini(content_or_path string) !map[string]map[string]string {
	content := os.read_file(content_or_path) or { return error('ini file not found') }
	return deserialize(content)
}
