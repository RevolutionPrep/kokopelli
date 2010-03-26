module Kokopelli
  module ActsAs
    module Meeting

      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_kokopelli_meeting
          send :include, InstanceMethods
          send :include, Kokopelli::ActsAs::SharedMethods
        end
      end

      module InstanceMethods

        def kokopelli
          @kokopelli ||= (self.new_record? ? Kokopelli::SCO::Meeting.new : Kokopelli::SCO::Meeting.find(self.read_attribute(:kokopelli_id).to_s))
        end

      end

    end
  end
end

ActiveRecord::Base.send :include, Kokopelli::ActsAs::Meeting