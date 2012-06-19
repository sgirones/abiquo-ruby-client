require 'teststrap'

include Abiquo

context "test datacenter methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("Datacenter.all returns an empty list or a list of Datacenters") do
		elems = Datacenter.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? Datacenter if elems.size > 0))
	end
	asserts("Datacenter.one returns an Datacenter object or nil") { Datacenter.one.kind_of? Datacenter or Datacenter.one == nil }
end

context "test enterprise methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("Enterprise.all returns an empty list or a list of Enterprises") do
		elems = Enterprise.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? Enterprise if elems.size > 0))
	end
	asserts("Enterprise.one returns an Enterprise object or nil") {Enterprise.one.kind_of? Enterprise or Enterprise.one == nil}
end

context "test machine methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("Machine.all returns an empty list or a list of Machines") do
		elems = Machine.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? Machine if elems.size > 0))
	end
	asserts("Machine.one returns an Machine object or nil") {Machine.one.kind_of? Machine or Machine.one == nil}
end

context "test rack methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
  	end

	asserts("Rack.all returns an empty list or a list of Racks") do
		elems = Rack.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? Rack if elems.size > 0))
	end
	asserts("Rack.one returns an Rack object or nil") {Rack.one.kind_of? Rack or Rack.one == nil}
end

context "test virtual appliance methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("VirtualAppliance.all returns an empty list or a list of VirtualAppliance") do
		elems = VirtualAppliance.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? VirtualAppliance if elems.size > 0))
	end
	asserts("VirtualAppliance.one returns an VirtualAppliance object or nil") do
		VirtualAppliance.one.kind_of? VirtualAppliance or VirtualAppliance.one == nil
	end
end

context "test virtual datacenter methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("VirtualDatacenter.all returns an empty list or a list of VirtualDatacenter") do
		elems = VirtualDatacenter.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? VirtualDatacenter if elems.size > 0))
	end
	asserts("VirtualDatacenter.one returns an VirtualDatacenter object or nil") do 
		VirtualDatacenter.one.kind_of? VirtualDatacenter or VirtualDatacenter.one == nil
	end
end

context "test virtual machine methods" do
	setup do   
		Api.url = "http://10.60.10.2/api"
		Api.user = "admin"
		Api.password = "xabiquo"
	end

	asserts("VirtualMachine.all returns an empty list or a list of VirtualMachine") do
		elems = VirtualMachine.all
		elems.instance_of? Array and (elems.size == 0 or (elems[0].instance_of? VirtualMachine if elems.size > 0))
	end
	asserts("VirtualMachine.one returns an VirtualMachine object or nil") do
		VirtualMachine.one.kind_of? VirtualMachine or VirtualMachine.one == nil
	end
end
