class TeamChecker
	def self.valid?(team, monster_id)
		team.each do |member|
			ap member
			if member == monster_id
				return false
			end
		end
		true
	end
end