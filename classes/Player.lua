--[==[	
-- Saya project
--
-- Created on 22.07.2019
--]==]

Player = {}
Player.__index = Player


-- [=[ ========== LOCAL VARIABLES ========== ]=]
local currentColor = {}
-- [=[ ======== LOCAL VARIABLES END ======== ]=]

-- [=[ ========== LOCAL CONSTANTS ========== ]=]
local Directions = {
	up = 'up',
	down = 'down',
	right = 'right',
	left = 'left'
}
-- [=[ ======== LOCAL CONSTANTS END ======== ]=]


function Player:new(pos_x, pos_y, tileSize, mapRef)
	local player = {
		pos = {
			x = pos_x,
			y = pos_y
		},
		size = tileSize,
		direction = Directions.down,
		map = mapRef,
		color = {145/255, 126/255, 100/255, 1}
	}

	function player:update(dt)

	end

	function player:draw()
		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(player.color)
		love.graphics.rectangle('fill', player.pos.x * player.size, player.pos.y * player.size, player.size, player.size)
		love.graphics.setColor(currentColor)
	end

	function player:move(dx, dy)
		-- ===================================================================================================
		-- ============== TODO _____ MAKE PLAYER MOVEMENT CENTERED AROUND THE CAMERA _____ TODO ==============
		-- ===================================================================================================

		local newPos = {
			x = player.pos.x + dx,
			y = player.pos.y + dy
		}
		
		if newPos.x > player.pos.x then newPos.dir = Directions.right
		elseif newPos.x < player.pos.x then newPos.dir = Directions.left
		elseif newPos.y > player.pos.y then newPos.dir = Directions.down
		elseif newPos.y < player.pos.y then newPos.dir = Directions.up
		end

		if player.direction ~= newPos.dir then
			print('Direction changed to ' .. newPos.dir .. '!')
		end

		player.pos.x = (newPos.x >= 0 and ((newPos.x < player.map.tilesNumber and newPos.x) or player.map.tilesNumber - 1)) or 0
		player.pos.y = (newPos.y >= 0 and ((newPos.y < player.map.tilesNumber and newPos.y) or player.map.tilesNumber - 1)) or 0
		player.direction = newPos.dir

		return {
			x = (newPos.x >= 0 and ((newPos.x < player.map.tilesNumber and dx * player.size) or 0)) or 0,
			y = (newPos.y >= 0 and ((newPos.y < player.map.tilesNumber and dy * player.size) or 0)) or 0
		}
	end

	return player
end