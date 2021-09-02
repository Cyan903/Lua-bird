Pipe = {}

function Pipe:new()
    local obj = {
        x = 0, y = 0,
        w = 0, h = 0,
        index = 0,
        pointable = true,
        primary = false
    }
    
    self.__index = self
    return setmetatable(obj, self)
end

function Pipe:init(height, index, primary)
    self.x = CONSTANTS.game.width+CONSTANTS.pipe.width
    self.y = 0

    self.w = CONSTANTS.pipe.width
    self.h = height

    self.index = index
    self.primary = primary
end

function Pipe:draw()
    love.graphics.setColor(1, 0, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Pipe:update()
    self.x = self.x - CONSTANTS.pipe.speed

    if self.x <= -self.w then
        -- print("oh. im die. thank you forever", self.index)
        local height = genPipeDims()
        
        self.x = CONSTANTS.game.width+CONSTANTS.pipe.width
        self.pointable = true

        if self.primary then
            self.h = height[1]
            pipes[self.index+1].h = height[2]
            pipes[self.index+1].y = height[1]+CONSTANTS.pipe.height
        end
    else
        if self.x <= bird.x and self.pointable and self.primary then
            self.pointable = false
            game.points = game.points+1
        end

        if isAlive(self, bird) then
            game.playstate = "dead"
        end
    end
end

function genPipeDims()
    local top = love.math.random(10, CONSTANTS.game.height-(CONSTANTS.pipe.height*2))
    local bottom = CONSTANTS.game.height-(top+CONSTANTS.pipe.height)
    return {top, bottom}
end

function generatePipe(offset)
    local height = genPipeDims()
    
    -- top pipe
    pipes[#pipes+1] = Pipe:new()
    pipes[#pipes]:init(height[1], #pipes, true)
    pipes[#pipes].x = pipes[#pipes].x+offset

    -- bottom pipe
    pipes[#pipes+1] = Pipe:new()
    pipes[#pipes]:init(height[2], #pipes, false)
    pipes[#pipes].y = height[1]+CONSTANTS.pipe.height
    pipes[#pipes].x = pipes[#pipes].x+offset
end

function generatePipes()
    for i = 1, CONSTANTS.game.width, CONSTANTS.pipe.width*3 do
        generatePipe(i)
    end
end

function drawPipes()
    for i = 1, #pipes do
        if pipes[i] then
            pipes[i]:draw()
        end
    end
end

function updatePipes()
    for i = 1, #pipes do
        if pipes[i] then
            pipes[i]:update()
        end
    end
end

function isAlive(r1, r2)
    return not (r1.x > r2.x+r2.w or r1.x+r1.w < r2.x or r1.y > r2.y+r2.h or r1.y+r1.h < r2.y);
end

return Pipe