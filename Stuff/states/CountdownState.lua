CountdownState = Class{__includes = BaseState}

function CountdownState:init()
  countdownFont = love.graphics.newFont('stuff/font.ttf', 100)
  love.graphics.setFont(countdownFont)
  self.countdown = 3
  self.timer = 0
end

function CountdownState:update(dt)

  if self.countdown == 3 then
    self.timer = self.timer + dt  --if countdown is at 3, changes it to 2 in .5 seconds. Continues for the rest of it.
    if self.timer > .5 then
      self.countdown = self.countdown - 1
      self.timer = 0
    end
  elseif self.countdown == 2 then
    self.timer = self.timer + dt
    if self.timer > .5 then
      self.countdown = self.countdown - 1
      self.timer = 0
    end
  elseif self.countdown == 1 then
    self.timer = self.timer + dt
    if self.timer > .5 then
      self.countdown = self.countdown - 1
      self.timer = 0
    end
  elseif self.countdown == 0 then
    self.timer = self.timer + dt
    if self.timer > .5 then
      self.timer = 0
      gStateMachine:change('play')
    end
  end
end

function CountdownState:render()
  love.graphics.printf(''.. tostring(self.countdown), 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center')
end
