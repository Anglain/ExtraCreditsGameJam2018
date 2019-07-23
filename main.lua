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
gui = require('libs/Gspot')
-- [=[ ======== IMPORTS END ======== ]=]



-- [=[ ========== LOCAL VARIABLES ========== ]=]
local player = {}
local map = {}
local graphicsTranslation = { x = 0, y = 0 }

local gameState = ''
local mainMenuGui = gui()
local gameGui = gui()
-- [=[ ======== LOCAL VARIABLES END ======== ]=]



-- [=[ ========== CONSTANTS ========== ]=]
local TILE_SIZE = 64
local MAP_TILES = 10
local MAP_SIZE = TILE_SIZE * MAP_TILES

local GameStates = {
	MainMenu = 'MainMenu',
	Playing = 'Playing'
}
-- [=[ ======== CONSTANTS END ======== ]=]



function love.load()
	map = Map:new(TILE_SIZE, MAP_TILES)
	player = Player:new(0, 0, TILE_SIZE, map)
	graphicsTranslation.x = graphicsTranslation.x - MAP_SIZE * 0.5 + TILE_SIZE * 0.5
	graphicsTranslation.y = graphicsTranslation.y - MAP_SIZE * 0.5 + TILE_SIZE * 0.5

	gameState = GameStates.MainMenu

	initMainMenuGui()
	initGameGui()
end



function love.update(dt)
	if gameState == GameStates.MainMenu then
		mainMenuGui:update(dt)
	elseif gameState == GameStates.Playing then
		map:update(dt)
		player:update(dt)

		gameGui:update(dt)
	end
end



function love.draw()
	if gameState == GameStates.MainMenu then
		mainMenuGui:draw()
	elseif gameState == GameStates.Playing then
		gameGui:draw()
		love.graphics.translate(-1 * graphicsTranslation.x, -1 * graphicsTranslation.y)
		map:draw()
		player:draw()
	end
end



function love.keypressed(key)

	if key == 'f' then
		swapState((gameState == GameStates.Playing and GameStates.MainMenu) or GameStates.Playing)
	end

	if gameState == GameStates.MainMenu then

		if key == 'a' then
			print('In main menu right now')
		end

	elseif gameState == GameStates.Playing then

		local moveGraphics = {x = 0, y = 0}

		if key == 'right' then
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
end

-- [=[ ======== REGISTERING MOUSE EVENTS TO THE GUI ======== ]=]
love.mousepressed = function(x, y, button)
	if gameState == GameStates.MainMenu then
		mainMenuGui:mousepress(x, y, button)
	elseif gameState == GameStates.Playing then
		gameGui:mousepress(x, y, button)
	end
end

love.mousereleased = function(x, y, button)
	if gameState == GameStates.MainMenu then
		mainMenuGui:mouserelease(x, y, button)
	elseif gameState == GameStates.Playing then
		gameGui:mouserelease(x, y, button)
	end
end

love.wheelmoved = function(x, y)
	if gameState == GameStates.MainMenu then
		mainMenuGui:mousewheel(x, y)
	elseif gameState == GameStates.Playing then
		gameGui:mousewheel(x, y)
	end
end
-- [=[ ================= MOUSE EVENTS END ================= ]=]

function swapState(state)
	print('Changed state to ' .. state)
	gameState = state
end


function initMainMenuGui()
	mainMenuGui.style.unit = MAP_SIZE * 0.1

	local playButtonW, playButtonH = 96, mainMenuGui.style.unit
	local playButton = mainMenuGui:button('Play', {
		x = MAP_SIZE * 0.5 - playButtonW * 0.5,
		y = MAP_SIZE * 0.5 - playButtonH * 0.5,
		w = playButtonW,
		h = playButtonH
	})
	playButton.click = function(this)
		print('CLICK')
		swapState(GameStates.Playing)
	end
end

function initGameGui()
	gameGui.style.unit = MAP_SIZE * 0.04

	local mainMenuButW, mainMenuButH = gameGui.style.unit * 3, gameGui.style.unit
	local mainMenuButton = gameGui:button('Main Menu', {
		x = 16,
		y = 16,
		w = mainMenuButW,
		h = mainMenuButH
	})
	mainMenuButton.click = function(this)
		print('CLICK')
		swapState(GameStates.MainMenu)
	end
end