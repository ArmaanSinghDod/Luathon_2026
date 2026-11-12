
local Actor = require("src.actor")

local Ingredient = Actor:extend()

local ingredientImages = {
    seta = "src/textures/seta.png",
    caspaDeTroll = "src/textures/caspaDeTroll.png",
    huevoSerpiente = "src/textures/huevoSerpiente.png"
}

function Ingredient:new(_type, x, y)
    local image = ingredientImages[_type]
    assert(image, "Tipo de ingrediente desconocido: " .. tostring(_type))
    Ingredient.super.new(self, image, x, y, 0)

    self.type = _type
    self.isIngredient = true
    self.scale = 0.09

    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
end

function Ingredient:update(dt)
    
end

function Ingredient:draw()
    love.graphics.setColor(0.7, 0.85, 0.48, 0.65)
    love.graphics.setLineWidth(2)
    love.graphics.ellipse(
        "line",
        self.position.x,
        self.position.y,
        self.width / 2 + 5,
        self.height / 2 + 5
    )

    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.image, self.position.x, self.position.y, self.rot, self.scale, self.scale, self.origin.x, self.origin.y)
    love.graphics.setColor(1, 1, 1, 1)
end

return Ingredient
