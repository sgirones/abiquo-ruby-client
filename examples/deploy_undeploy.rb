#Deploy and Undeploy actions provides tasks' links so we can monitor it.

puts "Undeploy..."
Abiquo::wait_for_tasks(Abiquo::VirtualAppliance.one.undeploy)
puts "Deploy..."
Abiquo::wait_for_tasks(Abiquo::VirtualAppliance.one.deploy)