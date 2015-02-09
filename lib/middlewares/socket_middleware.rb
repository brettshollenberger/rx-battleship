require "json"

class BattleshipApp
  class SocketMiddleware
    KEEPALIVE_TIME = 15

    def initialize(app, &block)
      instance_eval(&block)
      @app = app
    end

    def call(env)
      if Websocket.websocket?(env)
        initialize_socket(env).rack_response
      else
        @app.call(env)
      end
    end

  private
    def initialize_socket(env={})
      ws = Websocket.new(env, nil, {ping: KEEPALIVE_TIME})

      ws.on :open, &__on_open__(ws)
      ws.on :message, &__on_message__(ws)
      ws.on :close, &__on_close__(ws)

      return ws
    end

    def on_open(ws)
    end

    def on_message(ws, event)
    end

    def on_close(ws)
    end

    def __on_open__(ws)
      proc do
        p "socket opened"
        on_open(ws)
      end
    end

    def __on_message__(ws)
      proc do |event|
        p [:message, event.data]

        ws.send Router.route(event.data)

        on_message(ws, event)
      end
    end

    def __on_close__(ws)
      proc do |event|
        p [:close]
        on_close(ws)
      end
    end
  end
end
