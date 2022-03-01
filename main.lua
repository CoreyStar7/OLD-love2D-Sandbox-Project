-- [Settings] --

-- Background
bgRed = 95/255
bgGreen = 175/255
bgBlue = 175/255
bgAlpha = 50/100

-- Stats and Fonts
printStatistics = true
customFont = true
titleFontSize = 18
bodyFontSize = 15

-- Basic Settings
drawPhoto = true
drawVideo = true
loadAudio = true

-- Load into Memory
function love.load()
	-- Requires
	require("middleclass")

	-- Global
	mediaAssetsPath = "mediaAssets"
	uiAssetsPath = "uiAssets"

	-- Fonts
	getDPIScale = love.graphics.getDPIScale()
	sysInfoTitle = love.graphics.newFont("VCR_OSD_MONO.ttf", titleFontSize, "normal", getDPIScale)
	sysInfoBody = love.graphics.newFont("VCR_OSD_MONO.ttf", bodyFontSize, "normal", getDPIScale)

	-- Image
	imageData = love.graphics.newImage(mediaAssetsPath.."/examplePhoto.jpg")
	imageDataposX = 50
	imageDataposY = 50

	-- Video
	videoStream = love.graphics.newVideo(mediaAssetsPath.."/exampleVideo.ogv") -- OGV ONLY! -- Will Play Constantly, please fix!
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setColor(255,255,255)
	
	-- Sound
	soundData = love.sound.newSoundData(mediaAssetsPath.."/exampleAudio.mp3") -- Will Play Constantly, please fix!
	uiClick = love.sound.newSoundData(uiAssetsPath.."/uiClick.wav")
	
	-- Buttons
	buttons = {}
	buttons['exitSession'] = {text = 'Exit Session', x=500, y=155, w=110, h=15}
	buttons['showImage'] = {text = 'Show Image', x=250, y=155, w=100, h=15}
	buttons['playVideo'] = {text = 'Play Video', x=125, y=155, w=100, h=15}
	buttons['playAudio'] = {text = 'Play Audio', x=0, y=155, w=100, h=15}
end

-- Functions --
function printStats()
	if printStatistics then
		love.graphics.print("System Information:",sysInfoTitle,0,0)
		love.graphics.setFont(sysInfoBody)
		love.graphics.print("currentOS: "..love.system.getOS(),0,20)
		love.graphics.print("osPowerInfo: "..love.system.getPowerInfo(),0,35)
		love.graphics.print("cpuThreads: "..love.system.getProcessorCount(),0,50)
		love.graphics.print("cpuFrameTime: "..os.clock(),0,65)
		love.graphics.print("osDate : "..os.date(),0,80)
		love.graphics.print("osTime : "..os.time(),0,95)
		--love.graphics.print("envINT: "..os.getenv(),0,110) [BROKEN, HYSTON PLEASE FIX]
	end
end

function exitSession()
	EXITbuttonClicked = false
	if not EXITbuttonClicked then
		EXITbuttonClicked = true
		os.exit()
	end
end

function drawImage()
	if drawPhoto then
		imageDrawn = false
		if not imageDrawn then
			imageDrawn = true
		else
			love.graphics:release(imageData)
		end
	elseif not drawImage then
		love.graphics.print("Image will not Draw.",0,110)
	end
end

function drawVideo()
	if drawVideo then
		videoPlaying = false
		if not videoPlaying then
			videoPlaying = true
			videoStream:play()
			playing = videoStream:isPlaying()
			if not playing then
				videoStream:release()
			end
		end
	elseif not drawVideo then
		love.graphics.print("Video will not Draw.",0,125)
	end
end

function playSFX()
	if loadAudio then
		audioPlayed = false
		if not audioPlayed then
			audioPlayed = true
			sfx = love.audio.newSource(soundData)
			sfx:play()
		end
	elseif not loadAudio then
		love.graphics.print("Sound Effect will not Play.",0,140)
	end
end

-- Button Functions --
pressed_button = function (buttons)
	if love.mouse.isDown(1) then
		local x, y = love.mouse.getX(), love.mouse.getY()
		for button_name, button in pairs (buttons) do
			if (x > button.x) and (x < (button.x + button.w)) and
			   (y > button.y) and (y < (button.y + button.h)) then
				button.clicked = true
				soundByte = love.audio.newSource(uiClick)
				soundByte:play()
				return button_name
			end
		end
	end
	return nil
end

button_draw = function (data)
	local x, y = data.x, data.y
	if data.clicked then 
		x=x+1
		y=y+1
		data.clicked = false
	end
	--love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle ('line', x, y, data.w, data.h)
	love.graphics.print(data.text, x+2, y)
end

function love.update()
	local pressed_button = pressed_button (buttons)
	if pressed_button and pressed_button == "exitSession" then
		exitSession()
	end
	if pressed_button and pressed_button == "showImage" then
		drawImage()
	end
	if pressed_button and pressed_button == "playVideo" then
		drawVideo()
	end
	if pressed_button and pressed_button == "playAudio" then
		playSFX()
	end
end

-- Draw Graphics --
function love.draw()
	love.graphics.setBackgroundColor(bgRed, bgGreen, bgBlue, bgAlpha)
	printStats()
	if imageDrawn then
		love.graphics.draw(imageData, imageDataposX, imageDataposY) -- Figure out how to scale the image!
	end
	if videoPlaying then
		love.graphics.draw(videoStream,0,200)
	end
	for button_name, button in pairs (buttons) do
		button_draw (button)
	end
end
