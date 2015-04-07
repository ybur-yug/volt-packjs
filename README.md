# Volt-Packjs

A simple means to package JS for volt in a modular way.

## Installation

Run Gemfile:

    gem install 'volt-javapack'

## Usage

`volt-javapack js_lib_name github_un url_to_src`

This does a couple things.

1. Creates a Volt gem that contains your js lib code in it's assets
2. Adds it to your projects Gemfile - defaulting to github for src
3. Publishes it to Rubygems (if possible)

Now, you will have all the assets, and you simply have just added a single component. All you need to do now is add the line:

`component 'js_lib_name'`

To `dependencies.rb` and you have the code inside.

I did this because I found myself making Volt gems quite often and I just wanted an automatic means to write everything
and get it published

## Contributing

1. Fork it ( https://github.com/rhgraysonii/volt-javapack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
