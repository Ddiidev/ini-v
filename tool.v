module ini

@[inline]
fn get_skip_line(content &string) string {
	return match true {
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
}