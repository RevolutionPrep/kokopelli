module Kokopelli
  module HTTP
    module Response

      class Base

        attr_reader :reason
        attr_reader :payload
        attr_reader :request

        public

        def initialize(options = {})
          @payload = options[:payload] if options[:payload]
          @request = options[:request] if options[:request]
          if options[:reason].nil? && options[:request]
            @reason = "#{@request.url} responded."
          else
            @reason = options[:reason] if options[:reason]
          end
        end

      end

    end
  end
end