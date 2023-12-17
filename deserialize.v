module ini

// deserialize Deserializes a string in ini format into a map.
//
// Example:
// ```v
// content := r"[conf]
// 	conf1 = true
// "
// c := deserialize(content)
// println(c['conf']['conf1'])
// ```
pub fn deserialize(content string) map[string]map[string]string {
	mut section := ''
	mut value := map[string]map[string]string{}

	current_line_bk := get_skip_line(content)

	for line in content.split(current_line_bk) {
		if line.len < minimum_length_per_line {
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
