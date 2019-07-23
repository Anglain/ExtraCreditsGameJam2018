--[==[	
-- Saya project
--
-- Created on 23.07.2019
--]==]

Map = {}
Map.__index = Map


-- [=[ ========== LOCAL VARIABLES ========== ]=]
local currentColor = {}
-- [=[ ======== LOCAL VARIABLES END ======== ]=]


function Map:new(tileSize, mapTiles)
	local map = {
		tileSize = tileSize,
		tilesNumber = mapTiles,
		color = {206/255, 214/255, 245/255, 1}
	}

	function map:update(dt)

	end

	function map:draw()
		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(map.color)
		love.graphics.rectangle('fill', 0, 0, map.tileSize * map.tilesNumber, map.tileSize * map.tilesNumber)
		love.graphics.setColor(currentColor)
	end

	return map
end