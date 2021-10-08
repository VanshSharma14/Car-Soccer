push = require 'stuff/push'

Class = require 'stuff/class'

require 'stuff/StateMachine'

require 'stuff/states/BaseState'
require 'stuff/states/PlayState'
require 'stuff/states/TitleScreenState'
require 'stuff/states/CountdownState'
--require 'states/TitleScreenState'
require 'stuff/states/ScoreState'
require 'stuff/RCar'
require 'stuff/BCar'
require 'stuff/Ball'
require 'stuff/GoalR'
require 'stuff/GoalB'


WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

VIRTUAL_WIDTH = 1280            --512
VIRTUAL_HEIGHT = 720            --288

GROUND_HEIGHT = VIRTUAL_HEIGHT - 95

local background = love.graphics.newImage('stuff/background3.jpg')

function love.load()



  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())
  love.window.setTitle('2D Rocket League')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = true,
    resizable = true
  })

  gStateMachine = StateMachine {
      ['title'] = function() return TitleScreenState() end,
      ['countdown'] = function() return CountdownState() end,
      ['play'] = function() return PlayState() end,
      ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('play')

  love.keyboard.keysPressed = {}

  -- initialize mouse input table
  love.mouse.buttonsPressed = {}
end

testFont = love.graphics.newFont('stuff/collegeb.ttf', 28)
titleFont = love.graphics.newFont('stuff/titleFont.ttf', 56)
titleStroke = love.graphics.newFont('stuff/titleFont.ttf', 58)
love.graphics.setFont(testFont)


function love.resize(w, h)
    push:resize(w, h)
end

  function love.keypressed(key)
      -- add to our table of keys pressed this frame
      love.keyboard.keysPressed[key] = true

      if key == 'escape' then
          world:destroy()
          love.event.quit()
      end
  end

  --[[
      LÖVE2D callback fired each time a mouse button is pressed; gives us the
      X and Y of the mouse, as well as the button in question.
  ]]
  function love.mousepressed(x, y, button)
      love.mouse.buttonsPressed[button] = true
  end

  --[[
      Custom function to extend LÖVE's input handling; returns whether a given
      key was set to true in our input table this frame.
  ]]
  function love.keyboard.wasPressed(key)
      return love.keyboard.keysPressed[key]
  end

  --[[
      Equivalent to our keyboard function from before, but for the mouse buttons.
  ]]
  function love.mouse.wasPressed(button)
      return love.mouse.buttonsPressed[button]
  end


function love.update(dt)

  gStateMachine:update(dt)
  love.keyboard.keysPressed = {}
  love.mouse.buttonsPressed = {}
end

function love.draw()
push:start()
love.graphics.draw(background, 0, 0)
gStateMachine:render()
push:finish()
end
