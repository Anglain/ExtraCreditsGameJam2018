--[==[	
-- Saya project
--
-- Created on 19.07.2019
--]==]

-- Flusihing output to the console immideately
io.stdout:setvbuf('no')

-- [=[ ========== IMPORTS ========== ]=]
require('classes/Player')
require('classes/Map')
-- [=[ ======== IMPORTS END ======== ]=]



-- [=[ ========== LOCAL VARIABLES ========== ]=]
local player = {}
local map = {}
local graphicsTranslation = { x = 0, y = 0 }
-- [=[ ======== LOCAL VARIABLES END ======== ]=]



-- [=[ ========== CONSTANTS ========== ]=]
local TILE_SIZE = 64
local MAP_TILES = 10
-- [=[ ======== CONSTANTS END ======== ]=]



function love.load()
	map = Map:new(TILE_SIZE, MAP_TILES)
	player = Player:new(0, 0, TILE_SIZE, map)
	graphicsTranslation.x = graphicsTranslation.x - TILE_SIZE * MAP_TILES * 0.5 + TILE_SIZE * 0.5
	graphicsTranslation.y = graphicsTranslation.y - TILE_SIZE * MAP_TILES * 0.5 + TILE_SIZE * 0.5
end



function love.update(dt)
	map:update(dt)
	player:update(dt)
end



function love.draw()
	love.graphics.translate(-1 * graphicsTranslation.x, -1 * graphicsTranslation.y)
	map:draw()
	player:draw()
end



function love.keypressed(key)
	local moveGraphics = {x = 0, y = 0}

	if key == 'f' then
		print('Respect paid.')
	elseif key == 'right' then
		moveGraphics = player:move(1, 0)
	elseif key == 'left' then
		moveGraphics = player:move(-1, 0)
	elseif key == 'up' then
		moveGraphics = player:move(0, -1)
	elseif key == 'down' then
		moveGraphics = player:move(0, 1)
	end

	graphicsTranslation.x = graphicsTranslation.x + moveGraphics.x
	graphicsTranslation.y = graphicsTranslation.y + moveGraphics.y
end