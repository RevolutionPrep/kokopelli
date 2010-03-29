module Kokopelli
  module ActsAs
    module SharedMethods

      def self.append_features(base)
        base.class_eval "alias_method :ar_save, :save" unless base.method_defined?(:ar_save)
        super
      end

      def save(validate = true, options = {})
        puts "SharedMethods#save"
        self.before_kokopelli_save
        self.kokopelli.save
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        ar_save(validate)
      end

      def method_missing(m, *args, &block)
        if self.kokopelli.respond_to?(m)
          unless args.empty?
            if args.length > 1
              self.kokopelli.send(m, *args)
            else
              self.kokopelli.send(m, args.first)
            end
          else
            self.kokopelli.send(m)
          end
        elsif self.kokopelli.attributes.has_key?(m.to_sym)
          self.kokopelli.method_missing(m, *args, &block)
        else
          super
        end
      end

      def destroy
        self.kokopelli.destroy
        super
      end

      def before_kokopelli_save
        # this is a before filter that can be called from any of the Kokopellified AR objects
      end

    end
  end
end