#require "volt/javapack/version"
require 'net/http'
require 'fileutils'

module Volt
  module Javapack

    class JSWrite
      attr_accessor :js
      attr_accessor :lib_name
      attr_accessor :volt_gem_name

      def initialize js, lib_name
        @js = js 
        @lib_name = lib_name
        @volt_gem_name = "volt-#{@lib_name}"
        create_component @lib_name
        inject_js
        # inject_gem
      end
      
      def create_component(name, bundle_exec=true)
        `bundle exec volt gem #{@lib_name}`
      end

      def inject_js
        assets_path = "volt-#{@lib_name}/app/#{@lib_name}/assets/js/"
        FileUtils.mkdir assets_path + "#{@lib_name}"
        File.open("#{assets_path}/#{@lib_name}.js", "wb") do |f|
          f.write(@js)
        end
      end

      def build_gem
        `cd #{@volt_gem_name}`
        `gem build #{@volt_gem_name}.gemspec`
        `gem install #{@volt_gem_name}-0.0.1.gem`
      end

      #def inject_gem  
      #  `bundle inject #{@volt_gem_name}`
      #end
    end

    class JSGrab
      attr_accessor :js

      def initialize(js_url)
        puts js_url.to_s + " INITIALIZER"
        @js = get_js(js_url)
      end

      def get_js(js_url) 
        puts js_url.to_s + " GET_JS"
        if check_uri(js_url)
          Net::HTTP.get(URI(js_url))
        else
          puts "Please only use uris linking directly to the JS lib in question"
          nil 
        end
      end

      def check_uri(js_uri)
        puts js_uri.to_s + " GET_JS"
        js_uri ? js_uri.to_s[-3..-1] == '.js' : false
      end
    end
  end
end

