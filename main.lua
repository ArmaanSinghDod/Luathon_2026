 Player = Player or require("src.Player")
 Object = Object or require("lib.classic")
Potion = Potion or require("src.potion")
Spawner = Spawner or require("src.spawner")

actorList={}
function love.load()
    local p =Player()   
    table.insert(actorList,p)
    local sp = Spawner(1,true)
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