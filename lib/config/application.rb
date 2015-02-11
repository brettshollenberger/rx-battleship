require 'yaml'
require 'rubygems'
require 'bundler/setup'

env = ENV["SINATRA_ENV"] || "development"

Bundler.setup(:default, :ci)
Bundler.require(:default, :ci)

Bundler.setup(env, :ci)
Bundler.require(env, :ci)

ActiveRecord::Base.configurations = YAML.load_file(
  File.expand_path(
    File.join(__FILE__, "../database.yml")
  )
)

environments = env == "production" ? %w(production) : %w(development test)

environments.each do |env|
  ActiveRecord::Base.establish_connection(
    ActiveRecord::Base.configurations[env]
  )
end

