GoalR = Class{}

GOAL_HEIGHT = 85


function GoalR:init()
  self.x = 39

  self.y = GROUND_HEIGHT - GOAL_HEIGHT

  goalRCounter = 0
  previousRGoalTouch = false

  self.width = 40
  self.height = GOAL_HEIGHT

  --post thickness = 20px

  RPostX = -4
  RPostY = self.y - 20
  RPost_HEIGHT = GOAL_HEIGHT + 22
  RPost_WIDTH = 92

  RPostBOX_HEIGHT = 20
  RPostBOX_WIDTH = 20
  RPostBOX_X = (RPostX + RPost_WIDTH) - RPostBOX_WIDTH
  RPostBOX_Y = RPostY

  self.postx = -4
  self.posty = self.y - 20
  self.postHeight = 20
  self.postWidth = self.x + self.width + 20
end

offset = 3

function GoalR:goalHit(ball)
  --Uses AABB collision to detect wether the ball is inside the goal or not
  if (self.x) + (self.width) >= ball.x and self.x <= ball.x + ball.width then
    if (self.y) + (self.height) >= ball.y and self.y <= ball.y + ball.height then
      love.graphics.setColor(0,255,0)
      --gStateMachine:change('score')
    end
  end
end

function GoalR:postHit(ball, dt)

  if (self.postx) + (self.postWidth) >= ball.x and self.postx <= ball.x + ball.width then
    if (self.posty) + (self.postHeight) >= ball.y and self.posty <= ball.y + ball.height then
      if ball.dx < 0 then
        ball.dx = ball.dx - 2 * dt
      elseif ball.dx > 0 then
        ball.dx = ball.dx + 2 * dt
      end
      ball.dy = -ball.dy
    end
  end
  --[[
  if (RPostX) + (RPost_WIDTH) >= ball.x and RPostX <= ball.x + ball.width then
    if (RPostY) + (RPost_HEIGHT) >= ball.y and RPostY <= ball.y + ball.height then
      if RPostX <= ball.x and (RPostX + RPost_WIDTH) >= ball.x and ball.y >= (RPostY + 4) then --top of the post
        ball.dy = -ball.dy
        if ball.dx < 0 then
          ball.dx = -ball.dx + 3
        else
          ball.dx = -ball.dx - 3
        end
      end
    end
  end
  --front of the post. I made a box that looks for the ball interjecting witht he front.
  if (RPostBOX_X) + (RPostBOX_WIDTH) >= ball.x and RPostBOX_X <= ball.x + ball.width then
    if (RPostBOX_Y) + (RPostBOX_HEIGHT) >= ball.y and RPostBOX_Y <= ball.y + ball.height then
      ball.dx = -ball.dx
      ball.x = RPostBOX_X + RPostBOX_WIDTH + 2
    end
  end
  ]]
end


function GoalR:update(dt)
end

function GoalR:render()
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', self.postx, self.posty, self.postWidth, self.postHeight)
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.printf('Goal R Counter: ' .. tostring(goalRCounter), 0, 50, VIRTUAL_WIDTH, 'center')
end
