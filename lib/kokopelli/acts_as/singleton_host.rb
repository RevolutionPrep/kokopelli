module Kokopelli
  module ActsAs
    module SingletonHost
      
      def self.append_features(base)
        base.class_eval "alias_method :ar_save, :save" unless base.method_defined?(:ar_save)
        super
      end

      def save(validate = true)
        puts "SingletonHost#save"
        self.write_attribute(:password, self.kokopelli.password)
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        ar_save(validate)
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
            KOKOPELLI[:host_password]
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
            KOKOPELLI[:host_password]
          end
          @kokopelli
        end
      end

    end
  end
end