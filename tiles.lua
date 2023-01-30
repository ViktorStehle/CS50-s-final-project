Tiles = Entity:extend()

function Tiles:new(x, y)
    Tiles.super.new(self, x, y, "start-assets/stonetile.png")
    self.strength = 100
    self.tempStrength = self.strength
    -- walls are not falling so we make them unmovable
    self.weight = 0
end

function Tiles:draw()
    love.graphics.draw(self.image, self.x, self.y, 0, 0.25, 0.25)
end