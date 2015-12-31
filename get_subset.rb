require 'optparse'
opt = OptionParser.new

@exclude = Array.new

opt.on('--exclude VAL') do |v|
  @exclude << File.expand_path( v )
end

def get_text_from_files(target_dir)
  text = String.new
  unless @exclude.index( File.expand_path( target_dir ) ) then
    begin
      Dir.chdir( target_dir ) do
        Dir.foreach( '.' ) do |item|
          next if item == "." or item == ".."
          if File.directory?( item ) then
            text << get_text_from_files( item )
          else
            #TODO: Make this user-specifiable.
            if item.match( /.*erb|.*rb|.*js|.*html|.*txt/ ) then
              text << File.read( item )
            end
          end
        end
      end
    rescue
      puts 'Directory not found: ' + target_dir
      exit 1
    end
  end
  return text
end

def exit_usage
  puts "usage: ruby ./get-subset <directory> [--exclude directory]"
  exit 1
end

argv = opt.parse ARGV
if argv.length < 1 || ARGV.length < 1 then
  exit_usage
end

obtained_text = String.new
argv.each do |arg|
  obtained_text << get_text_from_files( arg )
end
puts obtained_text.chars.sort.join.scrub.squeeze.gsub(/\n/, "").gsub(/\t/, "").gsub(/\ /, "")
