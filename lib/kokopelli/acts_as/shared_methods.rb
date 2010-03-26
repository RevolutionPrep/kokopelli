module Kokopelli
  module ActsAs
    module SharedMethods

      def save(validate = true, options = {})
        unless self.class.included_modules.include?(Kokopelli::ActsAs::SingletonHost)
          self.before_kokopelli_save
          self.kokopelli.save
        end
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        super(validate)
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