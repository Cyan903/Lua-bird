--[[
    Flappy Bird Lua
    CyanPiano - 2021/09/02

    https://github.com/CyanPiano/Flappy-Bird-Lua
--]]

local Game = require("./objects/Game")
local Player = require("./objects/Player")
local Pipe = require("./objects/Pipe")

CONSTANTS = require("./consts")

function love.load()
    game = Game:new()
    game:init()
end

function love.update(dt)
    if game.playstate == "playing" then
        bird:update(dt)
        updatePipes()
    end
end

function love.draw()
    if game.playstate == "playing" or game.playstate == "dead" then
        drawPipes()

        bird:draw()
        game:drawPoints()
        
        if game.playstate == "dead" then
            game:drawDead()
        end
    elseif game.playstate == "waiting" then
        game:drawAwait()
    end
end

function love.keypressed(key)
    if game.playstate == "playing" then
        bird:fly()
    elseif game.playstate == "waiting" or game.playstate == "dead" then
        game:init()
        game.playstate = "playing"
    end
end