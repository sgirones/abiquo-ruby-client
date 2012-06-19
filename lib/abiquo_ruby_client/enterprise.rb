module Abiquo
	class Enterprise < Base
		RESOURCE_PATH = "/admin/enterprises"
		RESOURCE_COLLECTION = "enterprises"
		RESOURCE_ELEMENT = "enterprise"

		class << self
			def all
				elems = []
				get_resource(RESOURCE_PATH, RESOURCE_COLLECTION, RESOURCE_ELEMENT).each do |data|
					elems << self.new(data)
				end
				elems
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end

		# Return all the users
		def users
			elems = []
			get_resource_link(:users, "users", "user").each do |data|
				elems << data
				# elems << User.new(data)
			end
			elems
		end

		# Return all the repositories
		def repositories
			elems = []
			get_resource_link(:datacenterrepositories, "datacenterRepositories", "datacenterRepository").each do |data|
				elems << Repository.new(data)
			end
			elems
		end
	end
end