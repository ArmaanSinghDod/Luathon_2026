local Actor = require("src.actor")

local Player = Actor:extend()

local speed = 500

function Player:new(x, y)
    Player.super.new(self, "src/textures/player.png", x or 512, y or 300, 0)
    self.scale = 0.18
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
end

function Player:update(dt)
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
end

function Player:draw()
    --love.graphics.scale(0.2,0.2)
    love.graphics.draw(
        self.image,
        self.position.x, self.position.y,
        self.rot,
        self.scale, self.scale,
        self.origin.x, self.origin.y
        
    )
    
end

return Player