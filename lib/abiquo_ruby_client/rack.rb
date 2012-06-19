module Abiquo
	class Rack < Base
		class << self
			def all
				racks = []
				
				# Get all racks from all datacenters
				dcs = Datacenter.all
				return [] unless dcs

				dcs.each do |dc|
					racks = racks | dc.racks
				end

				racks
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end
		
		# Get all the machines from the rack
		def machines
			elems = []
			get_resource_link(:machines, "machines", "machine").each do |data|
				elems << Machine.new(data)
			end
			elems
		end

		# Add a machine to the Rack
		#
		# params
		# machine - Hash with all the params
		def add_machine machine
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.machine {
					xml.datastores {
						machine.datastores.each do |ds|
							xml.datastore {
								xml.datastoreUUID ds["datastoreUUID"]
								xml.enabled ds["enabled"]
								xml.name ds["name"]
								xml.rootPath ds["rootPath"]
								xml.size ds["size"]
								xml.usedSize ds["usedSize"]
								xml.directory ds["directory"] ? ds["directory"] : ""
							}
						end
					}
					xml.description machine["description"] ? machine["description"] : ""
					xml.ip machine["ip"]
					xml.ipService machine["ipService"]
					xml.name machine["name"]
					xml.port machine["port"]
					xml.state machine["state"]
					xml.type_ machine["type"]
					xml.cpu machine["cpu"]
					xml.cpuRatio machine["cpuRatio"]
					xml.cpuUsed machine["cpuUsed"]
					xml.ram machine["ram"]
					xml.ramUsed machine["ramUsed"]
					xml.virtualSwitch machine["virtualSwitch"]
					xml.user machine["user"]
					xml.password machine["password"]
					xml.initiatorIQN machine["initiatorIQN"]
				}
			end

			Machine.new Api.post(link_info(:machines)["href"], builder.to_xml, {:content_type => "application/vnd.abiquo.machine+xml"}).body["machine"]
		end
	end
end