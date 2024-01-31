
# Ini

Simple and practical module for manipulating ini/cfg file.


## Documentation

You can access the documentation [here](https://Ddiidev.github.io/ini-v/).

## Install

```bash
  v install Ddiidev.ini
```

Or

```bash
  v install https://github.com/Ddiidev/ini-v
```
## Usage

```v
import ldedev.ini // or "import ini" depends on how it was installed.

struct Keys {
pub:
    peoples struct {
        p1 string
        p2 string
    }
    ages struct {
        a1 int
        a2 int
    }
}

const s = r'[peoples]
p1=André
p2=Luiz
[ages]
a1=26
a2=29
'

fn main() {
    k := ini.reader_to[Keys](s)!

    dump(k)
}
```

result:
```
[.\\teste.v:26] k: Keys{
    peoples: struct {
        p1: 'André'
        p2: 'Luiz'
    }
    ages: struct {
        a1: 26
        a2: 29
    }
}
```


## Functionalities

- "read_ini" to map
- "serrialize" to string
- "write_ini" to file ini
- "deserialize" string to file ini
- "reader_to[T]" file/content for type T

_It is still not possible to write a T object to the ini file._


## Licença

[MIT](https://choosealicense.com/licenses/mit/)

