module Kokopelli
  module ActiveModel

    class Base
      
      attr_reader :attributes
      # ActiveModel Template
      # Class Methods
      public

      def self.find(*args)
        if args.empty?
          raise Kokopelli::Exception::RecordNotFound, "Couldn't find #{self} without ID"
        else
          options = args.last.is_a?(Hash) ? args.last : {}
          case args.first
          when :all
            self.find_every(options)
          when :first
            self.find_first(options)
          else
            if args.first.class == String && args.first.to_i.to_s == args.first
              self.find_by_id(args.first, options)
            else
              raise Kokopelli::Exception::RecordNotFound, "Couldn't find #{self} with this ID"
            end
          end
        end
      end

      def self.all
        self.find_every
      end

      def self.first
        self.find_first
      end

      private

      def self.find_every(options = {})
        []
      end

      def self.find_first(options = {})
        self.find_every(options).first
      end

      def self.find_by_id(id, options = {})
        self.find_first(options.merge(:id => id))
      end

      def self.find_every_url
        ""
      end

      def self.parse_instances(xml)
        instances = Array.new
        xml.each do |instance|
          instances << parse_instance(instance)
        end
        instances
      end

      def self.parse_instance(xml)
        self.new
      end

      # Instance Methods
      public

      def initialize(options = {})
        @attributes = {}
        self.attributes = options
      end

      def save
        parse_attributes(update_server_attributes)
        self
      end

      def update_attributes(options = {})
        self.attributes = options
        update_server_attributes
        self
      end

      def destroy
        request = Kokopelli::HTTP::Request::Base.new(destroy_url)
        request.get!
        self
      end

      def reload!
        self
      end

      def valid?
        true
      end

      def new_record?
        true
      end

      def hash
        super
      end

      def eql?(other_obj)
        other_obj.hash == self.hash
      end

      def to_param
        self
      end

      def kokopelli
        self
      end
      
      def id
        @attributes[:id]
      end
      
      def type
        @attributes[:type]
      end

      private

      def attributes=(options = {})
        self
      end

      def parse_attributes(xml)
        self
      end

      def update_server_attributes
        request = Kokopelli::HTTP::Request::Base.new(update_attributes_url)
        request.get!
        request.xml
      end

      def update_attributes_url
        ""
      end

      def destroy_url
        ""
      end
      
      def method_missing(m, *args, &block)
        if @attributes.has_key?(m.to_sym)
          @attributes[m.to_sym]
        else
          super
        end
      end

    end

  end
end