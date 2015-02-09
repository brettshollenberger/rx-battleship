require "ostruct"

class BattleshipApp
  class SocketMiddleware
    class Router
      @routes = {}

      def self.draw(&block)
        instance_eval &block
      end

      %w(get post put delete).each do |method|
        define_singleton_method method do |options|
          options.each do |k, v|
            @routes[{:method => method.to_sym, :url => k}] = v
          end
        end
      end

      def self.route(request)
        request = Request.new(request)
        route   = OpenStruct.new @routes[{:method => request.method.downcase.to_sym, 
                                          :url    => request.url}]

        route.controller.send(route.action, request.body)
      end
    end
  end
end
