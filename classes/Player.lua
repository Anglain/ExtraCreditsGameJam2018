--[==[	
-- Saya project
--
-- Created on 22.07.2019
-- File: Player.lua
--]==]

Player = {}
Player.__index = Player



-- [=[ ========== LOCAL CONSTANTS ========== ]=]
local Directions = {
	up = 'up',
	down = 'down',
	right = 'right',
	left = 'left'
}
-- [=[ ======== LOCAL CONSTANTS END ======== ]=]



function Player:new(pos_x, pos_y, tileSize, mapRef, Game)

	local currentColor = {}

	local player = {
		pos = {
			x = pos_x,
			y = pos_y
		},
		size = tileSize,
		direction = Directions.down,
		constraints = {
			x = {
				small,
				big
			},
			y = {
				small,
				big
			}
		},
		map = mapRef,
		color = {145/255, 126/255, 100/255, 1},
		img = love.graphics.newImage('images/Saya.png')
	}
	player.constraints.x.small = 0
	player.constraints.x.big = player.map.tilesNumber - 1
	player.constraints.y.small = 0
	player.constraints.y.big = player.map.tilesNumber - 1

	function player:update(dt)
		--
	end

	function player:draw()
		love.graphics.draw(player.img, player.pos.x * player.size, player.pos.y * player.size)
	end

	function player:move(dx, dy)

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
			if Game.DEBUG then print('Direction changed to ' .. newPos.dir .. '!') end
		end

		player.pos.x = (newPos.x >= player.constraints.x.small and 
			((newPos.x <= player.constraints.x.big and newPos.x) 
				or player.constraints.x.big)) or player.constraints.x.small
		player.pos.y = (newPos.y >= player.constraints.y.small and 
			((newPos.y <= player.constraints.y.big and newPos.y) 
				or player.constraints.y.big)) or player.constraints.y.small
		player.direction = newPos.dir

		mapRef:movePlayer(player.pos.x, player.pos.y)
		-- Returns move vector multiplied by tile size (for camera translation)
		return {
			x = (newPos.x >= 0 and ((newPos.x < player.map.tilesNumber and dx * player.size) or 0)) or 0,
			y = (newPos.y >= 0 and ((newPos.y < player.map.tilesNumber and dy * player.size) or 0)) or 0
		}
	end

	return player
end