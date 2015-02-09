require "json"

class BattleshipApp
  class SocketMiddleware
    KEEPALIVE_TIME = 15

    class << self
      attr_accessor :clients
    end

    @clients = {} 

    def initialize(app)
      @app = app
    end

    def call(env)
      if Websocket.websocket?(env)
        initialize_socket(env).rack_response
      else
        @app.call(env)
      end
    end

    def initialize_socket(env={})
      ws = Websocket.new(env, nil, {ping: KEEPALIVE_TIME})

      ws.on :open, &on_open(ws)
      ws.on :message, &on_message(ws)
      ws.on :close, &on_close(ws)

      return ws
    end

    def on_open(ws)
      proc do
        p "socket opened"
      end
    end

    def on_message(ws)
      proc do |event|
        p [:message, event.data]

        request     = JSON.parse(event.data)
        method      = request["headers"]["method"]
        url         = request["headers"]["url"]
        body        = RecursiveOpenStruct.new(request["body"])
        body.socket = ws

        route = Router.route(method, url)

        ws.send(route.controller.send(route.action, body))
      end
    end

    def on_close(ws)
      proc do |event|
        p [:close]
        @clients.delete(ws)
      end
    end
  end
end
