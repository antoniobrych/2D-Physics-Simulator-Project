simulatorLogo = love.graphics.newImage("assets/images/logo.png")

buttonSound = love.audio.newSource("assets/soundFX/buttonSound.wav","static")

function renderMainMenu()
  love.graphics.draw(simulatorLogo,(love.graphics.getWidth()/2.99),(love.graphics.getHeight()/3.5),nil,1.75,1.75)
  love.graphics.print("Click anywhere to start!",love.graphics.getWidth()/2.55,love.graphics.getHeight()/1.3,nil,2.6,2.6)
end

function exitMainMenu()
  if love.mouse.isDown(1) and gameState == "menu" then
    gameState = "simulator1"
    buttonSound:play()
  end
end