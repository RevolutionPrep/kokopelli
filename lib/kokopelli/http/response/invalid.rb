module Kokopelli
  module HTTP
    module Response

      class Invalid < Base

        public

        def initialize(options = {})
          super
          set_reason(options[:request]) if options[:request]
        end

        private

        def set_reason(request)
          @reason = "Invalid Request: url(#{request.url}) field(#{request.invalid_field}) type(#{request.invalid_type}) subcode(#{request.invalid_subcode})"
        end

      end

    end
  end
end