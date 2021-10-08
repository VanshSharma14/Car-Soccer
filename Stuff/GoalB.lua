GoalB = Class{}



function GoalB:init()

  self.width = 40
  self.height = GOAL_HEIGHT

  self.x = VIRTUAL_WIDTH - self.width - 37  --37 is the offset required for the goal hitbox to be inside the goal
  self.y = GROUND_HEIGHT - GOAL_HEIGHT

  goalBCounter = 0
  previousGoalBTouch = false

   POSTX = VIRTUAL_WIDTH + 4
   POSTY = self.y - 20
   POST_HEIGHT = GOAL_HEIGHT + 22
   POST_WIDTH = 92

   POSTBOX_HEIGHT = 20
   POSTBOX_WIDTH = 20
   POSTBOX_X = (POSTX + POSTBOX_WIDTH)
   POSTBOX_Y = POSTY


end

offset = 3
function GoalB:goalHit(ball)

  --Uses AABB collision to detect wether the ball is inside the goal or not
  if (self.x) + (self.width) >= ball.x and self.x <= ball.x + ball.width then
    if (self.y) + (self.height) >= ball.y and self.y <= ball.y + ball.height then
      love.graphics.setColor(0,255,0)
    end
  end
end

function GoalB:postHit(ball)
  if (POSTX) + (POST_WIDTH) >= ball.x and POSTX <= ball.x + ball.width then
    if (POSTY) + (POST_HEIGHT) >= ball.y and POSTY <= ball.y + ball.height then
      if POSTX <= ball.x and (POSTX + POST_WIDTH) >= ball.x and ball.y >= (POSTY + 4) then --top of the post
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
  if (POSTBOX_X) + (POSTBOX_WIDTH) >= ball.x and POSTBOX_X <= ball.x + ball.width then
    if (POSTBOX_Y) + (POSTBOX_HEIGHT) >= ball.y and POSTBOX_Y <= ball.y + ball.height then
      ball.dx = -ball.dx
      ball.x = POSTBOX_X + POSTBOX_WIDTH + 2
    end
  end
end


function GoalB:update(dt)
end

function GoalB:render()
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - POST_WIDTH, self.y - 20, POST_WIDTH, POST_HEIGHT)
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
  love.graphics.printf('Goal B Counter: ' .. tostring(goalBCounter), 0, 25, VIRTUAL_WIDTH, 'center')
end
