module Kokopelli
  module Principal

    class Host < User

      # ActiveModel Template
      # Class Methods
      private

      def self.find_every_url(options = {})
        url =  "https://"              + KOKOPELLI[:domain] + "/api/xml?action=principal-list"
        url << "&group-id="            + host_group.id.to_s
        url << "&filter-is-member=true"
        url << "&filter-principal-id=" + options[:id] if options[:id]
        url
      end

      def self.host_group
        Kokopelli::Principal::Base.find(:first, :type => "live-admins")
      end

      # Instance Methods
      public

      def save
        puts "HOST.SAVE"
        super
        puts "HOST.SAVE2"
        add_to_meeting_host_group
        self
      end

      # Host-specific Methods
      private

      def add_to_meeting_host_group
        request = Kokopelli::HTTP::Request::Base.new(add_to_meeting_host_group_url)
        request.get!
        self
      end

      def add_to_meeting_host_group_url
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=group-membership-update"
        url << "&group-id=" + self.class.host_group.id
        url << "&principal-id=" + self.id.to_s
        url << "&is-member=true"
        url
      end
    end

  end
end