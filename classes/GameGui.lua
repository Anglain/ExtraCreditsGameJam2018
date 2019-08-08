--[==[	
-- Saya project
--
-- Created on 24.07.2019
-- File: GameGui.lua
--]==]

GameGui = {}
GameGui.__index = GameGui




function GameGui:new(refGspot, refFontTable, Game)
	local gameGui = {
		gui = refGspot()
	}

	gameGui.gui.style.unit = Game.SCREEN_SIZE * 0.04
	gameGui.gui.style.font = refFontTable['PTMonoRegularSmall']

	local mainMenuButW, mainMenuButH = gameGui.gui.style.unit * 3, gameGui.gui.style.unit
	local mainMenuButton = gameGui.gui:button('Main Menu', {
		x = 16,
		y = 16,
		w = mainMenuButW,
		h = mainMenuButH
	})
	mainMenuButton.click = function(this)
		print('--- Main menu button clicked [GAME_GUI]')
		Game:swapState(Game.GameStates.MainMenu)
	end


	function gameGui:update(dt)
		gameGui.gui:update(dt)
	end

	function gameGui:draw()

		gameGui.gui:draw()
	end

	function gameGui:mousepress(x, y, button)
		gameGui.gui:mousepress(x, y, button)
	end

	function gameGui:mouserelease(x, y, button)
		gameGui.gui:mouserelease(x, y, button)
	end

	function gameGui:mousewheel(x, y)
		gameGui.gui:mousewheel(x, y)
	end

	return gameGui
end