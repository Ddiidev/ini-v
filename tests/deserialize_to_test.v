module tests

import ini { reader_to }


struct KeysIniAnon {
pub:
	conf struct {
		pub:
			conf1 string
			conf2 int
	}
	password struct {
		pub:
			pass1 string
			valid bool
	}
}

struct KeysIni {
pub:
	conf Conf
	password Passwords
}

struct Conf {
pub:
	conf1 string
	conf2 int
}

struct Passwords {
pub:
	pass1 string
	valid bool
}

const str_ini = r'
		[conf]
		conf1=123
		conf2= 321
		teste=false

		[password]
		pass1= 12345
		valid=?
	'

fn test_parser_valid_true() {
	local_ini := str_ini.replace('?', 'true')
	i1 := reader_to[KeysIni](local_ini)!
	i2 := reader_to[KeysIniAnon](local_ini)!

	assert i1.conf.conf1 == '123'
	assert i1.conf.conf2 == 321
	assert i1.password.pass1 == ' 12345'
	assert i1.password.valid == true

	assert i2.conf.conf1 == '123'
	assert i2.conf.conf2 == 321
	assert i2.password.pass1 == ' 12345'
	assert i2.password.valid == true
}
