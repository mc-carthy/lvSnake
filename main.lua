function love.load()

end

function love.update(dt)

end

function love.draw()
    local gridXCount = 20
    local gridYCount = 15
    local cellSize = 35

    love.graphics.setColor(63, 63, 63)
    love.graphics.rectangle('fill', 0, 0, gridXCount * cellSize, gridYCount * cellSize)

    local snakeSegments = {
        { x = 3, y = 1},
        { x = 2, y = 1},
        { x = 1, y = 1},
    }

    for segmentIndex, segment in ipairs(snakeSegments) do
        love.graphics.setColor(95, 191, 95)
        love.graphics.rectangle(
            'fill',
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end
end