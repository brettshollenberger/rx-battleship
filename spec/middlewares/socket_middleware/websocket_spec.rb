require "spec_helper"

describe BattleshipApp::SocketMiddleware::Websocket do
  describe "Websocket Upgrade Requests" do
    def websocket_request_env
      { 
        "HTTP_UPGRADE" => "websocket", 
        "HTTP_CONNECTION" => "upgrade",
        "REQUEST_METHOD" => "GET" 
      }
    end

    it "knows when a request is a websocket request" do
      expect(BattleshipApp::SocketMiddleware::Websocket.websocket?(websocket_request_env))
        .to be true
    end

    it "knows when a request is not a websocket request" do
      expect(BattleshipApp::SocketMiddleware::Websocket.websocket?({}))
        .to be false
    end
  end
end
