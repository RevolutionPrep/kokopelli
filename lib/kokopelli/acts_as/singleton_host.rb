module Kokopelli
  module ActsAs
    module SingletonHost
      
      def self.append_features(base)
        base.class_eval "alias_method :ar_save, :save" unless base.method_defined?(:ar_save)
        base.class_eval "alias_method :ar_destroy, :destroy" unless base.method_defined?(:ar_destroy)
        super
      end

      def save(validate = true)
        self.kokopelli.save
        self.write_attribute(:kokopelli_password, self.kokopelli.password)
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        ar_save(validate)
      end
      
      def destroy
        ar_destroy
      end

      def kokopelli
        case RAILS_ENV
        when "production"
          ProductionHost.instance
        when "development"
          DevelopmentHost.instance
        when "qa"
          QAHost.instance
        end
      end

      class ProductionHost < Kokopelli::Principal::Host
        include Singleton

        def self.instance
          @kokopelli ||= Kokopelli::Principal::Host.find(KOKOPELLI[:singleton_id].to_s)
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
          @kokopelli ||= Kokopelli::Principal::Host.find(KOKOPELLI[:singleton_id].to_s)
          metaclass = class << @kokopelli; self; end 
          metaclass.send :define_method, :password do
            KOKOPELLI[:host_password]
          end
          @kokopelli
        end
      end
      
      class QAHost < Kokopelli::Principal::Host
        include Singleton

        def self.instance
          @kokopelli ||= Kokopelli::Principal::Host.find(KOKOPELLI[:singleton_id].to_s)
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