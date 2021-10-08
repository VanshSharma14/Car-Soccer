TitleScreenState = Class{__includes = BaseState}

rotation = true

function TitleScreenState:init()
  self.redCar = RCar()
  self.blueCar = BCar()
  self.goalr = GoalR()
  self.goalb = GoalB()
  self.ball = Ball()
  gamemode = '1player'
end

function TitleScreenState:update(dt)
  if love.keyboard.isDown('return') and gamemode == '2player' then
    gStateMachine:change('countdown')
  end

  if gamemode == '1player' and love.keyboard.wasPressed('down') then --decides the cycle between each gamemode selection
    gamemode = '2player'
  elseif gamemode == '2player' and love.keyboard.wasPressed('up') then
    gamemode = '1player'
  end
end



function TitleScreenState:render()
  self.redCar:render()
  self.blueCar:render()
  self.goalr:render()
  self.goalb:render()
  self.ball:render()
  --love.graphics.rotate(-1)
  love.graphics.setFont(titleStroke)
  love.graphics.setColor(0,0,0)
  love.graphics.printf('Car Soccer', 0, 120, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(titleFont)
  love.graphics.setColor(255,0,0)
  love.graphics.printf('Car Soccer', 0, 120, VIRTUAL_WIDTH, 'center')
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(testFont)
  love.graphics.printf("press 'enter' to start", 0, 200, VIRTUAL_WIDTH, 'center')

-- Highlights the currently selected gamemode yellow and changes states accordingly
  if gamemode == '1player' then
    love.graphics.setColor(247, 255, 0)
    love.graphics.printf('Single Player', 0, 400, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255,255,255)
    love.graphics.printf('Double Player', 0, 450, VIRTUAL_WIDTH, 'center')
  elseif gamemode == '2player' then
    love.graphics.setColor(255,255,255)
    love.graphics.printf('Single Player', 0, 400, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(247,255,0)
    love.graphics.printf('Double Player', 0, 450, VIRTUAL_WIDTH, 'center')
  end

  if love.keyboard.isDown('return') and gamemode == '1player' then
    love.graphics.setColor(0,0,0)
    love.graphics.printf('Error: Gamemode still under Construction', 0, VIRTUAL_HEIGHT - 100, VIRTUAL_WIDTH, 'center')
  end
end
