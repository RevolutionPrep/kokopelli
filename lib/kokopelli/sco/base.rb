module Kokopelli
  module SCO

    class Base < Kokopelli::ActiveModel::Base

      # ActiveModel Template
      # Class Methods
      private

      def self.find_every(options = {})
        request = Kokopelli::HTTP::Request::Base.new(find_every_url)
        request.get!
        instances = Array.new
        parse_instances(request.xml.xpath(".//sco")).each do |instance|
          request = Kokopelli::HTTP::Request::Base.new(contents_url(instance))
          request.get!
          instances << parse_instances(request.xml.xpath(".//sco"))
        end
        instances.flatten
      end

      def self.find_by_id(id, options = {})
				RAILS_DEFAULT_LOGGER.info "finding sco by id #{id}"
        request = Kokopelli::HTTP::Request::Base.new(find_by_id_url(id))
        request.get!
        parse_instance(request.xml.xpath(".//sco").first)
      end

      def self.find_every_url
        url =  "https://"      + KOKOPELLI[:domain] + "/api/xml?action=sco-shortcuts"
        url
      end

      def self.parse_instance(xml)
        self.new(
          :id          => xml.attribute("sco-id").value,
          :type        => xml.attribute("type").value,
          :source_id   => (xml.attribute("source-sco-id").value rescue nil),
          :folder_id   => (xml.attribute("folder-id").value rescue nil),
          :display_seq => (xml.attribute("display-seq").value rescue nil),
          :name        => (xml.xpath(".//name").first.content rescue nil),
          :url_path    => (xml.xpath(".//url-path").first.content.gsub("/","") rescue nil),
          :icon        => (xml.attribute("icon").value rescue nil),
          :created_at  => (Time.parse(xml.xpath(".//date-created").first.content) rescue nil),
          :updated_at  => (Time.parse(xml.xpath(".//date-modified").first.content) rescue nil),
          :starts_at   => (Time.parse(xml.xpath(".//date-begin").first.content) rescue nil),
          :ends_at     => (Time.parse(xml.xpath(".//date-end").first.content) rescue nil),
          :description => (xml.xpath(".//description").first.content rescue nil)
        )
      end

      # Instance Methods
      public

      def new_record?
        @attributes[:id].nil?
      end

      def hash
        @attributes[:id].hash
      end
      
      def id=(_id)
        @attributes[:id] = _id
      end
      
      def type=(_type)
        @attributes[:type] = _type
      end
      
      def source_id=(_source_id)
        @attributes[:source_id] = _source_id
      end
      
      def folder_id=(_folder_id)
        @attributes[:folder_id] = _folder_id
      end
      
      def display_seq=(_display_seq)
        @attributes[:display_seq] = _display_seq
      end
      
      def name=(_name)
        @attributes[:name] = _name
      end
      
      def url_path=(_url_path)
        @attributes[:url_path] = _url_path
      end
      
      def icon=(_icon)
        @attributes[:icon] = _icon
      end
      
      def created_at=(_created_at)
        @attributes[:created_at] = _created_at
      end
      
      def updated_at=(_updated_at)
        @attributes[:updated_at] = _updated_at
      end
      
      def starts_at=(_starts_at)
        @attributes[:starts_at] = _starts_at
      end
      
      def ends_at=(_ends_at)
        @attributes[:ends_at] = _ends_at
      end
      
      def description=(_description)
        @attributes[:description] = _description
      end

      private

      def attributes=(options = {})
        attrs = {
          :is_folder => false,
          :created_at => Time.now.localtime,
          :updated_at => Time.now.localtime,
          :starts_at => Time.now.localtime,
          :ends_at => Time.now.localtime + (1.0/24.0)
        }.merge(options)
        attrs.each_pair do |key,value|
          @attributes.store(key,value)
        end
        self
      end

      def parse_attributes(xml)
        xml = xml.xpath(".//sco").first
        @attributes.store(:id,          xml.attribute("sco-id").value)                                     rescue nil
        @attributes.store(:type,        xml.attribute("type").value)                                       rescue nil
        @attributes.store(:source_id,   xml.attribute("source-sco-id").value)                              rescue nil
        @attributes.store(:folder_id,   xml.attribute("folder-id").value)                                  rescue nil
        @attributes.store(:display_seq, xml.attribute("display-seq").value)                                rescue nil
        @attributes.store(:name,        xml.xpath(".//name").first.content)                                rescue nil
        @attributes.store(:url_path,    xml.xpath(".//url-path").first.content.gsub("/",""))               rescue nil
        @attributes.store(:icon,        xml.attribute("icon").value)                                       rescue nil
        @attributes.store(:created_at,  Time.parse(xml.xpath(".//date-created").first.content).localtime)  rescue nil
        @attributes.store(:updated_at,  Time.parse(xml.xpath(".//date-modified").first.content).localtime) rescue nil
        @attributes.store(:starts_at,   Time.parse(xml.xpath(".//date-begin").first.content).localtime)    rescue nil
        @attributes.store(:ends_at,     Time.parse(xml.xpath(".//date-end").first.content).localtime)      rescue nil
        @attributes.store(:description, xml.xpath(".//description").first.content)                         rescue nil
        self
      end

      def update_attributes_url
        url =  "https://"        + KOKOPELLI[:domain] + "/api/xml?action=sco-update"
        url << "&sco-id="        + @attributes[:id]                          unless @attributes[:id].blank?
        url << "&date-begin="    + @attributes[:starts_at].xmlschema         unless @attributes[:starts_at].nil?
        url << "&date-end="      + @attributes[:ends_at].xmlschema           unless @attributes[:ends_at].nil?
        url << "&description="   + @attributes[:description].gsub(" ","%20") unless @attributes[:description].blank?
        url << "&folder-id="     + @attributes[:folder_id]                   unless @attributes[:folder_id].blank? || !self.new_record?
        url << "&name="          + @attributes[:name].gsub(" ","%20")        unless @attributes[:name].blank?
        url << "&source-sco-id=" + @attributes[:source_id]                   unless @attributes[:source_id].blank? || !self.new_record?
        url << "&type="          + @attributes[:type]                        unless @attributes[:type].blank?      || !self.new_record?
        url << "&url-path="      + @attributes[:url_path]                    unless @attributes[:url_path].blank?  || !self.new_record?
        url
      end

      def destroy_url
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-delete"
        url << "&sco-id=" + @attributes[:id]
        url
      end

      # Base-specific Methods
      public

      def self.contents_url(instance)
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-contents"
        url << "&sco-id=" + instance.id
        url
      end

      def self.find_by_id_url(id)
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=sco-info"
        url << "&sco-id=" + id
        url
      end

    end

  end
end