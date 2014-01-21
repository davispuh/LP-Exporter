# LP-Exporter

Application to export language data from Microsoft language pack lp.cab files

## Installation

`gem install lp-exporter`

### Dependencies

gems:

* `libmspack` (required)

## Usage

for command information use `-h` or `--help` flag

`lp_exporter -h`

```
Usage: lp_exporter.rb [options] lp.cab|langpacks
    -p, --path dir                   Path to output directory
    -f, --files names                Names for files to match
    -l, --[no-]lang                  Use language name not LangID from PE
    -h, --help                       Show this message
```

* `-p, --path` Path to output directory, example `-p "./tmp"`
* `-f, --files` comma separated list with file names in cab, example `-f ntprint,pnpui`
* `-l, --[no-]lang` will use `en-us` for langauge name rather than `1033`

## Code status

[![Dependency Status](https://gemnasium.com/davispuh/ruby-libmspack.png)](https://gemnasium.com/davispuh/ruby-libmspack)
[![Code Climate](https://codeclimate.com/github/davispuh/ruby-libmspack.png)](https://codeclimate.com/github/davispuh/ruby-libmspack)

## Unlicense

![Copyright-Free](http://unlicense.org/pd-icon.png)

All text, documentation, code and files in this repository are in public domain (including this text, README).
It means you can copy, modify, distribute and include in your own work/code, even for commercial purposes, all without asking permission.

[About Unlicense](http://unlicense.org/)

## Contributing

Feel free to improve anything.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


**Warning**: By sending pull request to this repository you dedicate any and all copyright interest in pull request (code files and all other) to the public domain. (files will be in public domain even if pull request doesn't get merged)

Also before sending pull request you acknowledge that you own all copyrights or have authorization to dedicate them to public domain.

If you don't want to dedicate code to public domain or if you're not allowed to (eg. you don't own required copyrights) then DON'T send pull request.

