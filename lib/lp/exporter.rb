# encoding: UTF-8
require 'libmspack'
require 'pedump'
require 'fileutils'
require 'yaml'
require 'lp/exporter/version'

# Language Pack module
module LP
    # Exporter module
    module Exporter
        # Start extracting cab
        # @param [String] cab filename of cab
        # @param [Array] files list of names for files to match from cab
        # @param [String] tmpdir path to directory where keep extracted cab files
        # @param [String] path path to output location
        # @param [Boolean] lang if should use language name rather than LangID
        def self.process(cab, files, tmpdir, path, lang)
            files = extract(cab, files, tmpdir)
            files.each do |base, entries|
                entries.each do |entry|
                    export(path, entry, lang)
                end
                puts 'Exported ' + base
            end
        end

        # Extract cab
        # @param [String] cab filename of cab
        # @param [Array] files list of names for files to match from cab
        # @param [String] dir path to directory where keep extracted cab files
        # @return [Hash] Info about extracted files
        def self.extract(cab, files, dir)
            decompressor = LibMsPack::CabDecompressor.new
            cab = decompressor.open(cab)
            file = cab.files
            fileList = {}
            begin
                pathname = file.getFilename.gsub('\\', '/')
                path = Pathname.new(pathname)
                next unless path.extname == '.mui'
                realname = path.basename('.*')
                found = (files.count == 0)
                files.each do |str|
                    if realname.fnmatch?(str + '*', File::FNM_DOTMATCH | File::FNM_PATHNAME | File::FNM_CASEFOLD)
                        found = true
                        break
                    end
                end
                next unless found
                nameparts = realname.to_s.split('.')
                base = nameparts.first
                namelen = nameparts.length
                namelen -= 1 if nameparts[-1] == 'dll'
                name = nameparts[0, namelen].join('.')
                data = path.dirname.basename.to_s.split('_')
                arch = data[0]
                lang = data[-2]
                newName = [lang, arch, realname].join('_')

                location = File.join(dir, base, newName)
                fileList[base] ||= []
                fileList[base] << [name, lang, arch, location]
                FileUtils.mkdir_p(File.join(dir, base))
                decompressor.extract(file, location)
            end until (file = file.next).nil?
            decompressor.close(cab)
            decompressor.destroy
            fileList
        end
        
        # Export strings from file to YAML
        # @param [String] path path to output location
        # @param [Array] entry info about file
        # @param [Boolean] lang if should use language name rather than LangID
        def self.export(path, entry, lang = false)
            filepath = File.join(path, entry.first)+'.yaml'
            data = {}
            data = YAML.load_file(filepath) if File.exists?(filepath)
            langName = entry[1]
            File.open(entry.last, 'rb') do |file|
                PEdump.new(file).strings.each do |str|
                    langName = str.lang unless lang
                    data[langName] ||= {}
                    data[langName][str.id] = str.value
                end
	    end
	    File.write(filepath, Hash[data.to_a.sort_by { |d| d.first } ].to_yaml)
        end
    end
end
