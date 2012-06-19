module Abiquo
	class Network < Base
		# Return the list of network's ips
	    def ips
			get_resource_link(:ips, "ips", "ip")
	    end
	end
end