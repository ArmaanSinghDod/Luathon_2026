local Object = Object or require "lib.classic"
local HUD = Object:extend()

function HUD:new()
    self.potionImage = love.graphics.newImage("src/textures/potion.png")
    self.hudScale = 0.04
    self.font = love.graphics.newFont(18)
end

function HUD:update(dt)
end

function HUD:draw()
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), 45)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.font)

 --prueba de que funciona hud con foto de pocion
  local text = "Objetivo: Recoge "
    local textX = 15
    local textY = 11
    local textWidth = self.font:getWidth(text)

    love.graphics.setColor(0.3, 0.3, 0.3, 0.8)
    love.graphics.rectangle("fill", textX - 5, textY - 3, textWidth + 45, 26)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print(text, textX, textY)
    love.graphics.draw(self.potionImage, textX + textWidth + 10, 7, 0, self.hudScale, self.hudScale)
end

return HUD