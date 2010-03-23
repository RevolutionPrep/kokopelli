module Kokopelli
  module SCO

    class Template < Meeting

      # Base-specific Methods
      public

      def self.is_parent_folder?(instance)
        instance.type == "shared-meeting-templates" || instance.type == "my-meeting-templates"
      end

      private

      def default_folder
        request = Kokopelli::HTTP::Request::Base.new(default_folder_url)
        request.get!
        self.class.parse_instances(request.xml.xpath(".//sco")).collect { |instance|
          instance if instance.type == "shared-meeting-templates"
        }.compact.first
      end

    end

  end
end