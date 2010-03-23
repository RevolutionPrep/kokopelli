module Kokopelli
  module Principal

    class Admin < User

      # ActiveModel Template
      # Class Methods
      private

      def self.find_every_url(options = {})
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list"
        url << "&group-id=" + self.admins_group.id
        url << "&filter-is-member=true"
        url << "&filter-principal-id=" + options[:id] if options[:id]
        url
      end

      def self.principal_type
        "user"
      end

      # Instance Methods
      public

      def initialize(options = {})
        super
        @attributes[:stale_datetime] = Time.now
      end

      # User-inherited Methods
      public

      def signin(password = nil)
        super
        @attributes[:stale_datetime] = Time.now + (10 * 60)
        true
      end

      # Admin-specific Methods
      public

      def stale?
        Time.now > @attributes[:stale_datetime]
      end

      private

      def self.admins_group
        request = Kokopelli::HTTP::Request::Base.new(admins_group_url)
        request.get!
        parse_instances(request.xml.xpath(".//principal")).first
      end

      def self.admins_group_url
        url =  "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list"
        url << "&filter-type=admins"
        url
      end

    end

  end
end