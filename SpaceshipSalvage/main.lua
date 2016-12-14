 sti = require "sti" -- Simple Tiled Implementation, open-source interpreter and interface
 bump = require 'bump' -- bump.lua, open-source collision detection that STI has a module for


function love.load()
  
  background= love.graphics.newImage("sprites/bg1.jpg")
  
  widthX = love.graphics.getWidth()
  heightY = love.graphics.getHeight()
  
  backgroundQuad = love.graphics.newQuad(1,1,widthX,heightY,720/2,1280/2)
  
    
  
   startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
   scoreBtn = love.graphics.newImage("sprites/btngrphc2.jpg")
   
   mouseLocations = {}
   mouseLocations.start = false
   mouseLocations.score = false
   
   
   
   
   isGameRunning = false -- swaps between game and menu. Crude but effective.
   
  map = sti("maps/testMap1.lua", {"bump"}, 0, 0)
    
    layer = map:addCustomLayer("Sprites", 8)
   
  
      bump_init (map, world)
    
    
      dude = love.graphics.newImage("sprites/dude.png")
     
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
    
  end
 
 
 function game_screen()
    map:draw() 
    
    love.graphics.draw(dude, mainchar.x, mainchar.y)
    
    


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
      
      end
    
    
  end
  
  function mouseOverCheck()
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
   
  
   
  
    
    
      dude = love.graphics.newImage("sprites/dude.png")
     
   
     
    map:removeLayer("Spawn Point")-- yes I add a layer and remove it immediately but I can't work out why it breaks when I don't so whatever
  
  world:add(mainchar, mainchar.x,mainchar.y, mainchar.ox, mainchar.oy)
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
   
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
           mainchar.y = mainchar.y - speed * dt
        end
        
        -- Move player left
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            mainchar.x = mainchar.x - speed * dt
        end

        -- Move player right
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            mainchar.x = mainchar.x + speed * dt
        end
  end
