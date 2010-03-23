module Kokopelli
  module ActsAsKokopelli
    module Guest

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_guest
          send :include, InstanceMethods
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::Principal::Guest.new : Kokopelli::Principal::Guest.find(self.read_attribute(:kokopelli_id).to_s))
        end

        include Kokopelli::ActsAsKokopelli::SharedMethods

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAsKokopelli::Guest