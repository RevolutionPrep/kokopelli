module Kokopelli
  module SCO

    class Meeting < Base

      # ActiveModel Template
      # Class Methods
      private

      def self.find_every(options = {})
        request = Kokopelli::HTTP::Request::Base.new(find_every_url)
        request.get!
        instances = Array.new
        parse_instances(request.xml.xpath(".//sco")).collect { |instance|
          instance if is_parent_folder?(instance)
        }.compact.each do |instance|
          request = Kokopelli::HTTP::Request::Base.new(contents_url(instance))
          request.get!
          instances << parse_instances(request.xml.xpath(".//sco")).collect { |instance| instance if instance.type == "meeting" }.compact
        end
        instances.flatten
      end

      # Instance Methods
      public

      def save
        super
        set_permissions(:private)
        self
      end

      private

      def update_attributes_url
        url =  "https://"        + KOKOPELLI[:domain] + "/api/xml?action=sco-update"
        url << "&sco-id="        + @attributes[:id]                                                unless @attributes[:id].blank?
        url << "&date-begin="    + @attributes[:starts_at].localtime.xmlschema                     unless @attributes[:starts_at].nil?
        url << "&date-end="      + @attributes[:ends_at].localtime.xmlschema                       unless @attributes[:ends_at].nil?
        url << "&description="   + @attributes[:description].gsub(" ","%20")                       unless @attributes[:description].blank?
        url << "&folder-id="     + (@attributes[:folder_id].nil? ? default_folder.id : @folder_id) if self.new_record?
        url << "&name="          + @attributes[:name].gsub(" ","%20")                              unless @attributes[:name].blank?
        url << "&source-sco-id=" + @attributes[:source_id]                                         unless @attributes[:source_id].blank? || !self.new_record?
        url << "&type="          + "meeting"                                                       if self.new_record?
        url << "&url-path="      + @attributes[:url_path]                                          unless @attributes[:url_path].blank? || !self.new_record?
        url
      end

      # Base-specific Methods
      public

      def self.is_parent_folder?(instance)
        instance.type == "meetings" || instance.type == "my-meetings" || instance.type == "user-meetings"
      end

      def authenticate(user, level)
        url =  "https://"        + KOKOPELLI[:domain] + "/api/xml?action=permissions-update"
        url << "&acl-id="        + self.id.to_s
        url << "&principal-id="  + user.kokopelli.id.to_s
        url << "&permission-id=" + level.to_s
        request = Kokopelli::HTTP::Request::Base.new(url)
        request.get!
        self
      end

      private

      def default_folder
        request = Kokopelli::HTTP::Request::Base.new(default_folder_url)
        request.get!
        self.class.parse_instances(request.xml.xpath(".//sco")).collect { |instance|
          instance if instance.type == "my-meetings"
        }.compact.first
      end

      def default_folder_url
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-shortcuts"
        url
      end

      def set_permissions(state)
        url =  "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-update"
        url << "&acl-id=" + self.id.to_s
        url << "&principal-id=public-access"
        case state
        when :private
          url << "&permission-id=denied"
        when :public
          url << "&permission-id=view"
        end
        request = Kokopelli::HTTP::Request::Base.new(url)
        request.get!
        self
      end

      # Meeting-specific methods
      public

      def room_url
        "http://" + KOKOPELLI[:domain] + "/" + self.url_path + "/"
      end
      
      def archives
        request = Kokopelli::HTTP::Request::Base.new(expanded_contents_url)
        request.get!
        Archive.parse_instances(request.xml.xpath(".//sco"))
      end
      
      def archive_url
        "http://" + KOKOPELLI[:domain] + "/" + self.archives.first.url_path + "/" unless self.archives.empty?
      end
      
      private
      
      def expanded_contents_url
        url =  "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-expanded-contents"
        url << "&sco-id=" + self.id.to_s
        url << "&filter-icon=archive"
        url
      end

    end

  end
end
