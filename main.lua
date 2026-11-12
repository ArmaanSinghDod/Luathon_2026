local Background = require("src.background")
local Player = require("src.player")
local Spawner = require("src.spawner")
local HUD = require("src.hud")
local Menu = require("src.menu")

actorList = {}
local p
local hud
local background
local menu
local gameState = "menu"
local pauseOptions = { "Continuar", "Reiniciar", "Salir" }
local pauseSelection = 1
local pauseOptionBounds = {}
local gameOverOptions = { "Volver a jugar", "Salir" }
local gameOverSelection = 1
local gameOverOptionBounds = {}
local pauseTitleFont
local pauseOptionFont
local gameOverTitleFont
local gameOverRoundFont
local gameOverOptionFont

local function startGame()
    actorList = {}
    p = Player()
    background:update(0, p)
    table.insert(actorList, p)
    table.insert(actorList, Spawner(3, true))
    hud = HUD()
    gameOverSelection = 1
    gameState = "playing"
end

local function resumeGame()
    gameState = "playing"
end

local function drawPauseMenu()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    love.graphics.setColor(0, 0, 0, 0.65)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(pauseTitleFont)
    love.graphics.printf("Pausa", 0, screenHeight * 0.3, screenWidth, "center")

    love.graphics.setFont(pauseOptionFont)
    pauseOptionBounds = {}
    for index, label in ipairs(pauseOptions) do
        local width = 240
        local height = 50
        local x = (screenWidth - width) / 2
        local y = screenHeight * 0.48 + (index - 1) * 70
        pauseOptionBounds[index] = { x = x, y = y, width = width, height = height }

        if pauseSelection == index then
            love.graphics.setColor(0.25, 0.65, 0.35, 0.9)
            love.graphics.rectangle("fill", x, y, width, height, 8, 8)
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(label, x, y + 9, width, "center")
    end

    love.graphics.setColor(1, 1, 1, 1)
end

local function selectPauseOption(index)
    if index == 1 then
        resumeGame()
    elseif index == 2 then
        startGame()
    else
        love.event.quit()
    end
end

local function drawGameOver()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local panelWidth = 390
    local panelHeight = 250
    local panelX = (screenWidth - panelWidth) / 2
    local panelY = (screenHeight - panelHeight) / 2

    love.graphics.setColor(0, 0, 0, 0.78)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(0.08, 0.1, 0.1, 0.97)
    love.graphics.rectangle("fill", panelX, panelY, panelWidth, panelHeight)

    love.graphics.setColor(1, 0.72, 0.62, 1)
    love.graphics.setFont(gameOverTitleFont)
    love.graphics.printf("Has muerto", panelX + 25, panelY + 25, panelWidth - 50, "center")

    love.graphics.setColor(0.88, 0.9, 0.86, 1)
    love.graphics.setFont(gameOverRoundFont)
    love.graphics.printf("Rondas: " .. p.round, panelX + 25, panelY + 65, panelWidth - 50, "center")

    gameOverOptionBounds = {}
    love.graphics.setFont(gameOverOptionFont)
    for index, label in ipairs(gameOverOptions) do
        local width = 280
        local height = 48
        local x = (screenWidth - width) / 2
        local y = panelY + 108 + (index - 1) * 56
        gameOverOptionBounds[index] = { x = x, y = y, width = width, height = height }

        if gameOverSelection == index then
            love.graphics.setColor(0.35, 0.52, 0.34, 1)
            love.graphics.rectangle("fill", x, y, width, height, 7, 7)
        else
            love.graphics.setColor(0.18, 0.22, 0.2, 1)
            love.graphics.rectangle("fill", x, y, width, height, 7, 7)
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(label, x, y + 9, width, "center")
    end

    love.graphics.setColor(1, 1, 1, 1)
end

local function selectGameOverOption(index)
    if index == 1 then
        startGame()
    else
        love.event.quit()
    end
end

function love.load()
    math.randomseed(os.time())
    background = Background("src/textures/backgroundLuathon.png")
    menu = Menu()
    pauseTitleFont = love.graphics.newFont(42)
    pauseOptionFont = love.graphics.newFont(26)
    gameOverTitleFont = love.graphics.newFont(32)
    gameOverRoundFont = love.graphics.newFont(24)
    gameOverOptionFont = love.graphics.newFont(20)
end

function love.update(dt)
    background:update(dt, p)
    if gameState == "menu" then
        menu:update(dt)
        return
    end
    if gameState ~= "playing" or p.gameOver then
        return
    end

    for i = #actorList, 1, -1 do
        local actor = actorList[i]
        if actor then
            actor:update(dt)
        end
    end

    hud:update(dt, p)
end

function love.draw()
    background:draw()

    if gameState == "menu" then
        menu:draw()
        return
    end

    for _, actor in ipairs(actorList) do
        if not actor.isPlayer and not actor.isIngredient then
            actor:draw()
        end
    end

    for _, actor in ipairs(actorList) do
        if actor.isIngredient then
            actor:draw()
        end
    end

    background:drawDarkness()

    if p then
        p:draw()
    end
    hud:draw(p)

    if gameState == "paused" then
        drawPauseMenu()
    elseif p.gameOver then
        drawGameOver()
    end
end

function love.keypressed(key)
    if gameState == "menu" then
        local action = menu:keypressed(key)
        if action == "play" then
            startGame()
        elseif action == "quit" then
            love.event.quit()
        end
        return
    end

    if gameState == "paused" then
        if key == "escape" then
            resumeGame()
        elseif key == "up" or key == "w" then
            pauseSelection = (pauseSelection - 2) % #pauseOptions + 1
        elseif key == "down" or key == "s" then
            pauseSelection = pauseSelection % #pauseOptions + 1
        elseif key == "return" or key == "kpenter" or key == "space" then
            selectPauseOption(pauseSelection)
        end
        return
    end

    if p.gameOver then
        if key == "up" or key == "w" then
            gameOverSelection = (gameOverSelection - 2) % #gameOverOptions + 1
        elseif key == "down" or key == "s" then
            gameOverSelection = gameOverSelection % #gameOverOptions + 1
        elseif key == "return" or key == "kpenter" or key == "space" then
            selectGameOverOption(gameOverSelection)
        end
        return
    end

    if key == "escape" then
        pauseSelection = 1
        gameState = "paused"
    end
end

function love.mousepressed(x, y, button)
    if p and p.gameOver then
        if button ~= 1 then
            return
        end
        for index, bounds in ipairs(gameOverOptionBounds) do
            if x >= bounds.x and x <= bounds.x + bounds.width and
               y >= bounds.y and y <= bounds.y + bounds.height then
                gameOverSelection = index
                selectGameOverOption(index)
                return
            end
        end
        return
    end

    if gameState == "paused" then
        if button ~= 1 then
            return
        end
        for index, bounds in ipairs(pauseOptionBounds) do
            if x >= bounds.x and x <= bounds.x + bounds.width and
               y >= bounds.y and y <= bounds.y + bounds.height then
                pauseSelection = index
                selectPauseOption(index)
                return
            end
        end
        return
    end

    if gameState ~= "menu" then
        return
    end

    local action = menu:mousepressed(x, y, button)
    if action == "play" then
        startGame()
    elseif action == "quit" then
        love.event.quit()
    end
end