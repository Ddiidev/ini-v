module ini

import os

pub fn serrialize(content map[string]map[string]string) string {

	mut data := ""
	for section in content.keys() {
		data += "[$section]\n"
		for key in content[section].keys() {
			value := content[section][key]
			data += "$key=$value\n"
		}
	}

	return data
}

pub fn write_ini(content map[string]map[string]string, path string)? {
	os.write_file(path, serrialize(content))?
}

pub fn read_ini(path string) !map[string]map[string]string {
	content := os.read_file(path) or {
		return error("ini file not found")
	}
	return parser(content)
}