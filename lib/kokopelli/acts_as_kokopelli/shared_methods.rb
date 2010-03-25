module Kokopelli
  module ActsAsKokopelli
    module SharedMethods

      def save(validate = true)
        self.before_kokopelli_save
        self.kokopelli.save
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
			
			# Utility method for making passwords
		  def choose_random_password(length=8)
		    universe = (48..57).to_a+(65..90).to_a+(97..122).to_a
		    (0...length).map {universe[Kernel.rand(universe.size)].chr}.join
		  end
    end
  end
end
