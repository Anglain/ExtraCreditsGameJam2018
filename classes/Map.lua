--[==[	
-- Saya project
--
-- Created on 23.07.2019
-- File: Map.lua
--]==]

Map = {}
Map.__index = Map


function Map:new(tileSize, tilesNumber, Game)

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
		playerPos = {
			x = 0, y = 0
		},
		tiles = {
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 1, 1, 1, 0,
			0, 0, 0, 0, 0, 0, 3, 1, 1, 0,
			0, 0, 0, 0, 0, 0, 1, 1, 1, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 1, 3, 1, 0, 0, 0, 0, 0, 0,
			0, 1, 1, 1, 0, 0, 0, 0, 0, 0,
			0, 1, 1, 1, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
			0, 0, 0, 0, 0, 0, 0, 0, 0, 0
		},
		currentRoom = nil,
		rooms = {
			ROOM1 = 'room1',
			ROOM2 = 'room2',
			OUTSIDE = ''
		},
		room1 = { -- Parameters for one of the rooms
			tiles = {
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 3, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			},
			constraints = { -- These constraints need to be checked with <= and >= operators
				x = {
					small = 6,
					big = 8
				},
				y = {
					small = 1,
					big = 3
				}
			},
			exit = {
				x = 6,
				y = 2,
				dir = 'left'
			}
		},
		room2 = {
			tiles = {
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 0, 3, 0, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
				1, 0, 0, 0, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1
			},
			constraints = {
				x = {
					small = 1,
					big = 3,
				},
				y = {
					small = 5,
					big = 7
				}
			},
			exit = {
				x = 2,
				y = 5,
				dir = 'up'
			}
		}
	}

	function map:update(dt)
		
	end

	function map:draw()

		local curTilemap

		if checkIfInTheRoom() == map.rooms.ROOM1 then
			currentRoom = map.rooms.ROOM1
			curTilemap = map[currentRoom].tiles
		elseif checkIfInTheRoom() == map.rooms.ROOM2 then
			currentRoom = map.rooms.ROOM2
			curTilemap = map[currentRoom].tiles
		elseif checkIfInTheRoom() == map.rooms.OUTSIDE then
			currentRoom = nil
			curTilemap = map.tiles
		end

		currentColor[1], currentColor[2], currentColor[3], currentColor[4] = love.graphics.getColor()
		love.graphics.setColor(map.color)
		love.graphics.rectangle('fill', 0, 0, map.tileSize * map.tilesNumber, map.tileSize * map.tilesNumber)
		love.graphics.setColor(1, 1, 1, 1)
		for i = 1,map.tilesNumber do
			for j = 1, map.tilesNumber do
				local workQuad
				if curTilemap[(i-1)*map.tilesNumber + j] == 0 then
					workQuad = quads.GROUND
				elseif curTilemap[(i-1)*map.tilesNumber + j] == 3 then
					love.graphics.setColor(1, 1, 0, 1)
					workQuad = quads.EMPTY
				elseif curTilemap[(i-1)*map.tilesNumber + j] == 1 then
					workQuad = quads.EMPTY
				end
				love.graphics.draw(mapSpritesheet, workQuad, (j-1) * map.tileSize, (i-1) * map.tileSize)
				love.graphics.setColor(1, 1, 1, 1)
			end
		end
		love.graphics.setColor(currentColor)
	end

	function map:movePlayer(x, y)
		map.playerPos.x = x
		map.playerPos.y = y

		if Game.DEBUG then print(x, y) end

		if checkIfInTheRoom() == map.rooms.ROOM1 then
			return map.room1.constraints, map.room1.exit
		elseif checkIfInTheRoom() == map.rooms.ROOM2 then
			return map.room2.constraints, map.room2.exit
		else
			return nil, nil
		end
	end

	function checkIfInTheRoom()
		if map.playerPos.x >= map.room1.constraints.x.small and
		   map.playerPos.x <= map.room1.constraints.x.big and
		   map.playerPos.y >= map.room1.constraints.y.small and
		   map.playerPos.y <= map.room1.constraints.y.big then
		   	return map.rooms.ROOM1
	   	elseif map.playerPos.x >= map.room2.constraints.x.small and
		   map.playerPos.x <= map.room2.constraints.x.big and
		   map.playerPos.y >= map.room2.constraints.y.small and
		   map.playerPos.y <= map.room2.constraints.y.big then
		   	return map.rooms.ROOM2
		else
	   		return map.rooms.OUTSIDE
	   	end
	end

	return map
end