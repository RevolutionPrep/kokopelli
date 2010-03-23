module Kokopelli
  module HTTP
    module Response

      class Indeterminant < Base

        public

        def initialize(options = {})
          super
          set_reason(options[:request]) if options[:request]
        end

        private

        def set_reason(request)
          @reason = "Indeterminant Request: url(#{request.url})"
        end

      end

    end
  end
end