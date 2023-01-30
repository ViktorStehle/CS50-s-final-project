Box = Entity:extend()

function Box:new(x, y)
    Box.super.new(self, x, y, "start-assets/box.png")
end


