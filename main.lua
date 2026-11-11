 Player = Player or require("src.Player")
 Object = Object or require("lib.classic")
Potion = Potion or require("src.potion")
Spawner = Spawner or require("src.spawner")
HUD = HUD or require("src.hud")

actorList={}
local p
local hud
function love.load()
    p =Player()   
    table.insert(actorList,p)
    local sp = Spawner(1,true)
    table.insert(actorList,sp)
    hud = HUD()
end

function love.update(dt)
    for _, v in pairs(actorList) do
            v:update(dt)
    end
        
    hud:update(dt)
end

function love.draw()
    for _, v in pairs(actorList) do
            v:draw(dt)
        end
    hud:draw()
end