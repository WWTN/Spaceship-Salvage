local sti = require "sti"

function love.load()
  
  background= love.graphics.newImage("sprites/bg1.jpg")
  
  widthX = love.graphics.getWidth()
  heightY = love.graphics.getHeight()
  
  backgroundQuad = love.graphics.newQuad(1,1,widthX,heightY,720/2,1280/2)
  
      map = sti("maps/testMap1.lua")
  
   startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
   scoreBtn = love.graphics.newImage("sprites/btngrphc2.jpg")
   
   mouseLocations = {}
   mouseLocations.start = false
   mouseLocations.score = false
   
   
   isGameRunning = false
  --  buttons["quit"] = button:new(440, 380, 100, 30, love.event.quit, return self)
end

  
function love.update(dt)
 mouseposX, mouseposY  = love.mouse.getPosition()
 
 if isGameRunning == false then
    menuUpdate()
    
  else
    gameUpdate(dt)
    
 end
 
 
 end
function love.draw()
  
  
  
    
    if isGameRunning == false then
    menu_screen()
    
  else
    game_screen()
    
 end
    
  end
 
 
 function game_screen()
    map:draw()
 end
 
 
  function menu_screen()
    love.graphics.draw(background, backgroundQuad, 0, 0)
    love.graphics.draw(startBtn, 200, 300)
    
    love.graphics.draw(scoreBtn, 200, 500)
    
  end
  
 
 
 function love.mousepressed()
    
      if (mouseLocations.start == true) then

        isGameRunning = true
      
      end
    
    
  end
  
  function mouseOverCheck()
    if (love.mouse.getX() >200)
      and (love.mouse.getX() < 300) 
      and (love.mouse.getY() > 300) 
      and (love.mouse.getY() < 400)
      then
        mouseLocations.start = true
        
       
      
      
      else if 
      (love.mouse.getX() >200)
      and (love.mouse.getX() < 300) 
      and (love.mouse.getY() > 500) 
      and (love.mouse.getY() < 560)
      then
        mouseLocations.score = true
      else
        mouseLocations.score = false
         mouseLocations.start = false
        end
    
      
  end
    end
   function updateButtonGraphics()
      if (mouseLocations.start == true) then

        startBtn = love.graphics.newImage("sprites/btngrphcpshd1.jpg")
      else if (mouseLocations.score == true) then
         scoreBtn = love.graphics.newImage("sprites/btngrphcpshd2.jpg")
        
      else
      startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
       scoreBtn = love.graphics.newImage("sprites/btngrphc2.jpg")
      end
    
     end
end



function menuUpdate()
  mouseOverCheck()
 updateButtonGraphics()
  
end

function gameUpdate(dt)
   map:update(dt)
  
  end
