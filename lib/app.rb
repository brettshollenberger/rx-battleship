require "sinatra/base"
require_relative "./config/application.rb"

class BattleshipApp < Sinatra::Base
  get "/" do
    erb :"index.html"
  end
end
