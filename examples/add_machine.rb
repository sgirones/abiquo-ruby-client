m = Abiquo::Datacenter.one.discover "10.60.1.74", "root", "temporal", "vmx_04"
#Enable desired datastore
m.datastores.first["enabled"] = "true"
m.user = "root"
m.password = "temporal"

Abiquo::Rack.all.first.add_machine m