module Kokopelli
  module ActsAsKokopelli
    module Template

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_template
          send :include, InstanceMethods
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::SCO::Template.new : Kokopelli::SCO::Template.find(self.read_attribute(:kokopelli_id).to_s))
        end

        include Kokopelli::ActsAsKokopelli::SharedMethods

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAsKokopelli::Template