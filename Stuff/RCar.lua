RCar = Class{}

local count = 0
local count2 = 0
local isPressedOnce = false

function RCar:init()
  self.image = love.graphics.newImage('stuff/red_car3.png')

  self.width = self.image:getWidth() * .5
  self.height = self.image:getHeight() * .5


  self.x = 120
  self.y = GROUND_HEIGHT - self.height - 100

  GROUND_RCAR = GROUND_HEIGHT - self.height

  self.dx = 0
  self.dy = 0

  self.timer = 0
  self.timer2 = 0

  MOVEMENT_SPEED = 10

  GRAVITY = 10
end
--[[
function RCar:hitbox2(ball) -- Hitbox of the Car
  carmidx = self.x + (self.width/2)
  ballmidx = ball.x + (ball.width/2)

  if(self.x) + (self.width) >= ball.x and self.x <= ball.x + ball.width then
    if (self.y) + (self.height) >= ball.y and self.y <= ball.y + ball.height then
      if (ball.x + ball.width) <= carmidx then
        ball.dx = -ball.dx - 1 --If ball hits back of car
        ball.dy = ball.dy - 300
      elseif (ball.y + ball.height) <= self.y and ballmidx <= carmidx then --Checks where on top of the car the ball is colliding
        if self.y < GROUND_RCAR and ball.y < GROUND_BALL then
          ball.y = self.y - ball.height -- if it's going up, then ball stays on top of car
          ball.dx = 0
        elseif ball.dy > 0 then
          ball.dy = -ball.dy  --Checks if ball is falling down
          if ball.dx > 0 then
            ball.dx = -ball.dx - 3
          else -- check's for wether it's behind or in front of the car (on top)
            ball.dx = -ball.dx + 3
          end
        end

      elseif ball.x >= carmidx then
        ball.dx = -ball.dx + 3 --front hit
        ball.dy = ball.dy - 300
      end

      --[[
      ball.dx = -ball.dx + 5
      ball.dy = ball.dy - 300

    end
  end
end
]]


function RCar:update(dt)

  self.x = redCar.x - (self.width/2)
  self.y = redCar.y - (self.height/2)

  --Car moves right if 'd' is pressed
  if love.keyboard.isDown('d') then
    --self.dx = MOVEMENT_SPEED * dt
    redCar:applyLinearImpulse(100, 0)
  end

  --Car moves left if 'a' is pressed
  if love.keyboard.isDown('a') then
    --self.dx = -MOVEMENT_SPEED * dt
    redCar:applyLinearImpulse(-100, 0)
  end

  --upwards jump + long press
  if love.keyboard.wasPressed('w') and count == 0 then
    count = 1
    redCar:applyLinearImpulse(0, -3000)
    --self.dy = -300 * dt
  end
  if count == 1 then
    if redCar.y >= GROUND_RCAR + 3 then
      count = 0
    end
    if love.keyboard.isDown('w') then
      --self.dy = -300 * dt
      redCar:applyLinearImpulse(0, -150)
      self.timer = self.timer + dt
      if self.timer > .5 then
        count = 2
        self.timer = 0
      end
      --WORK ON THIS
    end
  end
  if redCar.y >= GROUND_RCAR - 5 and count == 2 then
      count = 0
  end


  --[[
  if self.y < GROUND_RCAR then
    self.dy = self.dy + (GRAVITY * dt)
  else
    self.dy = 0
  end
--[[
-- Implements dashing towards the right (NEEDS FIX)
  if isPressedOnce == false then
    if love.keyboard.wasPressed('d') then
      isPressedOnce = true
      self.timer2 = self.timer2 + dt
    end
  elseif isPressedOnce == true then
    if love.keyboard.isDown('d') then
      if self.timer2 <= 0.3 then
        self.dx = MOVEMENT_SPEED * 5
      else
        isPressedOnce = false
        self.timer2= 0
      end
    end
  end
ADD COMMENT HERE
  DeltaTime = dt

  --downslam
  if self.y < GROUND_RCAR and love.keyboard.wasPressed('s') then
    self.dy = 1000 * dt
  end

  if love.keyboard.isDown('d') then
    self.dx = MOVEMENT_SPEED
    self.x = self.x + (self.dx * dt)
  end

  if love.keyboard.isDown('a') then
    self.dx = -MOVEMENT_SPEED
    self.x = self.x + (self.dx * dt)
  end


  if love.keyboard.wasPressed('w') and count == 0 then
    count = 1

    self.dy = -300 * dt
  end

  if count == 1 then
    if love.keyboard.isDown('w') then
      self.dy = -300 * dt
      self.timer = self.timer + dt
      if self.timer > .5 then
        count = 2
        self.timer = 0
      end
    end
  end

  if self.y >= GROUND_RCAR then
    self.y = GROUND_RCAR
    count = 0
  end

]]
  -- self.y = self.y + self.dy * dt
end




function RCar:render()
  -- love.graphics.printf(tostring(DeltaTime), 0, 500, VIRTUAL_WIDTH, 'center')
  love.graphics.draw(self.image, self.x, self.y, 0, .5, .5)
  love.graphics.printf('stay = ' .. tostring(entered), 0, 550, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('stay = ' .. tostring(count), 0, 500, VIRTUAL_WIDTH, 'center')
end
