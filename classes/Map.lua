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
		GROUND = love.graphics.newQuad(0, 0, tileSize, tileSize, mapSpritesheet:getDimensions()),
		EMPTY = love.graphics.newQuad(tileSize, 0, tileSize, tileSize, mapSpritesheet:getDimensions()),
	}

	local map = {
		tileSize = tileSize,
		tilesNumber = tilesNumber,
		color = {206/255, 214/255, 245/255, 1},
		tiles = {
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		}
	}

	function map:update(dt)
		
	end

	function map:draw()
		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(map.color)
		love.graphics.rectangle('fill', 0, 0, map.tileSize * map.tilesNumber, map.tileSize * map.tilesNumber)
		for i = 1,map.tilesNumber do
			for j = 1, map.tilesNumber do
				local workQuad
				if map.tiles[(i-1)*map.tilesNumber + j] == 0 then
					workQuad = quads.GROUND
				elseif map.tiles[(i-1)*map.tilesNumber + j] == 1 then
					workQuad = quads.EMPTY
				end
				love.graphics.draw(mapSpritesheet, workQuad, (i-1) * map.tileSize, (j-1) * map.tileSize)
			end
		end
		love.graphics.setColor(currentColor)
	end

	return map
end