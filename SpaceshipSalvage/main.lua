local sti = require "sti" -- Simple Tiled Implementation, open-source interpreter and interface

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
    
    love.graphics.draw(dude, 100, 100)
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
    map = sti("maps/testMap1.lua")
    
    layer = map:addCustomLayer("Sprites", 8)
   
   local mainchar
    for k, object in pairs(map.objects) do
        if object.name == "Player" then
            mainchar = object
            break
        end
    end
    
      dude = love.graphics.newImage("sprites/dude.png")
     
     
    layer.mainchar = {
        sprite = dude,
        x      = mainchar.x,
        y      = mainchar.y,
        ox     = dude:getWidth() / 2,
        oy     = dude:getHeight() / 1.35
    }

layer.update = function(self, dt)
        -- 96 pixels per second
        local speed = 96

        -- Move player up
        if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
            self.mainchar.y = self.mainchar.y - speed * dt
        end

        -- Move player down
        if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
            self.player.y = self.mainchar.y + speed * dt
        end

        -- Move player left
        if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            self.mainchar.x = self.mainchar.x - speed * dt
        end

        -- Move player right
        if love.mainchar.isDown("d") or love.keyboard.isDown("right") then
            self.mainchar.x = self.mainchar.x + speed * dt
        end
    end


    -- Draw player
    layer.draw = function(self)
        love.graphics.draw(
            self.mainchar.sprite,
            math.floor(self.mainchar.x),
            math.floor(self.mainchar.y),
            0,
            1,
            1,
            self.mainchar.ox,
            self.mainchar.oy
        )

        -- Temporarily draw a point at our location so we know
        -- that our sprite is offset properly
        love.graphics.setPointSize(5)
        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
    end

    -- Remove unneeded object layer
    map:removeLayer("Spawn Point")
  
  
  end

function menuUpdate()
  mouseOverCheck()
 updateButtonGraphics()
  
end

function gameUpdate(dt)
   map:update(dt)
   
  end
