function love.load()
    Object = require "classic"
    require "game"
    require "entity"
    require "tiles"
    require "character"
    require "box"
    require "cloud"
    require "enemy"
    require "portal"
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.keypressed(key)
    if key == "up" then
        character:jump()
    end
    if key == "r" then
        love.load()
    end
    if key == "escape" then
        love.event.quit()
    end
end