require "faye/websocket"

class BattleshipApp
  class SocketMiddleware
    class Websocket < Faye::WebSocket
    end
  end
end
