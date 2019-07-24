--[==[	
-- Saya project
--
-- Created on 24.07.2019
-- File: MainMenuGui.lua
--]==]

MainMenuGui = {}
MainMenuGui.__index = MainMenuGui




function MainMenuGui:new(refGspot, refFontTable, Game)
	mainMenuGui = {
		gui = refGspot()
	}

	mainMenuGui.gui.style.unit = Game.SCREEN_SIZE * 0.08
	mainMenuGui.gui.style.font = refFontTable['PTMonoRegularBig']

	local mainButtonW, mainButtonH = mainMenuGui.gui.style.unit * 2, mainMenuGui.gui.style.unit
	local playButton = mainMenuGui.gui:button('Play', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = Game.SCREEN_SIZE * 0.5 - mainButtonH * 0.5,
		w = mainButtonW,
		h = mainButtonH
	})
	playButton.click = function(this)
		print('CLICK')
		Game:swapState(Game.GameStates.Playing)
	end

	local exitButton = mainMenuGui.gui:button('Exit', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = Game.SCREEN_SIZE * 0.5 + mainButtonW * 0.5,
		w = mainButtonW,
		h = mainButtonH
	})
	exitButton.click = function(this)
		print('CLICK')
		love.event.quit()
	end

	function mainMenuGui:update(dt)
		mainMenuGui.gui:update(dt)
	end

	function mainMenuGui:draw()
		mainMenuGui.gui:draw()
	end

	function mainMenuGui:mousepress(x, y, button)
		mainMenuGui.gui:mousepress(x, y, button)
	end

	function mainMenuGui:mouserelease(x, y, button)
		mainMenuGui.gui:mouserelease(x, y, button)
	end

	function mainMenuGui:mousewheel(x, y)
		mainMenuGui.gui:mousewheel(x, y)
	end

	return mainMenuGui
end