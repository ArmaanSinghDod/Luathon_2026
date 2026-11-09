local Player = Player or require("src.Player")
local Object = Object or require("lib.classic")

actorList={}
function love.load()
    player = love.graphics.newImage("src/textures/Player.png")
  player = Player(350, 10)
    player.color = {1,1,0}
    table.insert(actorList, player)
end

function love.update(dt)
    for _, v in pairs(actorList) do
            v:update(dt)
        end
end

function love.draw()

end