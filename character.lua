Character = Entity:extend()

function Character:new(x, y)
    Character.super.new(self, x, y, "start-assets/character.png")
    self.strength = 10
    -- give the player not the chance to jump multiple times
    self.canJump = false
    self.speed = 100
    liveCount = 3
end

function Character:update(dt)
    Character.super.update(self, dt)
    -- Uses Arrowkeys as input to move
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end
    if self.last.y ~= self.y then
        self.canJump = false
    end
end

function Character:jump()
    if self.canJump then
        self.gravity = -150
        self.canJump = false
    end
end
-- check collision for jump 
function Character:collide(e, direction)
    Character.super.collide(self, e, direction)
    if direction == "bottom" then
        self.canJump = true
    end
end

--resolve collision to stand on top of but be transparent from sides and bottom
function Character:checkResolve(e, direction)
    if e:is(Cloud) then
        if direction == "bottom" then
            return true
        else
            return false
        end
    end
    if e:is(Enemy) then
        liveCount = liveCount - 1
        if liveCount == 0 then
            love.event.quit( "restart" )
        end
        self.x = 50
        self.y = 400
    end
    if e:is(Portal) then
        self.x = 50
        self.y = 400
    end
    return true
end