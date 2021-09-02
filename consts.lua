love.window.setMode(900, 600)
love.window.setTitle("Flappy Bird - ish")

return {
    game = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight()
    },

    bird = {
        width = 20,
        height = 20,
        fallspeed = 600,
        jumpspeed = 200
    },

    pipe = {
        width = 70,
        height = 200, -- aka the gap
        speed = 3
    }
}