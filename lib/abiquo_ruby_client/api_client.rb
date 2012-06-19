module Abiquo
	class Api
		class << self
			attr_accessor :url, :user, :password

			def get(url = nil, headers = nil)
				@con ||= init_connection

				#accept absolute and relative path
				url = "#{@url}#{url}" unless url.include? "http://" 

				@con.get url, nil, prepare_headers(headers)
			end

			def delete(url = nil, headers = nil)
				@con ||= init_connection

				#accept absolute and relative path
				url = "#{@url}#{url}" unless url.include? "http://"

				@con.delete url, nil, prepare_headers(headers)
			end

			def post(url = nil, body = nil, headers = {}, &block)
				@con ||= init_connection

				#accept absolute and relative path
				url = "#{@url}#{url}" unless url.include? "http://" 
	
				@con.post url, body, prepare_headers(headers), &block
			end

			def put(url = nil, body = nil, headers = nil, &block)
				@con ||= init_connection

				#accept absolute and relative path
				url = "#{@url}#{url}" unless url.include? "http://" 
				
				@con.put url, body, prepare_headers(headers), &block
			end
						
			private

			def init_connection
				con = Faraday.new @url do |c|
					c.basic_auth(@user, @password)
					c.use FaradayMiddleware::Mashify
					c.use FaradayMiddleware::ParseXml
					c.adapter Faraday.default_adapter
					c.response	:raise_error
				end
				con
			end

			def prepare_headers headers
				#Add API version if defined
				headers[:accept] = "#{headers[:accept]};#{API_VERSION}" if headers and headers.has_key? :accept and Object.const_defined? :API_VERSION
				headers
			end
		end
	end
end

class Hash
  def deep_find(key)
    key?(key) ? self[key] : self.values.inject(nil) {|memo, v| memo ||= v.deep_find(key) if v.respond_to?(:deep_find) }
  end
end