function generateTriangleOfVertices()
  line = world:newLineCollider(200,200, 1030, 1030)
  line2 = world:newLineCollider(200,200,200,1030)
  joint = world:addJoint('RevoluteJoint', line, line2, 200, 200, true)--Joint that forms the slope for physical interactions
end

function setTriangleOfVerticesProperties()
  line:setType("static")
  line2:setType("static")
end

function generateBoundries()
  ground = world:newRectangleCollider(0, love.graphics.getHeight() - 30 , love.graphics.getWidth(), 30) 
  ceiling = world:newRectangleCollider(0,love.graphics.getHeight() - (love.graphics.getHeight() ),love.graphics.getWidth(),30)
  leftWall = world:newRectangleCollider(0,0,30,love.graphics.getHeight())
  rightWall = world:newRectangleCollider(love.graphics.getWidth() - 30,0,30,love.graphics.getHeight())
end

function setBoundriesProperties()
  ground:setType("static")
  ceiling:setType("static")
  leftWall:setType("static")
  rightWall:setType("static")
end

function generateParticleSizeIconShowcase()
  particleSizeIcon = world:newRectangleCollider(love.graphics.getWidth() - 100,love.graphics.getHeight() - 110,10,10)
end

function setParticleSizeIconProperties()
  particleSizeIcon:setType("static")
  particleSizeIcon:setCollisionClass("Ghost")
end

function generateCubeObject()
  cube = world:newRectangleCollider(love.mouse.getX() + 40,love.mouse.getY(),10 + particleSizeIncrement,10 + particleSizeIncrement)
end

function setCubeObjectProperties()
  cube:setCollisionClass("Solid")
  cube:setFriction(frictionVal)
end

function distanceBetweenFormula(x1,y1,x2,y2)
  -- distance between two points in the cartesian coordinate system. 
  return math.sqrt((x1-x2)^2 + (y1 - y2)^2)
end
  
function disperseCubeObject()
  if dispersionButton == "active" then
    local colliders = world:queryCircleArea(love.mouse.getX() + 40, love.mouse.getY() + 40, 100)
      for _, collider in ipairs(colliders) do
        if love.mouse.getX() < (love.graphics.getWidth() / 2) then
          collider:applyLinearImpulse(800,-400)
        else if love.mouse.getX() >= (love.graphics.getWidth() / 2) then 
          collider:applyLinearImpulse(-800,-400)
        end
      end
    end
  end
end
 
 