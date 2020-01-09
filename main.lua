--[==[	
-- Saya project
--
-- Created on 19.07.2019
-- File: main.lua
--]==]

-- Flusihing output to the console immideately
io.stdout:setvbuf('no')

-- [=[ ========== IMPORTS ========== ]=]
require('classes/Player')
require('classes/Map')
require('classes/MainMenuGui')
require('classes/GameGui')
require('classes/PauseGui')
gspot = require('libs/Gspot')
-- [=[ ======== IMPORTS END ======== ]=]


-- [=[ ========== LOCAL VARIABLES ========== ]=]
local Game = {
	DEBUG = false,
	TILE_SIZE = 64,
	MAP_TILES = 10,
	MAP_SIZE = 0, -- initialization is under the Game table
	SCREEN_SIZE = {
		w = 1280,
		h = 720
	},
	gameState = nil,

	GameStates = {
		MainMenu = 'MainMenu',
		Playing = 'Playing',
		Paused = 'Paused'
	}
}
Game.MAP_SIZE = Game.TILE_SIZE * Game.MAP_TILES

local player = {}
local map = {}
local graphicsTranslation = { x = 0, y = 0 }

local fontTable = {}
local mainMenuGui = {}
local gameGui = {}
local pauseGui = {}
-- [=[ ======== LOCAL VARIABLES END ======== ]=]




function love.load()

	fontTable['ArvoRegular'] = love.graphics.newFont('fonts/Arvo-Regular.ttf', 24)
	fontTable['ArvoRegularItalic'] = love.graphics.newFont('fonts/Arvo-RegularItalic.ttf', 24)
	fontTable['ArvoBold'] = love.graphics.newFont('fonts/Arvo-Bold.ttf', 24)
	fontTable['ArvoBoldItalic'] = love.graphics.newFont('fonts/Arvo-BoldItalic.ttf', 24)
	fontTable['PTMonoRegularLarge'] = love.graphics.newFont('fonts/PTMono-Regular.ttf', 36)
	fontTable['PTMonoRegularBig'] = love.graphics.newFont('fonts/PTMono-Regular.ttf', 22)
	fontTable['PTMonoRegularSmall'] = love.graphics.newFont('fonts/PTMono-Regular.ttf', 12)

	map = Map:new(Game.TILE_SIZE, Game.MAP_TILES, Game)
	player = Player:new(0, 0, Game.TILE_SIZE, map, Game)
	graphicsTranslation.x = graphicsTranslation.x - Game.SCREEN_SIZE.w * 0.5 + Game.TILE_SIZE * 0.5
	graphicsTranslation.y = graphicsTranslation.y - Game.SCREEN_SIZE.h * 0.5 + Game.TILE_SIZE * 0.5

	mainMenuGui = MainMenuGui:new(gspot, fontTable, Game)
	gameGui = GameGui:new(gspot, fontTable, Game)
	pauseGui = PauseGui:new(gspot, fontTable, Game)

	Game.gameState = Game.GameStates.MainMenu
	love.graphics.setBackgroundColor(123/255, 147/255, 158/255, 1)

end



function love.update(dt)
	if Game.gameState == Game.GameStates.MainMenu then

		mainMenuGui:update(dt)

	elseif Game.gameState == Game.GameStates.Playing then

		map:update(dt)
		player:update(dt)

		gameGui:update(dt)

	elseif Game.gameState == Game.GameStates.Paused then
		
		map:update(dt)
		player:update(dt)

		pauseGui:update(dt)

	end
end



function love.draw()
	if Game.gameState == Game.GameStates.MainMenu then

		mainMenuGui:draw()

	elseif Game.gameState == Game.GameStates.Playing then

		love.graphics.translate(-1 * graphicsTranslation.x, -1 * graphicsTranslation.y)
		map:draw()
		player:draw()
		love.graphics.translate(graphicsTranslation.x, graphicsTranslation.y)
		gameGui:draw()

	elseif Game.gameState == Game.GameStates.Paused then

		love.graphics.translate(-1 * graphicsTranslation.x, -1 * graphicsTranslation.y)
		map:draw()
		player:draw()
		love.graphics.translate(graphicsTranslation.x, graphicsTranslation.y)
		pauseGui:draw()
	end
end



function love.keypressed(key)

	if key == 'f' then
		Game:swapState((Game.gameState == Game.GameStates.Playing and Game.GameStates.MainMenu) or Game.GameStates.Playing)
	end

	if Game.gameState == Game.GameStates.MainMenu then

		if key == 'a' then
			print('In main menu right now')
		end

	elseif Game.gameState == Game.GameStates.Playing then

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

		if key == 'p' then
			Game:swapState(Game.GameStates.Paused)
		end

		graphicsTranslation.x = graphicsTranslation.x + moveGraphics.x
		graphicsTranslation.y = graphicsTranslation.y + moveGraphics.y

	elseif Game.gameState == Game.GameStates.Paused then

		if key == 'p' then
			Game:swapState(Game.GameStates.Playing)
		elseif key == 'm' then
			Game:swapState(Game.GameStates.MainMenu)
		end
	end
end

-- [=[ ======== REGISTERING MOUSE EVENTS TO THE GUI ======== ]=]
love.mousepressed = function(x, y, button)
	if Game.gameState == Game.GameStates.MainMenu then
		mainMenuGui:mousepress(x, y, button)
	elseif Game.gameState == Game.GameStates.Playing then
		gameGui:mousepress(x, y, button)
	elseif Game.gameState == Game.GameStates.Paused then
		pauseGui:mousepress(x, y, button)
	end
end

love.mousereleased = function(x, y, button)
	if Game.gameState == Game.GameStates.MainMenu then
		mainMenuGui:mouserelease(x, y, button)
	elseif Game.gameState == Game.GameStates.Playing then
		gameGui:mouserelease(x, y, button)
	elseif Game.gameState == Game.GameStates.Paused then
		pauseGui:mouserelease(x, y, button)
	end
end

love.wheelmoved = function(x, y)
	if Game.gameState == Game.GameStates.MainMenu then
		mainMenuGui:mousewheel(x, y)
	elseif Game.gameState == Game.GameStates.Playing then
		gameGui:mousewheel(x, y)
	elseif Game.gameState == Game.GameStates.Paused then
		pauseGui:mousewheel(x, y)
	end
end
-- [=[ ================= MOUSE EVENTS END ================= ]=]


-- [=[ ================== OTHER FUNCTIONS ================== ]=]

function Game:swapState(state)
	if Game.DEBUG then print('Changed state to ' .. state) end
	Game.gameState = state
end

-- [=[ ================ OTHER FUNCTIONS END ================ ]=]