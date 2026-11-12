local Actor = require("src.actor")
local Potion = require("src.potion")

local Player = Actor:extend()

local speed = 390
local maxDamagePerSecond = 30
local damageStepDuration = 9
local damagePerStep = 2

function Player:new(x, y)
    Player.super.new(self, "src/textures/player.png", x or 512, y or 300, 0)

    self.scale = 0.12
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale

    self.isPlayer = true
    self.potion = Potion()

    self.maxHealth = 100
    self.health = self.maxHealth

    self.timeAlive = 0
    self.damage = damagePerStep
    self.damageGraceTimer = 0
    self.round = 0

    self.inventory = {
        seta = 0,
        huevoSerpiente = 0,
        caspaDeTroll = 0
    }

    self.positions = 0
    self.gameOver = false
end

function Player:update(dt)
    if self.gameOver then
        return
    end

    if love.keyboard.isDown("w") then
        self.position.y = self.position.y - speed * dt
    end
    if love.keyboard.isDown("s") then
        self.position.y = self.position.y + speed * dt
    end
    if love.keyboard.isDown("a") then
        self.position.x = self.position.x - speed * dt
    end
    if love.keyboard.isDown("d") then
        self.position.x = self.position.x + speed * dt
    end
    --limits pantalla amb el player
    local halfW = self.width / 2
    local halfH = self.height / 2
    self.position.x = math.max(halfW, math.min(self.position.x, 1024 - halfW))
    self.position.y = math.max(halfH, math.min(self.position.y, 600 - halfH))

    self.timeAlive = self.timeAlive + dt
    self.damage = math.min(
        maxDamagePerSecond,
        damagePerStep +
            math.floor(self.timeAlive / damageStepDuration) * damagePerStep +
            self.round
    )
    local damageDt = math.min(dt, 0.25)
    if self.damageGraceTimer > 0 then
        local graceDt = math.min(damageDt, self.damageGraceTimer)
        self.damageGraceTimer = self.damageGraceTimer - graceDt
        damageDt = damageDt - graceDt
    end
    self.health = math.max(0, self.health - self.damage * damageDt)
    self.potion:update(dt)

    if self.health <= 0 then
        self.gameOver = true
        return
    end

    for i = #actorList, 1, -1 do
        local actor = actorList[i]
        if actor.isIngredient and self:checkCollision(actor) then
            self.inventory[actor.type] = self.inventory[actor.type] + 1
            table.remove(actorList, i)
            if self.potion:craft(self) then
                self.round = self.round + 1
                for _, spawner in ipairs(actorList) do
                    if spawner.isSpawner then
                        spawner:trigger()
                        break
                    end
                end
            end
        end
    end
end


function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)

    --love.graphics.scale(0.2,0.2)
    love.graphics.draw(
        self.image,
        self.position.x, self.position.y,
        self.rot,
        self.scale, self.scale,
        self.origin.x, self.origin.y
    )

    self.potion:draw()
end

return Player