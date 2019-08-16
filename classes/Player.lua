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



function Player:new(pos_x, pos_y, tileSize, Map, Game)

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
		map = Map,
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
		-- Finding new position
		local newPos = {
			x = player.pos.x + dx,
			y = player.pos.y + dy
		}

		local mapMoveVector = {
			x = 0,
			y = 0
		}
		
		-- Setting direction
		if newPos.x > player.pos.x then newPos.dir = Directions.right
		elseif newPos.x < player.pos.x then newPos.dir = Directions.left
		elseif newPos.y > player.pos.y then newPos.dir = Directions.down
		elseif newPos.y < player.pos.y then newPos.dir = Directions.up
		end

		-- Change direction logging
		if player.direction ~= newPos.dir then
			if Game.DEBUG then print('Direction changed to ' .. newPos.dir .. '!') end
		end

		print(newPos.x, newPos.y, newPos.dir)
		print(player.pos.x, player.pos.y, player.direction)

		-- If in the room and goes to the exit - unlock the room constraints
		if player.constraints.exit then
			if player.pos.x == player.constraints.exit.x and 
				player.pos.y == player.constraints.exit.y and 
				newPos.dir == player.constraints.exit.dir then
				player:unsetRoomConstraints()
			end
		end

		-- Setting new player position depending on the constraints
		--[[if newPos.x >= player.constraints.x.small and newPos.x <= player.constraints.x.big then
			if player.map:nextTileIsWalkable(player.pos.x,
											 player.pos.y,
											 newPos.dir,
											 player.map.currentTilemap) then
				player.pos.x = newPos.x
			end
		elseif newPos.x > player.constraints.x.big then
			player.pos.x = player.constraints.x.big
		elseif newPos.x < player.constraints.x.small then
			player.pos.x = player.constraints.x.small
		end

		if newPos.y >= player.constraints.y.small and newPos.y <= player.constraints.y.big then
			if player.map:nextTileIsWalkable(player.pos.x,
											 player.pos.y,
											 newPos.dir,
											 player.map.currentTilemap) then
				player.pos.y = newPos.y
			end
		elseif newPos.y > player.constraints.y.big then
			player.pos.y = player.constraints.y.big
		elseif newPos.y < player.constraints.y.small then
			player.pos.y = player.constraints.y.small
		end--]]

		if player.map:nextTileIsWalkable(player.pos.x,
										 player.pos.y,
										 newPos.dir,
										 player.map.currentTilemap) then
			player.pos.x = newPos.x
			player.pos.y = newPos.y
			mapMoveVector.x = dx * player.size
			mapMoveVector.y = dy * player.size
		end

		player.direction = newPos.dir

		-- Getting new constraints and exit, if player enters the room
		local constraints, exit = Map:movePlayer(player.pos.x, player.pos.y)
		if constraints then
			player:setRoomConstraints(constraints, exit)
		end

		-- Returns move vector multiplied by tile size (for camera translation)
		--[[return {
			x = (newPos.x >= player.constraints.x.small and 
				((newPos.x <= player.constraints.x.big and dx * player.size) or 
					0)) or 0,
			y = (newPos.y >= player.constraints.y.small and 
				((newPos.y <= player.constraints.y.big and dy * player.size) or 
					0)) or 0
		}--]]
		return mapMoveVector
	end

	function player:setRoomConstraints(constraints, exit)
		player.constraints = {
			x = {
				small = constraints.x.small,
				big = constraints.x.big
			},
			y = {
				small = constraints.y.small,
				big = constraints.y.big
			},
			exit = {
				x = exit.x,
				y = exit.y,
				dir = exit.dir
			}
		}
	end

	function player:unsetRoomConstraints()
		player.constraints.x.small = 0
		player.constraints.x.big = player.map.tilesNumber - 1
		player.constraints.y.small = 0
		player.constraints.y.big = player.map.tilesNumber - 1

		player.constraints.exit = nil
	end

	return player
end