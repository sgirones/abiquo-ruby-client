#Create a new Datacenter
dc = {
	"name" => "dc2",
	"location" => "bcn",
	"remote_services" => [
		{"type" => "VIRTUAL_FACTORY", "uri" => "http://localhost:80/virtualfactory"},
		{"type" => "STORAGE_SYSTEM_MONITOR", "uri" => "http://localhost:80/ssm"},
		{"type" => "VIRTUAL_SYSTEM_MONITOR", "uri" => "http://localhost:80/vsm"},
		{"type" => "NODE_COLLECTOR", "uri" => "http://localhost:80/nodecollector"},
		{"type" => "APPLIANCE_MANAGER", "uri" => "http://localhost:80/am"},
		{"type" => "BPM_SERVICE", "uri" => "http://localhost:80/bpm-async"},
		{"type" => "DHCP_SERVICE", "uri" => "omapi://localhost:7911"}
	]
}

Abiquo::Datacenter.create_datacenter dc