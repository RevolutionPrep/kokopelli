module Kokopelli
  module ActsAs
    module Guest

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_guest(options = {})
          send :include, InstanceMethods
          send :include, Kokopelli::Utilities
          send :include, Kokopelli::ActsAs::SharedMethods
          send :cache_kokopelli_attr, *options[:cache] if options[:cache]
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::Principal::Guest.new : Kokopelli::Principal::Guest.find(self.read_attribute(:kokopelli_id).to_s))
        end

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAs::Guest