platform = {}

function love.load
  	platform.width = love.graphics.getWidth()    -- Temporary
	platform.height = love.graphics.getHeight()  -- Temporary
  
  platform.x = 0                               -- Draws at edge; temporary until dynamic location is written
	platform.y = platform.height / 2             -- Draws exactly halfway up window; temp until dynamic
end

function love.update(dt)
 
end

function love.draw()
	love.graphics.setColor(255, 255, 255)        -- This sets the platform color to white. (The parameters are in RGB Color format).
 
        -- The platform will now be drawn as a white rectangle while taking in the variables we declared above.
	love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height)
end