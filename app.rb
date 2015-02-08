require "sinatra/base"

class BattleshipApp < Sinatra::Base
  get "/" do
    erb :"index.html"
  end
end
