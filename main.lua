-----------------------------------------------------------------------------------------
--
-- main.lua
-- Description : Tapman
-- Author : Manaswi Mishra
-- Date : October 10th 2015
-----------------------------------------------------------------------------------------

local screenW, screenH = display.contentWidth, display.contentHeight


local widget = require( "widget" )

local timeBPM = 500   -- Time in Miliseconds corresponding to 120BPM 

local onceTap = false
local refBeatTime = 0
local firstBeat = false
local timeInstantTap = 0
local timeInstantPrevTap = 0

local scoreMean = 0
local scoreVar = 0
local scoreDiff = {} 
local counter = 1

local audioOptions =
{
    channel = 1,
    --loops = -1,
    --duration = 30000,
    --fadein = 5000,
    onComplete = callbackListener
}
local clicksound = audio.loadSound( "click.wav" ) --init the sound 
local beatsound = audio.loadSound( "beatShort.wav" ) --init the sound 

local background = display.newImage( "bground.png", display.contentCenterX, display.contentCenterY )

local function onTouch(event)
		if (event.phase== 'began') then

			-- Stores time instant of every single touch
			timeInstantTap = event.time

			scoreDiff[counter] = timeInstantTap - timeInstantPrevTap
			print (" diff " , scoreDiff[counter])
			counter = counter + 1

			--scoreMean = scoreMean + 
			timeInstantPrevTap = timeInstantTap

			background = display.newImage( "bground2.png", display.contentCenterX, display.contentCenterY )
			--print( "Touch event began on: " .. event.target.id )

			audio.play( beatsound , audioOptions)  --play the sound once complete
		    --audio.play( clicksound )

		    -- onceTap keeps a flag that equals true the first time user touches
		    onceTap = true

		elseif (event.phase == 'ended') then
			background = display.newImage( "bground.png", display.contentCenterX, display.contentCenterY )
			--print( "Touch event ended on: " .. event.target.id )
		end
return true
end

local function onShake(event)
		if (event.isShake) then
			audio.play( beatsound , audioOptions)  --play the sound if shake is detected
			onceTap = true
		end
return true
end

local function makeSound(event)

    if onceTap == true then
	audio.play( clicksound , audioOptions) 

		if firstBeat == false then

			refBeatTime = event.time 
			timeInstantPrevTap = refBeatTime

			print (refBeatTime)
			firstBeat = true
		end
    
    end

end


local function game()





end

background:addEventListener("touch", onTouch)
Runtime:addEventListener("accelerometer",onShake)

timer.performWithDelay( timeBPM, makeSound, 50 )








