--[==[	
-- Saya project
--
-- Created on 19.08.2019
-- File: DialogueWindow.lua
--]==]
DialogueWindow = {}
DialogueWindow.__index = DialogueWindow

function DialogueWindow:new(refGspot, refFontTable, Game)
	local dialogue = {
		gui = refGspot(),
		scenes
	}

	function dialogue:update(dt)
		dialogue.gui:update(dt)
	end

	function dialogue:draw()
		dialogue.gui:draw()
	end

	function dialogue:mousepress(x, y, button)
		dialogue.gui:mousepress(x, y, button)
	end

	function dialogue:mouserelease(x, y, button)
		dialogue.gui:mouserelease(x, y, button)
	end

	function dialogue:mousewheel(x, y)
		dialogue.gui:mousewheel(x, y)
	end

	return dialogue
end