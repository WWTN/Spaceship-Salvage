 
 
 
 sti = require "sti" -- Simple Tiled Implementation, open-source interpreter and interface
 bump = require 'bump' -- bump.lua, open-source collision detection that STI has a module for


function love.load()
  
  background= love.graphics.newImage("sprites/bg1.jpg")
  
  widthX = love.graphics.getWidth()
  heightY = love.graphics.getHeight()
  
  backgroundQuad = love.graphics.newQuad(1,1,background:getWidth(),background:getHeight(),720/2,1280/2)
  
    
  
   startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
   scoreBtn = love.graphics.newImage("sprites/btngrphc2.jpg")
   
   scorePressed = false
   FAILMODE = love.graphics.newImage("sprites/bad.png")
   
   mouseLocations = {}
   mouseLocations.start = false
   mouseLocations.score = false
   
   
   
   
   isGameRunning = false -- swaps between game and menu. Crude but effective.
   
  changeCount = 0
    
    
      dude = love.graphics.newImage("sprites/dude.png")
      door = love.graphics.newImage("sprites/door.png")
     
   spawnpoint = {
     x = 100,
     y = 100 }
    
     
    mainchar = {
        sprite = dude,
        x      = spawnpoint.x,
        y      = spawnpoint.y,
        ox     = dude:getWidth() / 2,
        oy     = dude:getHeight() / 1.35
    }


        -- 96 pixels per second
      speed = 96

        isGrounded = false
        verticalSpeed = 0
        
      world = bump.newWorld(72)
 
end

  
function love.update(dt)
 mouseposX, mouseposY  = love.mouse.getPosition()
 
 if isGameRunning == false then -- Ben- If I knew how, this would be calling a swap to another .lua file.
    menuUpdate()
    
  else
    gameUpdate(dt)
    
 end
 
 
 end
function love.draw()
  
  
  
    
    if isGameRunning == false then -- Ben- were I better at lua programming this would be swapping to another file.
    menu_screen()
    
  else
    game_screen()
   
 end
     if scorePressed == true then
    love.graphics.draw(FAILMODE, 300, 300)
    end
  end
 
 
 function game_screen()
    map:draw() 
    
    love.graphics.draw(dude, mainchar.x, mainchar.y)
    love.graphics.draw(door, 550, 480)
    


 end
 
 
 

  function menu_screen()
    love.graphics.draw(background, backgroundQuad, 0, 0)
    love.graphics.draw(startBtn, 200, 300)
    
    love.graphics.draw(scoreBtn, 200, 500)
    
  end
  
 
 
 function love.mousepressed()
    
      if (mouseLocations.start == true) then -- previously was all written in this one if, updated since then

        isGameRunning = true
        gameLoad()
        mouseLocations.start = false
      
    end
    
    
    if (mouseLocations.score == true) and (scorePressed == false) then
        scorePressed = true
      
      
    else if 
      (mouseLocations.score == true) 
      and (scorePressed == true) then
        
        scorePressed = false
        end
      end
    
  end
  
  function mouseOverCheck()
   if (isGameRunning == false) then
   
    
      if (love.mouse.getX() >200) -- Possibly the single crudest chunk of code I've ever written, but _fuck_ lua.
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
        mouseLocations.score = false -- makes both false in one else so as not to need to repeat even _more_ code
         mouseLocations.start = false
        end
    
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

function gameLoad()
   
  map = sti("maps/testMap1.lua", {"bump"}, 0, 0)
    
  
--map:bump_init(map, world)
   
  
    
    
      dude = love.graphics.newImage("sprites/dude.png")
     landHere = {}
   
   
  
  world:add(mainchar, mainchar.x,mainchar.y, mainchar.ox, mainchar.oy)
  
  world:add(landHere, 0, 200, 400, 20)
  end

function menuUpdate()
  mouseOverCheck()
 updateButtonGraphics()
  
end

function gameUpdate(dt)
   map:update(dt)
   
  
   
   if isGrounded == false then
     mainchar.y = mainchar.y + verticalSpeed
     verticalSpeed = verticalSpeed + 0.1
     end
   
    if (love.keyboard.isDown("w") or love.keyboard.isDown("up")) and (verticalSpeed > -3) then
           verticalSpeed  = verticalSpeed - 1
        end
        
        -- Move player left
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            mainchar.x = mainchar.x - speed * dt
        end

        -- Move player right
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            mainchar.x = mainchar.x + speed * dt
        end
        
        if (love.keyboard.isDown("o")) and (changeCount == 0)
        
        then
          
        mainchar.x = spawnpoint.x
        mainchar.y = spawnpoint.y
        verticalSpeed = 0
       map = sti("maps/testMap2.lua", {"bump"}, 0, 0)
        changeCount = 1;
      end
      
      if  (mainchar.y> 1000) then
      
      isGameRunning = false
      sti:flush()
      
    end
    
    local hitTest = CheckCollision(mainchar.x, mainchar.y, mainchar.ox, mainchar.oy, 550, 480, door:getWidth(), door:getHeight())
    
    
  if (hitTest) then
     mainchar.x = spawnpoint.x
        mainchar.y = spawnpoint.y
        verticalSpeed = 0
       map = sti("maps/testMap2.lua", {"bump"}, 0, 0)
     end
     
  
  
end
      
      

  
  function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and       
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
