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
        create_component
        inject_js
        inject_gem
        add_component
      end
      
      def create_component(name, bundle_exec=true)
        `bundle exec volt gem #{@lib_name}`
      end

      def inject_js
        FileUtils.mkdir "volt-#{@lib_name}/app/main/assets/js/#{@lib_name}"
        File.open("#{@lib_name}.js", "wb") do |f|
          f.write(@js)
        end
      end

      def inject_gem  
        `bundle inject #{@volt_gem_name}`
      end
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

