require 'rubygems'
require 'bundler/setup'
require_relative "../lib/app.rb"

Bundler.setup("test", :ci)
Bundler.require("test", :ci)

# Load test & support files
Rake::FileList.new("spec/support/**/*.rb", "spec/factories/**/*.rb").each do |f|
  require File.expand_path(File.join(__FILE__, "../../#{f}"))
end

RSpec.configure do |config|
  config.after(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each, :logsql) do
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  config.after(:each, :logsql) do
    ActiveRecord::Base.logger = nil
  end
end
