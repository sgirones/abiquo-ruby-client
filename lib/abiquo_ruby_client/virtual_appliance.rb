module Abiquo
	class VirtualAppliance < Base
		class << self
			def all
				vapps = []
				
				vdcs = VirtualDatacenter.all
				return [] unless vdcs

				vdcs.each do |vdc|
					vapps = vapps | vdc.virtual_appliances
				end

				vapps
			end

			def one
				tmp = self.all
				return tmp.first if tmp
			end
		end

		# Return a list with all VMs attached to this vApp
	    def virtual_machines
	    	elems = []
			get_resource_link(:machines, "machines", "machine").each do |data|
				elems << VirtualMachine.new(data)
			end
			elems
	    end

		# Deploy the vApp and return the links to the related tasks
		def deploy
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.virtualmachinetask {
					xml.forceEnterpriseSoftLimits "false"
				}
			end
			body = Api.post(link_info(:deploy)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.virtualmachinetask+xml"}).body

			#Return the task links
			links = []
			body.deep_find("link").each do |link|
				links << link["href"]
			end
			links
		end
		
		# Undeploy the vApp and return the links to the related tasks
		def undeploy
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.virtualmachinetask {
					xml.forceUndeploy "false"
				}
			end
			body = Api.post(link_info(:undeploy)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.virtualmachinetask+xml"}).body

			#Return the task links
			links = []
			body.deep_find("link").each do |link|
				links << link["href"]
			end
			links
		end

		# Add a VM to the vApp based on template info
		#
		# params
		# template - Hash with needed link to the template
		def add_virtual_machine template
			template_link = ""
			template["link"].each do |link|
				template_link = link if link["rel"] = "edit"
				break
			end

			builder = Nokogiri::XML::Builder.new do |xml|
				xml.virtualMachine {
					xml.link(:rel => "virtualmachinetemplate", :href => template_link["href"], :title => template_link["title"])
				}
			end

			VirtualMachine.new Api.post(link_info(:virtualmachines)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.virtualmachine+xml"}).body["virtualMachine"]
		end
	end
end