module Abiquo
	# Wait until all tasks are ended.
	#
	# params
	# tasks - list of links to a tasks
	def Abiquo.wait_for_tasks tasks
		return if not tasks
		tasks.each do |task|
			# If the tasks is not traceable, skip it
			next if task.include? "untraceable"

			# While until the task is finished
			finished = false
			
			while not finished
				res = Api.get(task).body
				
				finished = case res.task.state
				when "FINISHED_SUCCESSFULLY", "FINISHED_UNSUCCESSFULLY", "ABORTED"
					true
				when "PENDING", "STARTED"
					false
				else
					raise Exception.new "Unsuported state for task #{task}"
				end
			end
		end
	end
end