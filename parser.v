module ini

pub fn parser(content string) map[string]map[string]string {
	mut section := ''
	mut value := map[string]map[string]string{}

	mut current_line_bk := match true {
		content.contains('\r\n') {
			'\r\n'
		}
		content.contains('\r') {
			'\r'
		}
		else {
			'\n'
		}
	}

	for line in content.split(current_line_bk) {
		if line.len < 3 {
			continue
		}

		current_line := line.trim_left('\t').trim_left(' ')
		if current_line[0] == `#` {
			continue
		}
		if current_line[0] == `[` {
			section = current_line[1..current_line.len_utf8() - 1].trim_space()
			value[section] = map[string]string{}
		} else if current_line.contains('=') {
			mut kv := current_line.split('=')

			key := kv[0].trim_space()
			kv.delete(0)

			kvalue := kv.join('=')

			value[section][key] = kvalue
		}
	}

	return value
}
