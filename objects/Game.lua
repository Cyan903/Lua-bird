Game = {}

function Game:new()
    local obj = {
        points = 0,
        playstate = "waiting",
        pointsData = {
            x = CONSTANTS.game.width/2,
            y = 100
        }
    }
    
    self.__index = self
    return setmetatable(obj, self) 
end

function Game:init()
    self.points = 0

    bird = Player:new()
    pipes = {}
    bird:init()

    generatePipes()
end

function Game:drawPoints()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Total Points: "..self.points, CONSTANTS.game.width-200, 30, 0, 2)
end

function Game:drawAwait()
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("Press any key to start the game!", 0, CONSTANTS.game.height/2, CONSTANTS.game.width, "center")
    love.graphics.print(
        string.format(
            "Player fall/fly speed = %d/%d, Pipe speed = %d",
            CONSTANTS.bird.fallspeed, CONSTANTS.bird.jumpspeed,
            CONSTANTS.pipe.speed
        ), 
        
        0, CONSTANTS.game.height-15, 0
    )
end

function Game:drawDead()
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(string.format("You died! Your score was %d.", self.points), 0, CONSTANTS.game.height/2, CONSTANTS.game.width, "center") 
end

return Game