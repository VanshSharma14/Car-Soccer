PlayState = Class{__includes = BaseState}

wf = require 'stuff/windfield'
rotation = false


function PlayState:init()

  self.redCar = RCar()
  self.blueCar = BCar()
  self.ball = Ball()
  self.goalr = GoalR()
  self.goalb = GoalB()



  --initiates the world
  world = wf.newWorld(0, 0, true)
  world:setGravity(0, 1536)

  --creates collision classes
  world:addCollisionClass('solid')
  world:addCollisionClass('ball')
  world:addCollisionClass('car')
  world:addCollisionClass('base')

  --inititates the collider for ball
  ball = world:newRectangleCollider(self.ball.x, self.ball.y, self.ball.width, self.ball.height)
  ball:setCollisionClass('ball')
  ball:setRestitution(.6)

  --initiates red car
  redCar = world:newRectangleCollider(self.redCar.x, self.redCar.y, self.redCar.width, self.redCar.height)
  redCar:setCollisionClass('car')
  redCar:setRestitution(.1)


  -- Makes a collider for the barriers
  barrl = world:newLineCollider(0, 0, 0, VIRTUAL_HEIGHT)
  barrt = world:newLineCollider(0, 0, VIRTUAL_WIDTH, 0)
  barrr = world:newLineCollider(VIRTUAL_WIDTH, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
  barrb = world:newRectangleCollider(0, VIRTUAL_HEIGHT - 95, VIRTUAL_WIDTH, 95)

  barrl:setCollisionClass('solid')
  barrt:setCollisionClass('solid')
  barrr:setCollisionClass('solid')
  barrb:setCollisionClass('base')

  barrl:setType('static')
  barrt:setType('static')
  barrr:setType('static')
  barrb:setType('static')

end

function PlayState:update(dt)

  --ball updates
  world:update(dt)
  ball.x, ball.y = ball:getPosition()

  if love.keyboard.wasPressed('space') then
    ball:applyLinearImpulse(1000, -500)
  end


  --red car updates
  redCar.x, redCar.y = redCar:getPosition()

  if redCar:exit('ball') then
    ball:applyLinearImpulse(0, -200)
  end


  self.redCar:update(dt)
  self.blueCar:update(dt)
  self.ball:update(dt)
  self.goalr:update(dt)

  self.goalr:goalHit(self.ball)
  self.goalr:postHit(self.ball, dt)
  self.goalb:goalHit(self.ball)
  self.goalb:postHit(self.ball)

  --self.redCar:hitbox2(self.ball)
  --self.blueCar:hitbox2(self.ball)

  self.goalb:update()
end

function PlayState:render()

  world:draw()
  self.redCar:render()
  self.blueCar:render()
  self.ball:render()
  self.goalr:render()
  self.goalb:render()
end
