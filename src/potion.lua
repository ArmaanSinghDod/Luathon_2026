local Object = require("lib.classic")

local Potion = Object:extend()

function Potion:new()
    self.recipe = {
        seta = 1,
        huevoSerpiente = 1,
        caspaDeTroll = 1
    }

    self.image = love.graphics.newImage("src/textures/potion.png")
    self.scale = 0.08
    self.timer = 0
    self.visible = false
    self.position = { x = 0, y = 0 }
end

function Potion:update(dt)
    if self.visible then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.visible = false
        end
    end
end

function Potion:draw()
    if self.visible then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            self.image,
            self.position.x,
            self.position.y,
            0,
            self.scale,
            self.scale,
            self.image:getWidth() / 2,
            self.image:getHeight() / 2
        )
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Potion:canCraft(inventory)
    for ingredient, amount in pairs(self.recipe) do
        if inventory[ingredient] < amount then
            return false
        end
    end
    return true
end

function Potion:craft(player)
    if not self:canCraft(player.inventory) then
        return false
    end

    for ingredient, amount in pairs(self.recipe) do
        player.inventory[ingredient] = player.inventory[ingredient] - amount
    end

    player.health = player.maxHealth
    player.damageGraceTimer = 0.5
    self.visible = true
    self.timer = 0.8
    self.position.x = player.position.x
    self.position.y = player.position.y - 60

    return true
end

return Potion
