--[==[	
-- Saya project
--
-- Created on 24.07.2019
-- File: MainMenuGui.lua
--]==]

local inspect = require('../libs/inspect')

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
	mainMenuGui.gui.style.unit = Game.SCREEN_SIZE.h * 0.07
	mainMenuGui.gui.style.gapSize = Game.SCREEN_SIZE.h * 0.02
	mainMenuGui.gui.style.font = refFontTable['PTMonoRegularBig']
	mainMenuGui.creditsGui.style.font = refFontTable['PTMonoRegularBig']

	--[[ ================================== ]]
	--[[ ===== Main Menu Gui Elements ===== ]]
	--[[ ================================== ]]
	local sayaImage = love.graphics.newImage('images/PixelOwlShine_front.png')
	local mainButtonW, mainButtonH = mainMenuGui.gui.style.unit * 2.5, mainMenuGui.gui.style.unit
	local playButton = mainMenuGui.gui:imgbutton(nil, {
		x = Game.SCREEN_SIZE.w * 0.5 - sayaImage:getWidth() * 0.5,
		y = Game.SCREEN_SIZE.h * 0.5 - sayaImage:getHeight() * 0.5,
		w = sayaImage:getWidth(),
		h = sayaImage:getHeight()
	}, nil, sayaImage, true)

	-- Reverts colors to make highlight darken the image
	local defColor = playButton.style.default
	local highlightColor = playButton.style.hilite
	playButton.style.default = highlightColor
	playButton.style.hilite = defColor


	playButton.click = function(this)
		if Game.DEBUG then print('--- Play button clicked [MAIN_MENU_GUI]') end
		Game:swapState(Game.GameStates.Playing)
	end


	--[[ These three variables were created to make
		 credits text appearance nice and cyclic ]]
	local restartCreditsAnimation = false
	local stopCreditsAnimation = false

	local creditsButton = mainMenuGui.gui:button('Credits', {
		x = Game.SCREEN_SIZE.w * 0.5 - mainButtonW * 0.5,
		y = playButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize * 2,
		w = mainButtonW,
		h = mainButtonH
	})
	creditsButton.click = function(this)
		if Game.DEBUG then print('--- Credits button clicked [MAIN_MENU_GUI]') end
		mainMenuGui.state = mainMenuGui.States.Credits
		restartCreditsAnimation = true
		print('restartAnimation = ' .. tostring(restartCreditsAnimation))
	end


	local exitButton = mainMenuGui.gui:button('Exit', {
		x = Game.SCREEN_SIZE.w * 0.5 - mainButtonW * 0.5,
		y = creditsButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize,
		w = mainButtonW,
		h = mainButtonH
	})
	exitButton.click = function(this)
		if Game.DEBUG then print('--- Exit button clicked [MAIN_MENU_GUI]') end
		love.event.quit()
	end


	--[[ ================================== ]]
	--[[ ====== Credits Gui Elements ====== ]]
	--[[ ================================== ]]
	local backFromCreditsButton = mainMenuGui.creditsGui:button('Back', {
		x = Game.SCREEN_SIZE.w * 0.5 - mainButtonW * 0.5,
		y = Game.SCREEN_SIZE.h * 0.5 - mainButtonH * 3,
		w = mainButtonW,
		h = mainButtonH
	})
	backFromCreditsButton.click = function(this)
		if Game.DEBUG then print('--- Back from credits button clicked [MAIN_MENU_GUI]') end
		mainMenuGui.state = mainMenuGui.States.Menu
	end

	local creditsText = 'Game design - Anglain\n' ..
						'Art - TairaDomini\n' ..
						'Programming - Anglain\n' ..
						'Sound design - Anglain'
	local creditsTextObj = mainMenuGui.creditsGui:typetext(creditsText, {
		x = Game.SCREEN_SIZE.w * 0.5 - mainButtonW * 1.2,
		y = backFromCreditsButton.pos.y + mainButtonH + mainMenuGui.gui.style.gapSize,
		w = mainButtonW * 3
	})

	--[[ ================================== ]]
	--[[ ======= Essential Functions ====== ]]
	--[[ ================================== ]]
	local firstUpdate = true
	function mainMenuGui:update(dt)
		if mainMenuGui.state == mainMenuGui.States.Menu then
			mainMenuGui.gui:update(dt)
			if not firstUpdate then
				firstUpdate = true
			end

		elseif mainMenuGui.state == mainMenuGui.States.Credits then
			mainMenuGui.creditsGui:update(dt)

			if firstUpdate or stopCreditsAnimation then
				print('restartAnimation, stopAnimation and hideText variables were set')
				creditsTextObj.restartAnimation = restartCreditsAnimation
				creditsTextObj.stopAnimation = stopCreditsAnimation
				restartCreditsAnimation = false
				stopCreditsAnimation = false
				print('restartAnimation = ' .. tostring(restartCreditsAnimation))
				firstUpdate = false
			end
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
			stopCreditsAnimation = true
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
