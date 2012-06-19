#Since there is a bug in the API, we need to provide a template manually.
t = {
	"link" => [
		{
			"href" => "http://10.60.10.2:80/api/admin/enterprises/1/datacenterrepositories/6/virtualmachinetemplates/16",
			"title" => "Zentyal Vmware"
		}
	]
}

Abiquo::VirtualAppliance.one.add_virtual_appliance t