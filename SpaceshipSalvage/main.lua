function love.load()
  
  background= love.graphics.newImage("sprites/bg1.jpg")
  backgroundQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  
   startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
   scoreBtn = love.graphics.newImage("sprites/btngrphc2.jpg")
end

  
 


function love.draw()
  love.graphics.draw(background, backgroundQuad, 0, 0)
    game_screen()
  end
  
  function game_screen()
    
    love.graphics.draw(startBtn, 200, 300)
    
    love.graphics.draw(scoreBtn, 200, 500)
    
  end
  
  function love.mousepressed()
      if (love.mouse.getX >200) and (love.mouse.getX < 300) and (love.mouse.getY > 300) and (love.mouse.getY < 400)
      then
        
      
      end
    
    
    end