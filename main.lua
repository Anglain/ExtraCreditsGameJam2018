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
	pauseTime = 1

	text = 'And so...'
	text2 = 'It began'
	drawnText = ''
	textCoords = {x = 50, y = 70}
	currentTime = 0
	currentLetterIndex = 1
	drawingLetters = true
end

function love.update(dt)
	currentTime = currentTime + dt

	if drawingLetters and currentTime >= letterChargeTime then

		currentTime = 0

		charFromIndex = text:sub(currentLetterIndex, currentLetterIndex)
		drawnText = drawnText .. charFromIndex
		drawableCharFromIndex = love.graphics.newText(fontMonospaced, charFromIndex)

		currentLetterIndex = currentLetterIndex + 1
		drawingLetters = not (currentLetterIndex > #text)
	end
end

function love.draw()
	love.graphics.setFont(fontMonospaced)
	love.graphics.draw(love.graphics.newText(fontMonospaced, drawnText), textCoords.x, textCoords.y)
end