module Kokopelli
  module ActsAs
    module SharedMethods

      def self.append_features(base)
        base.class_eval "alias_method :ar_save, :save" unless base.method_defined?(:ar_save)
        base.class_eval "alias_method :ar_destroy, :destroy" unless base.method_defined?(:ar_destroy)
        super
      end

      def self.included(base)
        base.send :extend, ClassMethods
      end

      def save(validate = true, options = {})
        self.before_kokopelli_save
        self.kokopelli.save
        self.write_attribute(:kokopelli_id, self.kokopelli.id.to_i) if self.kokopelli_id.blank?
        ar_save(validate)
      end

      def method_missing(m, *args, &block)
        if self.attribute_names.include?(m.to_s)
          super
        else
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
      end

      def destroy
        self.kokopelli.destroy
        ar_destroy
      end

      def before_kokopelli_save
        # this is a before filter that can be called from any of the Kokopellified AR objects
      end

      module ClassMethods

        def cache_kokopelli_attr(*args)
          column_existence = args.map { |arg| self.column_names.include?("kokopelli_" + arg.to_s) }

          if column_existence.all?
            args.each do |name|
              define_method name.to_sym do
                unless attribute = self.read_attribute("kokopelli_#{name}")
                  puts "loading a cached attribute"
                  attribute = self.kokopelli.send("#{name}")
                  self.write_attribute("kokopelli_#{name}", attribute)
                  self.ar_save
                end
                attribute
              end

              define_method "#{name}=".to_sym do |value|
                puts "kokopelli_#{name} = #{value}"
                self.write_attribute("kokopelli_#{name}", value)
                self.kokopelli.send("#{name}=", value)
              end
            end
          else
            bad_attrs = []
            column_existence.each_with_index { |exists,index| bad_attrs << args[index] if !exists }
            raise Kokopelli::Exception::CachingError, "Caching Kokopelli attributes on #{self.name} is not currently possible for the following attributes: { #{bad_attrs.map { |bad_attr| ":" + bad_attr.to_s }.join(", ")} }\nPlease add columns to the database table \"#{self.table_name}\" as { #{bad_attrs.map { |bad_attr| ":kokopelli_" + bad_attr.to_s }.join(", ")} }"
          end
        end

      end
    end
  end
end