local Object = require("lib.classic")
local HUD = Object:extend()

local ingredients = {
    { key = "seta", label = "seta" },
    { key = "caspaDeTroll", label = "pelo" },
    { key = "huevoSerpiente", label = "huevo" }
}

function HUD:new()
    self.images = {
        seta = love.graphics.newImage("src/textures/seta.png"),
        caspaDeTroll = love.graphics.newImage("src/textures/caspaDeTroll.png"),
        huevoSerpiente = love.graphics.newImage("src/textures/huevoSerpiente.png"),
        potion = love.graphics.newImage("src/textures/potion.png")
    }
    self.font = love.graphics.newFont(12)
    self.roundFont = love.graphics.newFont(22)
    self.animationTime = 0
end

function HUD:update(dt, player)
    self.animationTime = self.animationTime + dt
    self.player = player
end

function HUD:draw(player)
    player = player or self.player
    if not player then
        return
    end

    local height = 62
    local screenWidth = love.graphics.getWidth()
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 0, 0, screenWidth, height)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.font)

    for index, ingredient in ipairs(ingredients) do
        local x = 14 + (index - 1) * 54
        local collected = player.inventory[ingredient.key] > 0 or player.potion.visible
        local image = self.images[ingredient.key]
        local scale = math.min(30 / image:getWidth(), 30 / image:getHeight())
        local alpha = collected and 1 or 0.4

        love.graphics.setColor(0.12, 0.12, 0.12, 0.8)
        love.graphics.rectangle("fill", x, 3, 42, 42, 5, 5)
        if collected then
            love.graphics.setColor(0.35, 1, 0.35, 0.9)
            love.graphics.setLineWidth(2)
            love.graphics.rectangle("line", x, 3, 42, 42, 5, 5)
        end

        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(
            image,
            x + 21,
            23,
            0,
            scale,
            scale,
            image:getWidth() / 2,
            image:getHeight() / 2
        )
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(ingredient.label, x, 46, 42, "center")
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("=", 179, 13)

    local potionImage = self.images.potion
    local potionScale = math.min(30 / potionImage:getWidth(), 30 / potionImage:getHeight())
    local potionActive = player.potion.visible
    local pulse = 0.75 + 0.25 * math.sin(self.animationTime * 10)
    love.graphics.setColor(0.12, 0.12, 0.12, 0.8)
    love.graphics.rectangle("fill", 200, 3, 42, 42, 5, 5)
    if potionActive then
        love.graphics.setColor(1, 0.8, 0.2, pulse)
        love.graphics.setLineWidth(2)
        love.graphics.rectangle("line", 200, 3, 42, 42, 5, 5)
    end
    love.graphics.setColor(1, 1, 1, potionActive and 1 or 0.4)
    love.graphics.draw(
        potionImage,
        221,
        23,
        0,
        potionScale,
        potionScale,
        potionImage:getWidth() / 2,
        potionImage:getHeight() / 2
    )
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("poción", 200, 46, 42, "center")

    local healthX = screenWidth - 245
    local healthWidth = 225
    local healthRatio = player.health / player.maxHealth
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.roundFont)
    love.graphics.printf("RONDA: " .. player.round, 260, 14, screenWidth - 520, "center")
    love.graphics.setFont(self.font)
    love.graphics.print("VIDA " .. math.ceil(player.health) .. " / " .. player.maxHealth, healthX, 5)
    love.graphics.setColor(0.2, 0.2, 0.2, 0.9)
    love.graphics.rectangle("fill", healthX, 27, healthWidth, 18, 4, 4)
    love.graphics.setColor(0.2 + 0.75 * (1 - healthRatio), 0.8 * healthRatio, 0.2, 1)
    love.graphics.rectangle("fill", healthX + 2, 29, (healthWidth - 4) * healthRatio, 14, 3, 3)
    love.graphics.setColor(1, 1, 1, 1)
end

return HUD