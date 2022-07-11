BCar = Class{}

local count = 0

function BCar:init()
  self.image = love.graphics.newImage('stuff/blue_car3.png')

  self.width = self.image:getWidth() * .5
  self.height = self.image:getHeight() * .5

  groundHeight = VIRTUAL_HEIGHT - 37

  GROUND_BCAR = GROUND_HEIGHT - self.height

  self.x = VIRTUAL_WIDTH - 180
  self.y = GROUND_BCAR

  self.dx = 0
  self.dy = 0

  self.timer = 0

  MOVEMENT_SPEED = 250

  GRAVITY = 10
end
--[[
function BCar:hitbox(ball) --Car rectangulare hitbox (16x7)
  if (ball.y + ball.height + 1) <= self.x and ball.x >= self.x and ball.x  <= (self.x + 16) then --top of rectangle
    ball.dy = -ball.dy + 4 --
    ball.dx = 4
  end
  if (ball.x) <= (self.x + 16) and ball.y >= self.y and ball.y <= (self.y + 7) then --right side of the rectangle
    ball.dx = -ball.dx + 4
    ball.dy = 3
  end
  if (ball.y - 3) >= (self.y + 7) and ball.x >= self.x and ball.x <= (self.x + 16) then --bootom of the rectangle
    ball.dy = -ball.dy - 4
    ball.dx = 4
  end
  if (ball.x + ball.width + 1) >= self.y and (ball.x + ball.width + 1) <= (self.y + 2) and (ball.y + ball.height) >= self.y then
    ball.dx = -ball.dx - 4 -- left side of rectangle
  end
end
]]


function BCar:update(dt)
  self.x = blueCar.x - (self.width/2)
  self.y = blueCar.y - (self.height/2)

    --Car moves right if 'd' is pressed
    if love.keyboard.isDown('right') then
      --self.dx = MOVEMENT_SPEED * dt
      blueCar:applyLinearImpulse(100, 0)
    end
  
    --Car moves left if 'a' is pressed
    if love.keyboard.isDown('left') then
      --self.dx = -MOVEMENT_SPEED * dt
      blueCar:applyLinearImpulse(-100, 0)
    end
  
    --upwards jump + long press
    if love.keyboard.wasPressed('up') and count == 0 then
      count = 1
      blueCar:applyLinearImpulse(0, -3000)
      --self.dy = -300 * dt
    end
    if count == 1 then
      if blueCar.y >= GROUND_RCAR + 3 then
        count = 0
      end
      if love.keyboard.isDown('w') then
        --self.dy = -300 * dt
        blueCar:applyLinearImpulse(0, -150)
        self.timer = self.timer + dt
        if self.timer > .5 then
          count = 2
          self.timer = 0
        end
        --WORK ON THIS
      end
    end
    if blueCar.y >= GROUND_RCAR - 5 and count == 2 then
        count = 0
    end
  

end



function BCar:render()
  love.graphics.draw(self.image, self.x, self.y, 0, .5, .5)
end
