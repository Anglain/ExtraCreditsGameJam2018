--[==[	
-- Saya project
--
-- Created on 23.07.2019
-- File: Map.lua
--]==]

Map = {}
Map.__index = Map



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
	local mapSpritesheet = love.graphics.newImage('images/SayaTestSpritesheet.png')
	local quads = {
		GROUND = love.graphics.newQuad(0, 0, tileSize, tileSize, mapSpritesheet:getDimensions())
	}

	local map = {
		tileSize = tileSize,
		tilesNumber = tilesNumber,
		color = {206/255, 214/255, 245/255, 1}
	}

	function map:update(dt)
		
	end

	function map:draw()
		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(map.color)
		love.graphics.rectangle('fill', 0, 0, map.tileSize * map.tilesNumber, map.tileSize * map.tilesNumber)
		for i = 1,map.tilesNumber do
			for j = 1, map.tilesNumber do
				love.graphics.draw(mapSpritesheet, quads.GROUND, (i-1) * map.tileSize, (j-1) * map.tileSize)
			end
		end
		love.graphics.setColor(currentColor)
	end

	return map
end