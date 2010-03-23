module Kokopelli
  module Principal

    class Guest < User

      # ActiveModel Template
      # Class Methods
      private

      def self.principal_type
        "user"
      end

    end

  end
end