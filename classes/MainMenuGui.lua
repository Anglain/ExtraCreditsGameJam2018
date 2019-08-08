--[==[	
-- Saya project
--
-- Created on 24.07.2019
-- File: MainMenuGui.lua
--]==]

MainMenuGui = {}
MainMenuGui.__index = MainMenuGui




function MainMenuGui:new(refGspot, refFontTable, Game)

	local mainMenuGui = {
		gui = refGspot(),
		creditsGui = refGspot(),
		States = {
			Menu = 'Menu',
			Credits = 'Credits'
		},
		state = ''
	}

	mainMenuGui.state = mainMenuGui.States.Menu
	mainMenuGui.gui.style.unit = Game.SCREEN_SIZE * 0.07
	mainMenuGui.gui.style.gapSize = Game.SCREEN_SIZE * 0.02
	mainMenuGui.gui.style.font = refFontTable['PTMonoRegularBig']
	mainMenuGui.creditsGui.style.font = refFontTable['PTMonoRegularBig']

	--[[ ================================== ]]
	--[[ ===== Main Menu Gui Elements ===== ]]
	--[[ ================================== ]]
	local mainButtonW, mainButtonH = mainMenuGui.gui.style.unit * 2.5, mainMenuGui.gui.style.unit
	local playButton = mainMenuGui.gui:button('Play', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = Game.SCREEN_SIZE * 0.5 - mainButtonH * 0.5,
		w = mainButtonW,
		h = mainButtonH
	})
	playButton.click = function(this)
		print('--- Play button clicked [MAIN_MENU_GUI]')
		Game:swapState(Game.GameStates.Playing)
	end

	local creditsButton = mainMenuGui.gui:button('Credits', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = playButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize,
		w = mainButtonW,
		h = mainButtonH
	})
	creditsButton.click = function(this)
		print('--- Credits button clicked [MAIN_MENU_GUI]')
		mainMenuGui.state = mainMenuGui.States.Credits
	end

	local exitButton = mainMenuGui.gui:button('Exit', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = creditsButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize,
		w = mainButtonW,
		h = mainButtonH
	})
	exitButton.click = function(this)
		print('--- Exit button clicked [MAIN_MENU_GUI]')
		love.event.quit()
	end


	--[[ ================================== ]]
	--[[ ====== Credits Gui Elements ====== ]]
	--[[ ================================== ]]
	local backFromCreditsButton = mainMenuGui.creditsGui:button('Back', {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 0.5,
		y = Game.SCREEN_SIZE * 0.5 - mainButtonH * 3,
		w = mainButtonW,
		h = mainButtonH
	})
	backFromCreditsButton.click = function(this)
		print('--- Back from credits button clicked [MAIN_MENU_GUI]')
		mainMenuGui.state = mainMenuGui.States.Menu
	end

	local creditsText = 'Game design - ...\nArt - ...\nProgramming - ...'
	local creditsTextObj = mainMenuGui.creditsGui:typetext(creditsText, {
		x = Game.SCREEN_SIZE * 0.5 - mainButtonW * 1.5,
		y = backFromCreditsButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize,
		w = mainButtonW * 3
	})


	--[[ ================================== ]]
	--[[ ======= Essential Functions ====== ]]
	--[[ ================================== ]]
	function mainMenuGui:update(dt)
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:update(dt)
		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:update(dt)
		end
	end

	function mainMenuGui:draw()
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:draw()
		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:draw()
		end
	end

	function mainMenuGui:mousepress(x, y, button)
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:mousepress(x, y, button)
		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:mousepress(x, y, button)
		end
	end

	function mainMenuGui:mouserelease(x, y, button)
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:mouserelease(x, y, button)
		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:mouserelease(x, y, button)
		end
	end

	function mainMenuGui:mousewheel(x, y)
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:mousewheel(x, y)
		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:mousewheel(x, y)
		end
	end

	return mainMenuGui
end