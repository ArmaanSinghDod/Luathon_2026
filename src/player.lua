local Object = Object or require("lib.classic")
Player = Object:extend()

function Player.new(_x,_y,_speed,_radius)
        
    self.x = _x or w/2
    self.y=_y or h/2
    self.radius = _radius or 10
    self.speed = _speed or 250
    
    self.width = self.radius / 2
    self.height = self.radius / 2

    self.image = love.graphics.newImage("src/textures/player.png")
end

function Player:update(dt)
    
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
        
    end
    
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
        
    end
    
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
        
    end

    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
        
    end

    if self.x - self.width / 2 < 0 then
    self.x = self.width / 2
    elseif self.x + self.width / 2 > w then
    self.x = w - self.width / 2
    end

    if self.y - self.height / 2 < 0 then
    self.y = self.height / 2
    elseif self.y + self.height / 2 > h then
    self.y = h - self.height / 2
    end

end

function Player:draw()
    if self.image then
        love.graphics.setColor(1, 1, 1)
        local spriteWidth = self.image:getWidth()  -- ancho
        local spriteHeight = self.image:getHeight()  -- alto
        local scale = ((self.radius * 2) / spriteWidth) * 3.5  -- para escalar la imagen
        love.graphics.draw(self.image, self.x, self.y, 0, scale, scale, spriteWidth / 2, spriteHeight / 2)
    end

end


return Player
