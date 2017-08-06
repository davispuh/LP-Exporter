# encoding: UTF-8
require 'optparse'
require 'tmpdir'
require 'lp/exporter'

module LP
    module Exporter
        # Application module
        module App
            # Parse passed options
            # @return [Hash] options
            def self.getOptions
                options = {
                    :Parser => nil,
                    :LP => nil,
                    :Path => './tmp/',
                    :Files => [],
                    :Lang => false
                }
                options[:Parser] = OptionParser.new do |opts|
                    opts.banner = 'Usage: lp_exporter.rb [options] lp.cab|langpacks'
                    opts.on('-p', '--path dir', 'Path to output directory') do |path|
                        options[:Path] = path
                    end
                    opts.on('-f','--files names', Array, 'Names for files to match') do |files|
                        files.each do |file|
                            options[:Files] << file
                        end
                    end
                    opts.on('-l','--[no-]lang', 'Use language name not LangID from PE') do |lang|
                        options[:Lang] = lang
                    end

                    opts.on_tail('-h', '--help', 'Show this message') do
                        puts opts
                        return false
                    end
                end
                begin
                    options[:LP] = options[:Parser].parse!.first
                rescue OptionParser::ParseError => e
                    $stderr.puts e.message
                    return false
                end
                options
            end

            # Start Application
            def self.start
                options = getOptions
                return false if not options
                if options[:LP].nil?
                    puts options[:Parser].help
                    return false
                end
                Dir.mktmpdir do |tmpdir|
                    cabs = []
                    if File.directory?(options[:LP])
                        cabs += Dir[File.join(options[:LP],'**','*.cab')]
                    else
                        cabs << options[:LP]
                    end
                    cabs.each do |cab|
                        LP::Exporter.process(cab, options[:Files], tmpdir, options[:Path], options[:Lang])
                        puts 'Done for ' + cab
                    end
                end
                true
            end
        end
    end
end
