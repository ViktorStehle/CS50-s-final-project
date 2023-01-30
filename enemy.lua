Enemy = Entity:extend()

function Enemy:new(x, y)
    Enemy.super.new(self, x, y, "start-assets/enemy.png")
    self.speed = 75
end

function Enemy:update(dt)
    Enemy.super.update(self, dt)
    self.x = self.x + self.speed * dt
end

function Enemy:checkResolve(e, direction)
    if e:is(Tiles) then
        if direction == "left"  then
            self.speed = self.speed * (-1)
            return true
        elseif direction == "right" then
            self.speed = self.speed * (-1)
            return true
        elseif direction == "bottom" then
            return true
        else
            return false
        end
    end
    if e:is(Cloud) then
        if direction == "bottom" then
            return true
        else
            return false
        end
    end
end