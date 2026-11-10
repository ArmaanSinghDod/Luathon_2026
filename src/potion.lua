Actor = Actor or require "src/actor"
Vector = Vector or require "lib/vector"

local potion = Actor:extend()
local timer=0

love.math.setRandomSeed(os.time())
function potion:new()
  local randomX = love.math.random(800)
  local randomY = love.math.random(600)
 
    potion.super.new(self, "src/textures/potion.png", randomX, randomY)
          --love.graphics.scale(0.2,0.2)
    --Hace una pocion en una posicion random de la pantalla y como habra una bruma negra el jugador ha de ir regenarado su vida antes de que se acabe con estas
     --posiciones que con un timer iran apareciendo de manera alearoria
end

function potion:update(dt) 

  
end

function potion:draw()

  local xx = self.position.x
  local ox = self.origin.x
  local yy = self.position.y
  local oy = self.origin.y
  local rr = self.rot
  print (xx.. " " .. yy)
  love.graphics.draw(self.image, xx, yy)
end

return potion
