local Object = require("lib.classic")

local Background = Object:extend()

function Background:new(imagePath)
    self.image = imagePath and love.graphics.newImage(imagePath) or nil
    self.player = nil
end

function Background:update(dt, player)
    self.player = player
end

function Background:draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    if not self.image then
        love.graphics.setColor(0.12, 0.16, 0.2, 1)
        love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
        love.graphics.setColor(1, 1, 1, 1)
        return
    end

    local scale = math.max(
        screenWidth / self.image:getWidth(),
        screenHeight / self.image:getHeight()
    )
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        self.image,
        screenWidth / 2,
        screenHeight / 2,
        0,
        scale,
        scale,
        self.image:getWidth() / 2,
        self.image:getHeight() / 2
    )
end

function Background:setImage(imagePath)
    self.image = love.graphics.newImage(imagePath)
end

function Background:drawDarkness()
    local player = self.player
    if not player then
        return
    end

    local radius = 80
    local fadeDistance = 50
    local fadeSteps = 8
    local darknessPerStep = 0.21

    for step = 0, fadeSteps do
        local lightRadius = radius + fadeDistance * step / fadeSteps
        love.graphics.stencil(function()
            love.graphics.circle("fill", player.position.x, player.position.y, lightRadius)
        end, "replace", 1)
        love.graphics.setStencilTest("equal", 0)
        love.graphics.setColor(0, 0, 0, darknessPerStep)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    end

    love.graphics.setStencilTest()
    love.graphics.setColor(1, 1, 1, 1)
end

return Background
