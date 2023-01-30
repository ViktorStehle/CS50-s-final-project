Portal = Entity:extend()

function Portal:new(x, y)
    Portal.super.new(self, x, y, "start-assets/gate.png")
    self.weight = 0
end

function Portal:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.175, 0.175)
end