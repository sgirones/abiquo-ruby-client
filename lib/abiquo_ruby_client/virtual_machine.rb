module Abiquo
	class VirtualMachine < Base
		#class methods
		class << self
			def all
				vms = []
				
				vapps = VirtualAppliance.all
				return [] unless vapps

				vapps.each do |vapp|
					vms = vms | vapp.virtual_machines
				end

				vms
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end

		# Return a list of tasks related to this virtualmachine
	    def tasks
			get_resource_link(:tasks, "tasks", "task")
	    end
		
		# Return a list of nics attached to this virtualmachine
	    def nics
			get_resource_link(:nics, "nics", "nic")
	    end

		# Return a list of volumes attached to this virtualmachine
	    def volumes
			get_resource_link(:volumes, "volumes", "volume")
	    end

		# Return a list of extra hard disks created in this virtualmachine
	    def disks
			get_resource_link(:disks, "disks", "disk")
	    end

	    def virtual_machine_template
	    end

	    def user
	    end

	end
end