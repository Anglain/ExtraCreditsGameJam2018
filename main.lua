--[==[
-- Saya project
--
-- Created on 19.07.2019
--]==]

-- Flusihing output to the console immideately
io.stdout:setvbuf('no')




function love.load()
	fontSize = 30

	fontMonospaced = love.graphics.newFont('fonts/PTMono-Regular.ttf', fontSize)

	letterChargeTime = 0.1
	pauseTime = 0.8

	text = 'Text one. '
	text2 = 'Text two. '
	text3 = 'Text three.'
	drawnText = ''
	textCoords = {x = 50, y = 70}
	currentTime = 0
	currentLetterIndex = 1
	drawingLetters = true

	scenario = {
		text,
		'pause',
		text2,
		'pause',
		text3
	}
	currentScenario = 1
end



function love.update(dt)
	currentTime = currentTime + dt

	if drawingLetters then

		if scenario[currentScenario] ~= 'pause' then

			if currentTime >= letterChargeTime then
				currentTime = 0

				local charFromIndex = scenario[currentScenario]:sub(currentLetterIndex, currentLetterIndex)
				drawnText = drawnText .. charFromIndex
				local drawableCharFromIndex = love.graphics.newText(fontMonospaced, charFromIndex)

				currentLetterIndex = currentLetterIndex + 1
				charFromIndex = scenario[currentScenario]:sub(currentLetterIndex, currentLetterIndex)
				if charFromIndex == ' ' then
					drawnText = drawnText .. charFromIndex
					currentLetterIndex = currentLetterIndex + 1
				end

				if currentLetterIndex > #scenario[currentScenario] then
					currentLetterIndex = 1
					currentScenario = currentScenario + 1
				end
			end

		else
			if currentTime >= pauseTime then
				currentScenario = currentScenario + 1
			end
		end

	end

	drawingLetters = not (currentScenario > #scenario)
end



function love.draw()
	love.graphics.setFont(fontMonospaced)
	love.graphics.draw(love.graphics.newText(fontMonospaced, drawnText), textCoords.x, textCoords.y)
end
