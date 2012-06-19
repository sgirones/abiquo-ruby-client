module Abiquo
	class Datacenter < Base
		RESOURCE_PATH = "/admin/datacenters"
		RESOURCE_COLLECTION = "datacenters"
		RESOURCE_ELEMENT = "datacenter"

		class << self
			def all
				elems = []
				get_resource(RESOURCE_PATH, RESOURCE_COLLECTION, RESOURCE_ELEMENT).each do |data|
					elems << self.new(data)
				end
				elems
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end

			# Create a datacenter
			#
			# params
			# dc - Hash with needed info 
			def create_datacenter dc
				builder = Nokogiri::XML::Builder.new do |xml|
					xml.datacenter {
						xml.remoteServices {
							dc["remote_services"].each do |rs|
								xml.remoteService {
									xml.type_ rs["type"] # Required
									xml.uri rs["uri"] ? rs["uri"] : "127.0.0.1"
								}
							end
						}
						xml.name dc["name"] # Required
						xml.location dc["location"] ? dc["location"] : "nowhere"
						xml.ramSoft dc["ram_soft"] ? dc["ram_soft"] : "0"
						xml.cpuSoft dc["cpu_soft"] ? dc["cpu_soft"] : "0"
						xml.vlanSoft dc["vlan_soft"] ? dc["vlan_soft"] : "0"
					}
				end

				Datacenter.new Api.post(RESOURCE_PATH, builder.to_xml, {:content_type => "application/vnd.abiquo.datacenter+xml"}).body[RESOURCE_ELEMENT]
			end

		end

		# Return the datacenter's Racks
	    def racks
			elems = []
			get_resource_link(:racks, "racks", "rack").each do |data|
				elems << Rack.new(data)
			end
			elems
	    end
		
		# Return the datacenter's Networks
	    def networks
			elems = []
			get_resource_link(:networks, "networks", "network").each do |data|
				elems << Network.new(data)
			end
			elems
	    end

	    # Returns a Hash with the Machine info retrieved from the host. This info is enough for adding a new machine to the Datacenter.
	    #
	    # params
	    # ip - Host ip
	    # user - User login
	    # pass - Password login
	    # hypervisor_type - Hypervisor type. Look out http://wiki.abiquo.com/display/ABI20/Abiquo+Data+Media+Types#AbiquoDataMediaTypes-MachineDataModel
		def discover ip, user, pass, hypervisor_type
			uri = link_info(:discoversingle)["href"]
			type = link_info(:discoversingle)["type"]

	    	machine = Api.get("#{uri}?ip=#{ip}&user=#{user}&password=#{pass}&hypervisor=#{hypervisor_type}", {:accept => type}).body["machine"]
	    	machine.datastores = machine.datastores["datastore"]
	    	machine
		end

		#Add a rack to the Datacenter
		def add_rack rack
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.rack {
					xml.name rack["name"]	# Required
					xml.shortDescription rack["short_description"] ? rack["short_description"] : ""
					xml.haEnabled rack["ha_enabled"] ? rack["ha_enabled"] : "false"
					xml.vlanIdMin rack["vlan_id_min"] ? rack["vlan_id_min"] : "2"
					xml.vlanIdMax rack["vlan_id_max"] ? rack["vlan_id_max"] : "4095"
					xml.vlanPerVdcReserved rack["vlan_per_vdc_reserved"] ? rack["vlan_per_vdc_reserved"] : "6"
					xml.nrsq rack["nrsq"] ? rack["nrsq"] : "80"
				}
			end

			Rack.new Api.post(link_info(:racks)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.rack+xml"}).body["rack"]
		end

	end

end



