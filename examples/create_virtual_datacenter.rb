vdc = {
	"name" => "test3",
	"hypervisor_type" => "vmx_04",
}

pp dc_id = Abiquo::Datacenter.one.id
pp ent_id = Abiquo::Enterprise.one.id

pp Abiquo::VirtualDatacenter.create_virtual_datacenter dc_id, ent_id, vdc