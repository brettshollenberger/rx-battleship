BattleshipApp::SocketMiddleware::Router.draw do
  get "/games" => {:controller => GamesController, :action => "index"}
end
