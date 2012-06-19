module Abiquo
	class Template < Base
		class << self
			def all
				templates = []
				
				repos = Repository.all
				return [] unless repos

				repos.each do |repo|
					templates = templates | repo.templates
				end

				templates
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end
	end
end