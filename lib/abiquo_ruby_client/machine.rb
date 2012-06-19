module Abiquo
	class Machine < Base
		class << self
			def all
				machines = []
				
				# Get all machines from all racks
				racks = Rack.all
				return [] unless racks

				racks.each do |rack|
					machines = machines | rack.machines
				end

				machines
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end

		# Return all virtual_machines in this Machine
		def virtual_machines
			elems = []
			get_resource_link(:virtualmachines, "virtualmachines", "virtualmachine").each do |data|
				elems << VirtualMachine.new(data)
			end
			elems
		end
	end
end