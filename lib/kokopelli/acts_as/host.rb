module Kokopelli
  module ActsAs
    module Host

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_host(options = {})
          send :include, InstanceMethods
          send :include, Kokopelli::Utilities
          send :include, Kokopelli::ActsAs::SharedMethods
          send :include, Kokopelli::ActsAs::SingletonHost if options[:as] == :singleton
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::Principal::Host.new : Kokopelli::Principal::Host.find(self.read_attribute(:kokopelli_id).to_s))
        end

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAs::Host