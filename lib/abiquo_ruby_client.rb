require 'rubygems'
require 'faraday'
require 'faraday_middleware'
require 'hashie'
require 'nokogiri'

module Abiquo
	# If no API_VERSION is set, last one will be used
	# API_VERSION = "0.0.0"

	class Base < Hashie::Mash
  		# Get link info where rel attribute = sym
        def link_info(sym)
          self.deep_find("link").each do |l|
            return l if l.has_value? sym.to_s
          end
          return {}
        end

        # Return a list of resource elements from link {link_rel}
        #
        # params
        # link_rel - the link to select from all resource links
        # resource_collection - root element of the resource collection
        # resource_element - tag name of a resource element
        def get_resource_link(link_rel, resource_collection, resource_element)
	    	link = link_info(link_rel)

	    	return [] unless link

	    	res = Api.get(link["href"], {:accept => link["type"]}).body[resource_collection]

			return [] unless res and res = res[resource_element]

	    	#if more than one element
	    	if res.is_a? Array
		    	elems = []
		    	res.each {|e| elems << e}
		    	return elems
		    end
		    [res]
        end

        # Return a list of resource elements from a custom path (path from base api URL)
        #
        # params
        # path - path to the resource from api base url
        # resource_collection - root element of the resource collection
        # resource_element - tag name of a resource element
        def self.get_resource(path, resource_collection, resource_element, type = nil)
	    	res = Api.get(path, {:accept => type || "*/*"}).body[resource_collection]

			return [] unless res and res = res[resource_element]

	    	#if more than one element
	    	if res.is_a? Array
		    	elems = []
		    	res.each {|e| elems << e}
		    	return elems
		    end
		    [res]
        end
	end
end

Dir[File.dirname(__FILE__) + '/abiquo_ruby_client/*.rb'].each {|file| require file}