require "rails_helper"

if ENV['RUN_COVERAGE']
  require 'simplecov'
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.configure do |config|
    config.path_prefix = "discourse" #the root of your Rails application relative to the repository root
    config.git_dir = "plugins/herrd-discourse" #the relative or absolute location of your git root compared to where your tests are run
  end
  SimpleCov.add_filter "discourse/app"
  SimpleCov.add_filter "discourse/lib"
  CodeClimate::TestReporter.start
  FakeWeb.allow_net_connect = %r[^https?://codeclimate.com]
end

path = "./plugins/herrd-discourse/plugin.rb"
source = File.read(path)
plugin = Plugin::Instance.new(Plugin::Metadata.parse(source), path)
plugin.activate!
plugin.initializers.first.call
