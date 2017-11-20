function love.load()
    timer = 0

    snakeSegments = {
        { x = 3, y = 1},
        { x = 2, y = 1},
        { x = 1, y = 1},
    }

    direction = 'right'
end

function love.update(dt)
    timer = timer + dt
    local timerLimit = 0.15
    if timer >= timerLimit then
        timer = timer - timerLimit

        local nextXPos = snakeSegments[1].x
        local nextYPos = snakeSegments[1].y

        if direction == 'right' then
            nextXPos = nextXPos + 1
        elseif direction == 'up' then
            nextYPos = nextYPos - 1
        elseif direction == 'left' then
            nextXPos = nextXPos - 1
        elseif direction == 'down' then
            nextYPos = nextYPos + 1
        end

        table.insert(snakeSegments, 1, { x = nextXPos, y = nextYPos })
        table.remove(snakeSegments)

        print('Tick')
    end
end

function love.draw()
    local gridXCount = 20
    local gridYCount = 15
    local cellSize = 35

    love.graphics.setColor(63, 63, 63)
    love.graphics.rectangle('fill', 0, 0, gridXCount * cellSize, gridYCount * cellSize)

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

function love.keypressed(key)
    if key == 'right' then
        direction = 'right'
    elseif key == 'up' then
        direction = 'up'
    elseif key == 'left' then
        direction = 'left'
    elseif key == 'down' then
        direction = 'down'
    end
end