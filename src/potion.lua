local Actor = Actor or require "src/actor"
local Vector = Vector or require "lib/vector"
local potion = Actor:extend()
local timer=0


function potion:new()
  local randomX = love.math.random(100,700)
  local randomY = love.math.random(100,500)
    potion.super.new(self, "src/textures/potion.png", randomX, randomY)
    --Hace una pocion en una posicion random de la pantalla y como habra una bruma negra el jugador ha de ir regenarado su vida antes de que se acabe con estas posiciones que con un timer iran apareciendo de manera alearoria
  self.rot = math.pi
end

function potion:update(dt) 

  
end

function potion:draw()
  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local rr = self.rot
  love.graphics.draw(self.image, xx, yy, rr, 1, 1, ox, oy)
end

return potion
