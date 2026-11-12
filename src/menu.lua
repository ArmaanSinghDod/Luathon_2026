local Object = require("lib.classic")

local Menu = Object:extend()

function Menu:new()
    self.titleFont = love.graphics.newFont(48)
    self.optionFont = love.graphics.newFont(26)
    self.selected = 1
    self.options = {
        { label = "Jugar", action = "play" },
        { label = "Salir", action = "quit" }
    }
    self.optionBounds = {}
end

function Menu:update(dt)

end

function Menu:draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    love.graphics.setColor(0, 0, 0, 0.55)
    love.graphics.rectangle("fill", 0, 0, screenWidth, screenHeight)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(self.titleFont)
    love.graphics.printf("One Last Potion", 0, screenHeight * 0.27, screenWidth, "center")

    love.graphics.setFont(self.optionFont)
    self.optionBounds = {}
    for index, option in ipairs(self.options) do
        local width = 240
        local height = 50
        local x = (screenWidth - width) / 2
        local y = screenHeight * 0.52 + (index - 1) * 70
        self.optionBounds[index] = { x = x, y = y, width = width, height = height }

        if self.selected == index then
            love.graphics.setColor(0.25, 0.65, 0.35, 0.9)
            love.graphics.rectangle("fill", x, y, width, height, 8, 8)
        end

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(option.label, x, y + 9, width, "center")
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function Menu:open()
    self.selected = 1
end

function Menu:keypressed(key)
    if key == "up" or key == "w" then
        self.selected = (self.selected - 2) % #self.options + 1
    elseif key == "down" or key == "s" then
        self.selected = self.selected % #self.options + 1
    elseif key == "return" or key == "kpenter" or key == "space" then
        return self.options[self.selected].action
    end
end

function Menu:mousepressed(x, y, button)
    if button ~= 1 then
        return
    end

    for index, bounds in ipairs(self.optionBounds) do
        if x >= bounds.x and x <= bounds.x + bounds.width and
           y >= bounds.y and y <= bounds.y + bounds.height then
            self.selected = index
            return self.options[index].action
        end
    end
end

return Menu
