module Kokopelli
  module ActsAs
    module SingletonHost

      def save(validate = true)
        self.write_attribute(:password, self.kokopelli.password)
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        super(validate)
      end

      def kokopelli
        RAILS_ENV == "production" ? ProductionHost.instance : DevelopmentHost.instance
      end

      class ProductionHost < Kokopelli::Principal::Host
        include Singleton

        def self.instance
          @kokopelli ||= Kokopelli::Principal::Host.find("936149122")
          metaclass = class << @kokopelli; self; end 
          metaclass.send :define_method, :password do
            "64nuMHwn"
          end
          @kokopelli
        end
      end

      class DevelopmentHost < Kokopelli::Principal::Host
        include Singleton

        def self.instance
          @kokopelli ||= Kokopelli::Principal::Host.find("936791107")
          metaclass = class << @kokopelli; self; end 
          metaclass.send :define_method, :password do
            "WO0uQiVX"
          end
          @kokopelli
        end
      end

    end
  end
end