module Kokopelli
  module Principal

    class User < Base

      # ActiveModel Template
      # Class Methods
      private

      def self.find_every_url(options = {})
        url =  "https://" + KOKOPELLI[:domain] + "/api/xml?action=principal-list"
        url << "&filter-principal-id=" + options[:id] if options[:id]
        url << "&filter-type=" + self.principal_type
        url
      end

      def self.principal_type
        "user"
      end

      # Instance Methods
      private

      def attributes=(options = {})
        super
        options.each_pair do |key,value|
          @attributes.store(key,value)
        end
        @attributes[:type]  = self.class.principal_type
        @attributes[:email] = @attributes[:login]
        self
      end

      def parse_attributes(xml)
        super
        @attributes.store(:email, xml.xpath(".//login").content) rescue nil
        self
      end

      def update_attributes_url
        url =  super
        url << "&password=" + self.password unless self.password.blank?
        url << "&email="    + self.email    unless self.email.blank?
        url
      end

      # User-specific Methods
      public

      def signin(password = nil)
        request = Kokopelli::HTTP::Request::Base.new(signin_url(password))
        request.get!
        parse_session(request)
        true
      end

      def signout
        request = HTTP::Request::Base.new(signout_url)
        request.get!
        clear_session
        true
      end

      def logged_in?
        !@attributes[:session].blank?
      end

      def permissions_on(sco)
        url = "https://" + KOKOPELLI[:domain] + "/api/xml?action=permissions-info"
        url << "&acl-id=" + sco.kokopelli.id.to_s
        url << "&principal-id=" + self.id.to_s
        request = Kokopelli::HTTP::Request::Base.new(url)
        begin
          request.get!
          request.xml.xpath(".//permission").first.attribute("permission-id").value.to_sym
        rescue
          nil
        end
      end
      
      def email=(_email)
        @attributes[:email] = _email
      end

      private

      def signin_url(password = nil)
        url =  "https://"   + KOKOPELLI[:domain] + "/api/xml?action=login"
        url << "&login="    + @attributes[:login] unless @attributes[:login].blank?
        url << "&password=" + (@attributes[:password] || password) rescue nil
        url
      end

      def signout_url
        url =  "https://"  + KOKOPELLI[:domain] + "/api/xml?action=logout"
        url
      end

      def parse_session(request)
        cookie = request.header.get_fields("set-cookie").first
        cookie_items = cookie.split(";").collect { |item| item.match(/BREEZESESSION[0-9a-zA-Z=]*/)[0] rescue nil }.compact
        session_token = cookie_items.first
        @attributes[:session] = session_token.split("=").last
      end

      def clear_session
        @attributes[:session] = nil
      end

    end

  end
end