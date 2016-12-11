local sti = require "sti" -- Simple Tiled Implementation, open-source interpreter and interface

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
   
   
   local layer = map:addCustomLayer("Sprites", 8)
   
   local mainchar
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            mainchar = object
            break
        end
    end
    
     local dude = love.graphics.newImage("sprites/dude.png")
     
     
    layer.mainchar = {
        sprite = dude,
        x      = mainchar.x,
        y      = mainchar.y,
        ox     = dude:getWidth() / 2,
        oy     = dude:getHeight() / 1.35
    }


    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
            self.player.sprite,
            math.floor(self.player.x),
            math.floor(self.player.y),
            0,
            1,
            1,
            self.player.ox,
            self.player.oy
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn Point")
   
   isGameRunning = false -- swaps between game and menu. Crude but effective.
 
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
 end
 
 
  function menu_screen()
    love.graphics.draw(background, backgroundQuad, 0, 0)
    love.graphics.draw(startBtn, 200, 300)
    
    love.graphics.draw(scoreBtn, 200, 500)
    
  end
  
 
 
 function love.mousepressed()
    
      if (mouseLocations.start == true) then -- previously was all written in this one if, updated since then

        isGameRunning = true
      
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



function menuUpdate()
  mouseOverCheck()
 updateButtonGraphics()
  
end

function gameUpdate(dt)
   map:update(dt)
  
  end
