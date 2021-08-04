triangleButton = love.graphics.newImage("assets/images/triangle.png")

unspawnCeiling,unspwanLeftWall,unspawnGround,unspawnRightWall = false

leftWallButtonNumberOfPresses = 0

rightWallButtonNumberOfPresses = 0
 
ceilingButtonNumberOfPresses = 0

rand = 0



 
function renderUserInputArea() 
  love.graphics.print("Simulation Area: ",love.graphics.getWidth() - 200, love.graphics.getHeight() - love.graphics.getHeight() + 40)
  love.graphics.draw(triangleButton,love.graphics.getWidth() - 300,60,nil,0.25,0.25)
end
    
function changeBoundriesBasedOnPressNumberParity()
    if rand %2 == 0 then
    ground:destroy()
    ground = world:newRectangleCollider(0, love.graphics.getHeight() - 30 , love.graphics.getWidth(), 30)
  else
    
    
    ground:destroy()
    ground = world:newRectangleCollider(0, love.graphics.getHeight() - 30 , love.graphics.getWidth()/1.86, 30) 
    ground:setType("static")
    ground:setCollisionClass("Solid")
    
    
    
    
  
  end

  if ceilingButtonNumberOfPresses %2 == 0 then
    ceiling:destroy()
    ceiling = world:newRectangleCollider(0,love.graphics.getHeight() - (love.graphics.getHeight() ),love.graphics.getWidth(),30)
    ceiling:setType("static")
    ceiling:setCollisionClass("Solid")
  else
    ceiling:destroy()
    ceiling = world:newRectangleCollider(love.graphics.getWidth() + 1000, love.graphics.getHeight() + 1000 , love.graphics.getWidth(), 30) 
  end
  
  if rightWallButtonNumberOfPresses % 2 == 0 then
    rightWall:destroy()
    rightWall = world:newRectangleCollider(love.graphics.getWidth() - 30,0,30,love.graphics.getHeight())
    rightWall:setType("static")
    rightWall:setCollisionClass("Solid")
  else
    rightWall:destroy()
    rightWall = world:newRectangleCollider(love.graphics.getWidth() + 1000,love.graphics.getHeight() + 1000,30,love.graphics.getHeight())
  end
  
  if leftWallButtonNumberOfPresses % 2 == 0 then
    leftWall:destroy()
    leftWall = world:newRectangleCollider(0,0,30,love.graphics.getHeight())
    leftWall:setType("static")
    leftWall:setCollisionClass("Solid")
  else
    leftWall:destroy()
    leftWall = world:newRectangleCollider(love.graphics.getWidth() + 800,0,30,love.graphics.getHeight())
  end
end
  
  
  


function love.keypressed(key)
  if key == "w" then
    ceilingButtonNumberOfPresses = ceilingButtonNumberOfPresses + 1
  end
  if key == "d" then
    rightWallButtonNumberOfPresses = rightWallButtonNumberOfPresses + 1
  end
  if key == "s" then
    rand = rand + 1
  end 
  if key == "a" then
    leftWallButtonNumberOfPresses = leftWallButtonNumberOfPresses + 1 
  end
end



