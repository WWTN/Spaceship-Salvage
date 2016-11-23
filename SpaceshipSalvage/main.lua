function love.load()
  
  background= love.graphics.newImage("sprites/bg1.jpg")
  backgroundQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  
   startBtn = love.graphics.newImage("sprites/btngrphc1.jpg")
end

  
 


function love.draw()
  love.graphics.draw(background, backgroundQuad, 0, 0)
    game_screen()
  end
  
  function game_screen()
    
    love.graphics.draw(startBtn, 100, 100)
    
    
    end