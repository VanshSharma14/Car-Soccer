Ball = Class{}

GRAVITY = 10


function Ball:init()
  self.image = love.graphics.newImage('stuff/ball2.png')

  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT /2

  BallY = self.y
  BallX = self.x



  BallDx = self.dx
  BallDy = self.dy

  self.width = self.image:getWidth()
  self.height = self.image:getHeight()

  GROUND_BALL = GROUND_HEIGHT - self.height

  self.dx = 0
  self.dy = 0

  self.timer = 0

end

function Ball:update(dt)

  self.x = ball.x - (self.width/2)
  self.y = ball.y - (self.height/2)
  --[[
-- add's friction
  if self.y == GROUND_BALL then
    if self.dx > 7 * dt then
      self.dx = self.dx - 9 * dt
    elseif self.dx < -7 * dt then
      self.dx = self.dx + 9 * dt
    else
      self.dx = 0
    end
  else -- air resistance
    if self.dx > 1*dt then
      self.dx = self.dx - 2*dt
    elseif self.dx < -1*dt then
      self.dx = self.dx + 2 * dt
    else
      self.dx = 0
    end
  end

  self.y = self.y + self.dy * dt

  if self.y < GROUND_BALL then
    self.dy = self.dy + GRAVITY
  else
    self.dy = 0
    self.y = GROUND_BALL
  end


-- wall collision
  if (self.x + self.width) >= VIRTUAL_WIDTH then
    self.dx = -self.dx
    self.x = VIRTUAL_WIDTH - self.width - 1
  elseif self.x <= 0 then
    self.dx = -self.dx
    self.x = 1
  end

  if self.dy > 100000 * dt then
    self.dy = 100000 * dt
  elseif self.dy < -100000 * dt then
    self.dy = -100000 * dt
  end


  if self.y <= 0 then
    self.y = 1
    self.dy = -self.dy

  end

  if self.dx >= 1500 *dt then
    self.dx = 1500 * dt
  end
  self.x = self.x + self.dx
]]
end

function Ball:render()
  love.graphics.draw(self.image, self.x, self.y, 0, 1, 1)
  love.graphics.setFont(testFont)
  love.graphics.printf('ballDY: ' .. tostring(self.dy), 0, 100, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('ballDX: ' .. tostring(self.dx), 0, 75, VIRTUAL_WIDTH, 'center')
end
