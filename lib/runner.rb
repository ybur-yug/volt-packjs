require './lib/volt/javapack'

begin
  lib_name = ARGV[0]
  url = ARGV[1]
  getter = Volt::Javapack::JSGrab.new url
  puts "getting JavaScript....."
  js = getter.get_js url
  writer = Volt::Javapack::JSWrite.new(js, lib_name)

  puts "A gem has been created as a Volt component with the JS in the assets"
  puts "It has also been added to your Gemfile"
  puts "In to finalize installation, you must publish it to github"
  puts "It currently sources from there. In the Gemfile"
rescue
  puts "something went wrong."
end

