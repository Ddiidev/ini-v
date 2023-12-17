module ini

import os

// reader_to[T] Deserialize the file or contents of the ini format to a struct.
//
// Example:
// ```v
// struct Keys {
// pub:
// 	conf struct {
// 	pub:
// 		conf1 bool
// 	}
// }
// content := r"[conf]
// 	conf1 = true
// "
// c := reader_to[Keys](content)!
// println(c.conf.conf1)
// ```
pub fn reader_to[T](pathOrContent string) !T {
	mut data := T{}
	
	if os.exists(pathOrContent) {
		content := os.read_file(pathOrContent) or {
			return error("ini file not found")
		}
		data = parser[T](content)!
	} else if pathOrContent.len > 5 {
		data = parser[T](pathOrContent)!
	}

	return data
}