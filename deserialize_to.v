module ini

const minimum_length_per_line = 3 // i=1 | [k]

fn parser[T](content string) !T {
	mut data := T{}
	deserialized := deserialize(content)

	$for t in T.fields {
		$if t.typ is $struct {
			data.$(t.name) = field(data.$(t.name), t.name, deserialized[t.name])
		}
	}
	return data
}

fn field[T](arg T, field string, deserialized map[string]string) T {
	mut value := T{}
	$for t in T.fields {
		item := deserialized[t.name]
		$if t.typ is string {
			value.$(t.name) = item.str()
		} $else $if t.typ is int {
			value.$(t.name) = item.trim_space().int()
		} $else $if t.typ is bool {
			value.$(t.name) = item.trim_space().bool()
		} $else $if t.typ is i8 {
			value.$(t.name) = item.trim_space().i8()
		} $else $if t.typ is i16 {
			value.$(t.name) = item.trim_space().i16()
		} $else $if t.typ is i64 {
			value.$(t.name) = item.trim_space().i64()
		} $else $if t.typ is u8 {
			value.$(t.name) = item.trim_space().u8()
		} $else $if t.typ is u16 {
			value.$(t.name) = item.trim_space().u16()
		} $else $if t.typ is u32 {
			value.$(t.name) = item.trim_space().u32()
		} $else $if t.typ is u64 {
			value.$(t.name) = item.trim_space().u64()
		} $else $if t.typ is rune {
			value.$(t.name) = item.rune()
		}
	}
	return value
}
