module Kokopelli
  module ActsAs
    module Template

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_template(options = {})
          send :include, InstanceMethods
          send :include, Kokopelli::ActsAs::SharedMethods
          send :cache_kokopelli_attr, *options[:cache] if options[:cache]
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::SCO::Template.new : Kokopelli::SCO::Template.find(self.read_attribute(:kokopelli_id).to_s))
        end

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAs::Template