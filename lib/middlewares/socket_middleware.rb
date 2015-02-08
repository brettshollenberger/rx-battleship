require "faye/websocket"
require "json"

class BattleshipApp
  class SocketMiddleware
    KEEPALIVE_TIME = 15

    def initialize(app)
      @app = app
    end

    def is_websocket_request?(env)
      websocket_class.websocket?(env)
    end

    def call(env)
      if is_websocket_request?(env)
        ws = websocket_class.new(env, nil, {ping: KEEPALIVE_TIME})

        ws.on :open do
          print "socket opened"
          SocketMiddleware.clients << ws

          ws.send RoomsController.index
        end

        ws.on :message do |event|
          p [:message, event.data]

          request     = JSON.parse(event.data)
          method      = request["headers"]["method"]
          url         = request["headers"]["url"]
          body        = RecursiveOpenStruct.new(request["body"])
          body.socket = ws

          route = SocketRouter.route(method, url)

          ws.send(route.controller.send(route.action, body))
        end

        ws.on :close do |event|
          p [:close]
          @clients.delete(ws)
        end

        ws.rack_response
      else
        @app.call(env)
      end
    end

  private
    def websocket_class
      Faye::WebSocket
    end
  end
end
