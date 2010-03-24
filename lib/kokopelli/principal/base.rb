module Kokopelli
  module Principal

    class Base < Kokopelli::ActiveModel::Base

      # ActiveModel Template
      # Class Methods

      private

      def self.find_every(options = {})
        request = Kokopelli::HTTP::Request::Base.new(find_every_url(options))
        request.get!
        self.parse_instances(request.xml.xpath(".//principal"))
      end

      def self.find_every_url(options = {})
        url =  "https://"              + KOKOPELLI[:domain] + "/api/xml?action=principal-list"
        url << "&filter-principal-id=" + options[:id]   if options[:id]
        url << "&filter-type="         + options[:type] if options[:type]
        url
      end

      def self.parse_instance(xml)
        self.new(
        :id                => xml.attribute("principal-id").value,
        :account_id        => xml.attribute("account-id").value,
        :has_children      => (["true", "1"].include?(xml.attribute("has-children").value) ? true : false),
        :is_primary        => (["true", "1"].include?(xml.attribute("is-primary").value) ? true : false),
        :is_hidden         => (["true", "1"].include?(xml.attribute("is-hidden").value) ? true : false),
        :training_group_id => (xml.attribute("training-group-id").value rescue nil),
        :type              => xml.attribute("type").value,
        :name              => xml.xpath(".//name").first.content,
        :login             => xml.xpath(".//login").first.content)
      end

      def self.principal_type
        ""
      end

      # Instance Methods
      public

      def reload!
        self.class.find(self.id)
      end

      def new_record?
        @attributes[:id].nil?
      end

      def hash
        @attributes[:id].hash
      end

      def to_param
        @attributes[:id]
      end
      
      def id=(_id)
        @attributes[:id] = _id
      end
      
      def account_id=(_account_id)
        @attributes[:account_id] = _account_id
      end
      
      def has_children=(_has_children)
        @attributes[:has_children] = _has_children
      end
      
      def is_primary=(_is_primary)
        @attributes[:is_primary] = _is_primary
      end
      
      def is_hidden=(_is_hidden)
        @attributes[:is_hidden] = _is_hidden
      end
      
      def training_group_id=(_training_group_id)
        @attributes[:training_group_id] = _training_group_id
      end
      
      def type=(_type)
        @attributes[:type] = _type
      end
      
      def name=(_name)
        @attributes[:name] = _name
      end
      
      def login=(_login)
        @attributes[:login] = _login
      end

      private

      def attributes=(options = {})
        super
        attrs = {:has_children => false, :is_primary => false, :is_hidden => false}.merge(options)
        attrs.each_pair do |key,value|
          @attributes.store(key,value)
        end
        self
      end

      def parse_attributes(xml)
        xml = xml.root.xpath(".//principal").first
        @attributes.store(:id,                xml.attribute("principal-id").value)      rescue nil
        @attributes.store(:account_id,        xml.attribute("account-id").value)        rescue nil
        @attributes.store(:training_group_id, xml.attribute("training-group-id").value) rescue nil
        @attributes.store(:type,              xml.attribute("type").value)              rescue nil
        @attributes.store(:name,              xml.xpath(".//name").first.content)       rescue nil
        @attributes.store(:login,             xml.xpath(".//login").first.content)      rescue nil
        @attributes.store(:has_children,      (["true", "1"].include?(xml.attribute("has-children").value || nil) ? true : false)) rescue false
        @attributes.store(:is_primary,        (["true", "1"].include?(xml.attribute("is-primary").value   || nil) ? true : false)) rescue false
        @attributes.store(:is_hidden,         (["true", "1"].include?(xml.attribute("is-hidden").value    || nil) ? true : false)) rescue false
        self
      end

      def update_attributes_url
        url =  "https://"             + KOKOPELLI[:domain] + "/api/xml?action=principal-update"
        url << "&principal-id="      + @attributes[:id]                    unless @attributes[:id].blank?
        url << "&account-id="        + @attributes[:account_id]            unless @attributes[:account_id].blank?
        url << "&training-group-id=" + @attributes[:training_group_id]     unless @attributes[:training_group_id].blank?
        url << "&name="              + @attributes[:name].gsub(" ", "%20") unless @attributes[:name].blank?
        url << "&login="             + @attributes[:login]                 unless @attributes[:login].blank?
        url << "&type="              + @attributes[:type]                  unless @attributes[:type].blank? || !self.new_record?
        url << "&has-children="      + @attributes[:has_children].to_s
        url << "&is-primary="        + @attributes[:is_primary].to_s
        url << "&is-hidden="         + @attributes[:is_hidden].to_s
        url
      end

      def destroy_url
        url =  "https://" + KOKOPELLI[:domain] + "/api/xml?action=principals-delete"
        url << "&principal-id=" + self.id
        url
      end

    end

  end
end