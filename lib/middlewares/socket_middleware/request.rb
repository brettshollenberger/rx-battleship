class BattleshipApp
  class SocketMiddleware
    class Request
      class UnprocessableEntityError < StandardError; end

      attr_accessor :request

      def initialize(request={})
        if request.respond_to?(:to_json)
          request = request.to_json
        end

        begin
          @request = ROpenStruct.new(JSON.parse(request))
        rescue
          raise UnprocessableEntityError
        end
      end

      def headers
        request.headers
      end

      def method
        headers.method
      end

      def url
        headers.url
      end

      def body
        request.body
      end
    end
  end
end
