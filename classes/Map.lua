--[==[	
-- Saya project
--
-- Created on 23.07.2019
-- File: Map.lua
--]==]

Map = {}
Map.__index = Map



-- [=[ ========== LOCAL VARIABLES ========== ]=]
-- [=[ ======== LOCAL VARIABLES END ======== ]=]


-- [=[ ========== LOCAL CONSTANTS ========== ]=]
local MapStates = {
	World = 'world',
	InBuilding = {
		'inBuilding',
		building = nil
	}
}
-- [=[ ======== LOCAL CONSTANTS END ======== ]=]



function Map:new(tileSize, tilesNumber)

	local currentColor = {}

	local map = {
		tileSize = tileSize,
		tilesNumber = tilesNumber,
		color = {206/255, 214/255, 245/255, 1},
		color2 = {0, 0, 0, 1}
	}

	function map:update(dt)
		
	end

	function map:draw()
		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(map.color)
		love.graphics.rectangle('fill', 0, 0, map.tileSize * map.tilesNumber, map.tileSize * map.tilesNumber)
		love.graphics.setColor(map.color2)
		for i = 1,map.tilesNumber do
			for j = 1, map.tilesNumber do
				love.graphics.rectangle('line', (i-1) * map.tileSize, (j-1) * map.tileSize, map.tileSize, map.tileSize, 4, 4)
			end
		end
		love.graphics.setColor(currentColor)
	end

	return map
end