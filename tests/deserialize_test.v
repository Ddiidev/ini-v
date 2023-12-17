module tests

import ini { deserialize , serrialize }

fn test_parser_simples() {

	ini_str := r'
		[conf]
		key=value
		key2=value2
	'

	result := deserialize(ini_str)

	assert 'conf' in result
	assert 'key' in result['conf']
	assert 'key2' in result['conf']
}


fn test_double_section() {

	ini_str := r'
		[conf]
		key=value
		key2=value2

		[conf2]
		key=test1
		key2=test2
	'

	result := deserialize(ini_str)

	assert result.len == 2
	assert 'key2' in result['conf']
	assert 'key2' in result['conf2']
	assert result['conf2']['key2'] == 'test2'
}

fn test_with_space() {

	ini_str := r'
		[ conf ]
		key= value
		key2       =value2
	'

	result := deserialize(ini_str)

	assert result['conf']['key'] == ' value'
	assert result['conf']['key2'] == 'value2'
}
