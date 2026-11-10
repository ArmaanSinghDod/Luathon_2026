local Player = Player or require("src.Player")
local Object = Object or require("lib.classic")
local Potion = Potion or require("src.potion")
local Spawner = Spawner or require("src.spawner")

actorList={}
function love.load()
local p =Player()   
table.insert(actorList,p)
local sp = Spawner()
table.insert(actorList,sp)

end

function love.update(dt)
    for _, v in pairs(actorList) do
            v:update(dt)
        end
end

function love.draw()
    for _, v in pairs(actorList) do
            v:draw(dt)
        end
end