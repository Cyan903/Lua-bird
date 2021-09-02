Player = {}

function Player:new()
    local obj = {
        x = 0, y = 0,
        w = 0, h = 0,
        yspeed = 0
    }
    
    self.__index = self
    return setmetatable(obj, self) 
end

function Player:init()
    self.x = CONSTANTS.game.width/6
	self.y = CONSTANTS.game.height/3
    
    self.w = CONSTANTS.bird.width
    self.h = CONSTANTS.bird.height
end

function Player:draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Player:update(dt)
    self.yspeed = self.yspeed + (CONSTANTS.bird.fallspeed*dt)
    self.y = self.y+self.yspeed*dt
end

function Player:fly()
    self.yspeed = -CONSTANTS.bird.jumpspeed
end

return Player