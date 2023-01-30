Cloud = Entity:extend()

function Cloud:new(x, y)
    Cloud.super.new(self, x, y, "start-assets/cloud.png")
    self.weight = 0
    self.strength = 100
end

