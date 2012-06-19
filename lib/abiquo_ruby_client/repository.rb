module Abiquo
	class Repository < Base
		class << self
			def all
				repositories = []
				
				ents = Enterprise.all
				return [] unless ents

				ents.each do |ent|
					repositories = repositories | ent.repositories
				end

				repositories
			end

			def one
				tmp = self.all
				return tmp.first if tmp
				nil
			end
		end

		def templates
		end
	end
end