function love.load()
-- 2D Physics Simulator using LOVE2D, LUA and the Windfield library.

-- made by Antonio Brych ("@joaodapizzaria") {100% FREE OF COPYRIGHTS!}

  require "menu"
  require "userInput"
  require "PhysicalObjects"
  timer = 0
  
  -- importing the physics library and setting the screen size.
  love.window.setMode(1920,1080,{resizable=true})
  wf = require "libs/windfield"
  frictionVal = 0
  -- initializing a world, in which physical interations will hapen. 
  world = wf.newWorld(0,0)
  world:addCollisionClass('Solid')
  world:addCollisionClass('Ghost', {ignores = {'Solid'}})
  
  
  love.graphics.setColor(1,0,0,1)
  
  
  gameState = "menu"
  
 generateBoundries()
 setBoundriesProperties()
 
  generateTriangleOfVertices()
  setTriangleOfVerticesProperties()
  
  love.graphics.setColor(1,1,1,1)
  
 
  -- initializing flag variables
  startButtonPressed = false
  clickButtonPress = false
  -- initializing values from physical object
  yAxisGravityValue = 20
  particleSizeIncrement = 0
  -- initializing the images used in the simulator.
  cursorImg = love.mouse.newCursor("assets/images/cursor_img.png",0,0)
  addGravityImg = love.graphics.newImage("assets/images/addGravity.png")
  subtractGravityImg = love.graphics.newImage("assets/images/subtractGravity.png")
  font = love.graphics.newFont("assets/font/font.ttf")
  love.graphics.setFont(font)
  frictionVal = 0
  
  generateParticleSizeIconShowcase()
  
  setParticleSizeIconProperties()
  
  dispersionButton = "inactive"

  world:setQueryDebugDrawing(true) 


 rand = 0
   --love.graphics.setDefaultFilter("nearest","nearest")
  
end






function love.update(dt)
  if  gameState == "simulator1" then
  world:update(dt)
  timer = timer + dt

  -- if the mouse button is pressed, a cube will be generated and (if in reach of the button) gravity will be set.
  if clickButtonPress and timer >= 0.12 and gameState == "simulator1" then
     world:setGravity(0,yAxisGravityValue)
     
      
      particleSizeIcon:destroy()
      particleSizeIcon = world:newRectangleCollider(love.graphics.getWidth() - 130,love.graphics.getHeight() - 110,10 + particleSizeIncrement,10 + particleSizeIncrement)
      particleSizeIcon:setType("static")
      particleSizeIcon:setCollisionClass("Ghost")
    
    -- verifies that the mouse is distant from the buttons, to avoid cubes  spawning in the buttons BUG!
    if distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 238,love.graphics.getHeight() - 260) >= 90 and distanceBetweenFormula(love.mouse.getX(),        love.mouse.getY(),love.graphics.getWidth() - 230,love.graphics.getHeight() - 110) >= 30 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 310,love.graphics.getHeight() - 110) >= 30 then
      
      generateCubeObject()
      setCubeObjectProperties()
      
    end
      clickButtonPress = false
  end
  
  if dispersionButton == "active" then
      disperseCubeObject()
    end
  end
  dispersionButton = "inactive"
  exitMainMenu()
  changeBoundriesBasedOnPressNumberParity()
  end



 
 function love.draw()
   -- Rendering all the images, nothing too important here :)
  if  gameState == "simulator1" then
    world:draw()
    love.mouse.setCursor(cursorImg)
    love.graphics.draw(addGravityImg,love.graphics.getWidth() - 300,love.graphics.getHeight() - 300,nil,0.75,0.75)
    love.graphics.draw(subtractGravityImg,love.graphics.getWidth() - 220,love.graphics.getHeight() - 300,nil,0.75,0.75)
     renderUserInputArea() 
    love.graphics.draw(addGravityImg,love.graphics.getWidth() - 300,love.graphics.getHeight() - 450,nil,0.75,0.75)
    love.graphics.draw(subtractGravityImg,love.graphics.getWidth() - 220,love.graphics.getHeight() - 450,nil,0.75,0.75)
    love.graphics.setColor(1,0,0,1)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(addGravityImg,love.graphics.getWidth() - 300,love.graphics.getHeight() - 150,nil,0.75,0.75)
    love.graphics.draw(subtractGravityImg,love.graphics.getWidth() - 220,love.graphics.getHeight() - 150,nil,0.75,0.75)
    love.graphics.print(particleSizeIncrement,300,200)
    love.graphics.print("Particle Size: ",love.graphics.getWidth() - 290,love.graphics.getHeight() - 170,nil,1.65,1.65)
    love.graphics.print("Gravity: " ..   yAxisGravityValue,love.graphics.getWidth() - 290,love.graphics.getHeight() - 320,nil,1.65,1.65)
    love.graphics.print("Friction: " ..   frictionVal,love.graphics.getWidth() - 290,love.graphics.getHeight() - 480,nil,1.65,1.65)
    love.graphics.print(distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 300,140) ,love.graphics.getWidth() - love.graphics.getWidth() + 30,       love.graphics.getHeight() -love.graphics.getHeight() + 48)
    love.graphics.setColor(0.2,0.5,1,0.5)
    
    
    
    
    if rand % 2 == 0 then
      love.graphics.rectangle("fill",0, love.graphics.getHeight() - 30 , love.graphics.getWidth(), 30)

    else
      love.graphics.rectangle("fill",0, love.graphics.getHeight() - 30 , love.graphics.getWidth()/1.86, 30)
    end
    
    if ceilingButtonNumberOfPresses % 2 == 0 then
      love.graphics.rectangle("fill",0,love.graphics.getHeight() - (love.graphics.getHeight() ),love.graphics.getWidth(),30)
    end
    
    if leftWallButtonNumberOfPresses % 2 == 0 then
      love.graphics.rectangle("fill",0,0,30,love.graphics.getHeight())
    end
    
    if rightWallButtonNumberOfPresses % 2 == 0 then
       love.graphics.rectangle("fill",love.graphics.getWidth() - 30,0,30,love.graphics.getHeight())--rightWall
    end
    
    --love.graphics.rectangle("fill",0,love.graphics.getHeight() - (love.graphics.getHeight() ),love.graphics.getWidth(),30)--ceiling

    love.graphics.setColor(1,1,1,1)
    love.graphics.setColor(1,0,0,1)
    love.graphics.rectangle("line",love.graphics.getWidth() - 300,60,120,120)
    love.graphics.setColor(1,1,1,1)
    else if gameState == "menu" then
      renderMainMenu()
    end
    
  end

end







function love.mousepressed(x,y,b,istouch,presses)
    if b == 1 then
      clickButtonPress = true
    end
    --addGravity conditional
    if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 310,love.graphics.getHeight() - 260) <= 30 and yAxisGravityValue < 2000 then
      yAxisGravityValue = yAxisGravityValue + 50--SUCESS!! It was really painfull to implement that (the button)!!
      buttonSound:play()
    end
    --remove gravity conditional
    if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 238,love.graphics.getHeight() - 260) <= 30 and yAxisGravityValue > -2000 then
      yAxisGravityValue = yAxisGravityValue - 50
      buttonSound:play()
    end
    -- add size to the icon
    if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 310,love.graphics.getHeight() - 110) <= 30 and yAxisGravityValue < 2000 then
      particleSizeIncrement = particleSizeIncrement + 10
      buttonSound:play()

    end
    -- remove size from the icon.
    if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 230,love.graphics.getHeight() - 110) <= 30 and yAxisGravityValue > -2000 and particleSizeIncrement >= 10 then
    particleSizeIncrement = particleSizeIncrement - 10
    buttonSound:play()
   end
   
   --add friction to the physical body "CUB
   if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth()-310,love.graphics.getHeight() - 410) <= 30 and frictionVal >= 0 then  
     frictionVal = frictionVal + 5
     buttonSound:play()
  end
  if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 230,love.graphics.getHeight() - 410) <= 30 and frictionVal >- 0 then
    frictionVal = frictionVal - 5
    buttonSound:play()
  end

  if b == 1 and distanceBetweenFormula(love.mouse.getX(),love.mouse.getY(),love.graphics.getWidth() - 280,125) <= 80 then
    buttonSound:play()
  end
  
    if b == 3 then
    dispersionButton = "active"
      buttonSound:play()
    end

end





