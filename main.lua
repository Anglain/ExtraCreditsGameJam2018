--[==[	
-- Saya project
--
-- Created on 19.07.2019
--]==]

-- Flusihing output to the console immideately
io.stdout:setvbuf('no')

-- [=[ ========== IMPORTS ========== ]=]
require('classes/Player')
-- [=[ ======== IMPORTS END ======== ]=]



-- [=[ ========== LOCAL VARIABLES ========== ]=]
local player = {}
local map = {}
-- [=[ ======== LOCAL VARIABLES END ======== ]=]



-- [=[ ========== CONSTANTS ========== ]=]
local TILE_SIZE = 64
local MAP_SIZE = 512
-- [=[ ======== CONSTANTS END ======== ]=]



function love.load()
	map = {
		size = MAP_SIZE
	}
	player = Player:new(1, 1, TILE_SIZE, map)

	love.graphics.setBackgroundColor(206/255, 214/255, 245/255, 1)
end



function love.update(dt)
	player:update(dt)
end



function love.draw()
	player:draw()
end



function love.keypressed(key)
	if key == 'f' then
		print('Respect paid.')
	elseif key == 'right' then
		player:move(1, 0)
	elseif key == 'left' then
		player:move(-1, 0)
	elseif key == 'up' then
		player:move(0, -1)
	elseif key == 'down' then
		player:move(0, 1)
	end
end