local Object = require("lib.classic")
local Ingredient = require("src.ingredient")

local Spawner = Object:extend()

local ingredientTypes = {
    "seta",
    "caspaDeTroll",
    "huevoSerpiente"
}

function Spawner:new(_time, _repeat)
    self.isSpawner = true
    self.tFinal = _time or 5
    self.tActual = self.tFinal
    self.loop = _repeat == true
end

function Spawner:update(dt)
    self.tActual = self.tActual + dt
    if self.tActual >= self.tFinal then
        self:trigger()
        if self.loop then
            self.tActual = 0
        else
            for k, v in pairs(actorList) do
                if v == self then
                    table.remove(actorList, k)
                    break
                end
            end
        end
    end
end

function Spawner:draw()

end

function Spawner:trigger()
    local player
    for _, actor in ipairs(actorList) do
        if actor.isPlayer then
            player = actor
            break
        end
    end

    if not player then
        return
    end

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    for _, ingredientType in ipairs(ingredientTypes) do
        if player.inventory[ingredientType] == 0 then
            local alreadySpawned = false
            for _, actor in ipairs(actorList) do
                if actor.isIngredient and actor.type == ingredientType then
                    alreadySpawned = true
                    break
                end
            end

            if not alreadySpawned then
                local margin = 35
                local x = math.random(margin, screenWidth - margin)
                local y = math.random(70, screenHeight - margin)
                table.insert(actorList, Ingredient(ingredientType, x, y))
            end
        end
    end
end

return Spawner
