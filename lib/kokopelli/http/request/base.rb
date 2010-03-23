module Kokopelli
  module HTTP
    module Request

      class Base
        require 'nokogiri'

        attr_reader :url
        attr_reader :response
        attr_reader :header
        attr_reader :xml
        attr_reader :state
        attr_reader :invalid_field
        attr_reader :invalid_type
        attr_reader :invalid_subcode

        def initialize(url)
          @url = url
          unless @url.match(/\/api\/xml\?action\=login\&login\=/) || @url.blank?
            @url << "&session=" + Kokopelli.admin.session
          end
        end

        def get!
          RAILS_DEFAULT_LOGGER.info("\n*******************************************\n") if KOKOPELLI[:logging]
          RAILS_DEFAULT_LOGGER.info("\nREQUEST URL: #{@url}\n")                        if KOKOPELLI[:logging]
          uri = URI.parse(@url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true if uri.scheme == "https"  # enable SSL/TLS
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http.start {
            @response = http.request_get((uri.path rescue "/") + (("?" + uri.query) rescue ""))
          }
          @header = @response.header
          @xml = Nokogiri::XML::Document.parse(@response.body)
          RAILS_DEFAULT_LOGGER.info("\nRESPONSE BODY: #{@response.body}\n")            if KOKOPELLI[:logging]
          RAILS_DEFAULT_LOGGER.info("\n*******************************************\n") if KOKOPELLI[:logging]
          set_state
          self
        end

        def success?
          @state == :success
        end

        def failure?
          @state == :failure
        end

        def invalid?
          @state == :invalid
        end

        def indeterminant?
          @state == :indeterminant
        end

        def internal_error?
          @state == :internal_error
        end

        private

        def set_state
          case (@xml.root.xpath(".//status").first.attribute("code").value rescue nil)
          when "ok"
            @state = :success
          when "no-data"
            @state = :failure
            raise Kokopelli::Exception::InternalError, Kokopelli::HTTP::Response::Failure.new(:request => self).reason
          when "invalid"
            @state = :invalid
            load_invalid_attrs
            raise Kokopelli::Exception::InternalError, Kokopelli::HTTP::Response::Invalid.new(:request => self).reason
          when "internal-error"
            @state = :internal_error
            raise Kokopelli::Exception::InternalError, @xml.root.xpath(".//exception").first.content
          else
            @state = :indeterminant
            raise Kokopelli::Exception::InternalError, Kokopelli::HTTP::Response::Indeterminant.new(:request => self).reason
          end
        end

        def load_invalid_attrs
          invalid = @xml.root.xpath(".//invalid").first
          @invalid_field = invalid.attribute("field").value || nil
          @invalid_type = invalid.attribute("type").value || nil
          @invalid_subcode = invalid.attribute("subcode").value || nil
        end

      end

    end
  end
end