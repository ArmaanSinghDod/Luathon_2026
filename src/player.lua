local Actor = require("src.actor")

local Player = Actor:extend()

local speed = 500

function Player:new(x, y)
    Player.super.new(self, "src/textures/player.png", x or 180, y or 540, 0)
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
end

function Player:draw()
    love.graphics.scale(0.2,0.2)
    love.graphics.draw(
        self.image,
        self.position.x, self.position.y,
        self.rot, 1, 1,
        self.origin.x, self.origin.y
        
    )
    
end

return Player