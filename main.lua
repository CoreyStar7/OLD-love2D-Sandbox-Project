-- [Settings] --

-- Background
bgColor = 0,0,0

-- Stats and Fonts
printStatistics = true
customFont = true
titleFontSize = 18
bodyFontSize = 15

-- Basic Settings
drawPhoto = false
drawVideo = false
playAudio = false

-- Load into Memory
function love.load()
	-- Requires
	--require("button")

	-- Global
	mediaAssetsPath = "mediaAssets"

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

function drawImage()
	if drawPhoto == true then
		love.graphics.draw(imageData, imageDataposX, imageDataposY)
	elseif drawImage == false then
		love.graphics.print("Image will not Draw.",0,110)
	end
end

function drawVideo()
	if drawVideo == true then
		love.graphics.draw(videoStream,0,100)
		videoStream:play()
	elseif drawVideo == false then
		love.graphics.print("Video will not Draw.",0,125)
	end
end

function playSFX()
	if playAudio == true then
		sfx = love.audio.newSource(soundData)
		sfx:play()
	elseif playSFX == false then
		love.graphics.print("Sound Effect will not Play.",0,140)
	end
end

-- Draw Graphics --
function love.draw()
	printStats()
	drawImage()
	drawVideo()
	playSFX()
	--os.exit() (Add a button that allows you to exit or something idk)
end
