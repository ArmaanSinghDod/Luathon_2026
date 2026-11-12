local Vector = require "lib/vector"
local Object = require "lib/object"

local Actor = Object:extend()

function Actor:new(_image, _x, _y, _speed)
    self.position = Vector.new(_x or 0, _y or 0)
    self.forward = Vector.new(1, 0)

    self.speed = _speed or 0

    self.image = nil
    self.width = 0
    self.height = 0

    if _image then
        self.image = love.graphics.newImage(_image)

        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

        self.origin = Vector.new(self.width / 2, self.height / 2)
    end

    self.rot = 0
end

function Actor:update(dt)

end

function Actor:draw()

end

function Actor:dist(aa)
    local xx = self.position.x - aa.position.x
    local yy = self.position.y - aa.position.y

    return math.sqrt(xx * xx + yy * yy)
end

function Actor:checkCollision(other)
    return math.abs(self.position.x - other.position.x) <= (self.width + other.width) / 2 and
           math.abs(self.position.y - other.position.y) <= (self.height + other.height) / 2
end

return Actor
