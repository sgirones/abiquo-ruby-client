vapp = {
	"name" => "test5"
}

begin
	pp Abiquo::VirtualDatacenter.one.add_virtual_appliance vapp
rescue Exception => e
	pp e.response[:body]
	pp e.backtrace
end