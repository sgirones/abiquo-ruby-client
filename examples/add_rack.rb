rack = {
	"name" => "test",
	"short_description" => "super rack",
	"ha_enabled" => "false",
	"vlan_id_min" => "2",
	"vlan_id_max" => "4000",
	"vlan_per_vdc_reserved" => "6",
	"nrsq" => "80"
}

pp Abiquo::Datacenter.one.add_rack rack