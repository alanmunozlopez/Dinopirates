local floorRanges = {
	{ start = 101, stop = 116 },
	{ start = 201, stop = 216 }
}

for _, range in ipairs(floorRanges) do
	for i = range.start, range.stop do
		local className = "Floor" .. i
		_G[className] = {}
		class(className).extends(MazeScene)

		_G[className].init = function(self)
			self:setFloor((i % 100)) -- Gives 1–16
			_G[className].super.init(self)
			PlayerData.saveLevel = i
		end

		_G[className].exit = function(self)
			_G[className].super.exit(self)
		end
	end
end