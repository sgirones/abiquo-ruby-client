module Abiquo
	class VirtualDatacenter < Base
		RESOURCE_PATH = "/cloud/virtualdatacenters"
		RESOURCE_COLLECTION = "virtualDatacenters"
		RESOURCE_ELEMENT = "virtualDatacenter"

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

			# Create a new virtual datacenter
			#
			# params
			# dc_id - The datacenter id where to create the virtual datacenter
			# ent_id - The enterprise id where to create the virtual datacenter
			# vdc - A hash containing virtual datacenter info
			def create_virtual_datacenter dc_id, ent_id, vdc
				builder = Nokogiri::XML::Builder.new do |xml|
					xml.virtualDatacenter {
						#Required
						xml.name vdc["name"]
						xml.hypervisorType vdc["hypervisor_type"]

						#Optional
						xml.cpuHard vdc["cpu_hard"] ? vdc["cpu_hard"] : "0"
						xml.cpuSoft vdc["cpu_soft"] ? vdc["cpu_soft"] : "0"
						xml.hdHard vdc["hd_hard"] ? vdc["hd_hard"] : "0"
						xml.hdSoft vdc["hd_soft"] ? vdc["hd_soft"] : "0"
						xml.publicIpsHard vdc["public_ip_hard"] ? vdc["public_ip_hard"] : "0"
						xml.publicIpsSoft vdc["public_ip_soft"] ? vdc["public_ip_soft"] : "0"
						xml.ramHard vdc["ram_hard"] ? vdc["ram_hard"] : "0"
						xml.ramSoft vdc["ram_soft"] ? vdc["ram_soft"] : "0"
						xml.storageHard vdc["storage_hard"] ? vdc["storage_hard"] : "0"
						xml.storageSoft vdc["storage_soft"] ? vdc["storage_soft"] : "0"
						xml.vlansHard vdc["vlans_hard"] ? vdc["vlans_hard"] : "0"
						xml.vlansSoft vdc["vlans_soft"] ? vdc["vlans_soft"] : "0"

						xml.network do
							xml.name vdc["name"] ? vdc["name"] : "defaultNetwork"
							xml.gateway vdc["gateway"] ? vdc["gateway"] : "192.168.1.1"
							xml.address vdc["address"] ? vdc["address"] : "192.168.1.0"
							xml.mask vdc["mask"] ? vdc["mask"] : "24"
							xml.defaultNetwork vdc["default_network"] ? vdc["default_network"] : "true"
						end
					}
				end

				VirtualDatacenter.new Api.post(RESOURCE_PATH + "?datacenter=#{dc_id.to_s}&enterprise=#{ent_id.to_s}", builder.to_xml, {:content_type => "application/vnd.abiquo.virtualdatacenter+xml"}).body[RESOURCE_ELEMENT]
			end
		end

		# Return a list with hard disks created in this virtual datacenter
	    def disks
			get_resource_link(:disks, "disks", "disk")
	    end

		# Return a list with private networks created in this virtual datacenter
	    def private_networks
	    	elems = []
			get_resource_link(:networks, "networks", "network").each do |data|
				elems << Network.new(data)
			end
			elems
	    end

		# Return a list with virtual appliances created in this virtual datacenter
   	    def virtual_appliances
   	    	elems = []
			get_resource_link(:virtualappliances, "virtualAppliances", "virtualAppliance").each do |data|
				elems << VirtualAppliance.new(data)
			end
			elems
	    end

		# Return a list with volumes created in this virtual datacenter
   	    def volumes
			get_resource_link(:volumes, "volumes", "volume")
	    end

		# Return a list with tiers available for this virtual datacenter
  	    def tiers
			get_resource_link(:tiers, "tiers", "tier")
	    end

	    # Add a virtual appliance to this virtual datacenter
	    #
	    # params
	    # vapp - Hash containing vapp name
		def add_virtual_appliance vapp
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.virtualAppliance {
					xml.name vapp["name"]
				}
			end

			VirtualAppliance.new Api.post(link_info(:virtualappliances)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.virtualappliance+xml"}).body["virtualAppliance"]
		end

	end
end