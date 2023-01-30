Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
    self.width = 25
    self.height = 25
    -- Save the previos position of a Wall / Box etc
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y
    -- add a strength property to move a box around
    self.strength = 0
    self.tempStrength = 0
    --add properties for the gravity
    self.gravity = 0
    self.weight = 200
end

function Entity:update(dt)
    -- Storing the current position
    self.last.x = self.x
    self.last.y = self.y
    self.tempStrength = self.strength
    --Increase of gravity according to our weight
    self.gravity = self.gravity + self.weight * dt

    --Increase the y-Position according to our gravity
    self.y = self.y + self.gravity * dt
end

function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.25, 0.25)
end

function Entity:checkCollision(e)
    -- e will be the other entity with which we check if there is collision.
    return self.x + self.width > e.x
    and self.x < e.x + e.width
    and self.y + self.height > e.y
    and self.y < e.y + e.height
end

function Entity:resolveCollision(e)
    -- Compare the strength
    if self.tempStrength > e.tempStrength then
        return e:resolveCollision(self)
    end
    -- with this we check from which side we are colliding with the box and we allign our character with the box
    if self:checkCollision(e) then
        self.tempStrength = e.tempStrength
        if self:wasVerticallyAligned(e) then
            if self.x + self.width/2 < e.x + e.width/2 then
                local a = self:checkResolve(e, "right")
                local b = e:checkResolve(self, "left")
                if a and b then
                    self:collide(e, "right")
                end
            else 
                local a = self:checkResolve(e, "left")
                local b = e:checkResolve(self, "right")
                if a and b then
                    self:collide(e, "left")
                end
            end
        elseif self:wasHorizontallyAligned(e) then
            if self.y + self.height/2 < e.y + e.height/2 then
                local a =  self:checkResolve(e, "bottom")
                local b = e:checkResolve(self, "top")
                if a and b then
                    self:collide(e, "bottom")
                end
            else
                local a = self:checkResolve(e, "top")
                local b = e:checkResolve(self, "bottom")
                if a and b then
                    self:collide(e, "top")
                end
            end
        end
        return true
    end
    return false
end

function Entity:wasVerticallyAligned(e)
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end

function Entity:collide(e, direction)
    if direction == "right" then
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
    elseif direction == "left" then
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
    elseif direction == "bottom" then
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
        self.gravity = 0
    elseif direction == "top" then
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
    end
end 

function Entity:checkResolve(e, direction)
    return true
end