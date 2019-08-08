--[==[	
-- Saya project
--
-- Created on 08.08.2019
-- File: PauseGui.lua
--]==]

PauseGui = {}
PauseGui.__index = PauseGui




function PauseGui:new(refGspot, refFontTable, Game)
	local pauseGui = {
		gui = refGspot()
	}

	pauseGui.gui.style.unit = Game.SCREEN_SIZE * 0.08
	pauseGui.gui.style.gapSize = Game.SCREEN_SIZE * 0.02
	pauseGui.gui.style.font = refFontTable['PTMonoRegularLarge']


	--[[ ================================== ]]
	--[[ ======= Pause Gui Elements ======= ]]
	--[[ ================================== ]]
	local pauseButtonW, pauseButtonH = pauseGui.gui.style.unit * 2.3, pauseGui.gui.style.unit * 1.5
	local pauseText = 'Paused'
	local pauseTextObj = pauseGui.gui:text(pauseText, {
		x = Game.SCREEN_SIZE * 0.5 - pauseButtonW * 0.75,
		y = Game.SCREEN_SIZE * 0.5 - pauseButtonH * 0.5,
		w = pauseButtonW * 1.5
	})


	--[[ ================================== ]]
	--[[ ======= Essential Functions ====== ]]
	--[[ ================================== ]]
	function pauseGui:update(dt)
		pauseGui.gui:update(dt)
	end

	function pauseGui:draw()
		love.graphics.setColor(0/255, 0/255, 0/255, 0.3)
		love.graphics.rectangle('fill', 0, 0, Game.SCREEN_SIZE, Game.SCREEN_SIZE)
		pauseGui.gui:draw()
	end

	function pauseGui:mousepress(x, y, button)
		pauseGui.gui:mousepress(x, y, button)
	end

	function pauseGui:mouserelease(x, y, button)
		pauseGui.gui:mouserelease(x, y, button)
	end

	function pauseGui:mousewheel(x, y)
		pauseGui.gui:mousewheel(x, y)
	end

	return pauseGui
end