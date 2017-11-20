function love.load()
    timer = 0

    snakeSegments = {
        { x = 3, y = 1},
        { x = 2, y = 1},
        { x = 1, y = 1},
    }

    directionQueue = { 'right' }
end

function love.update(dt)
    timer = timer + dt
    local timerLimit = 0.15
    if timer >= timerLimit then
        timer = timer - timerLimit

        if #directionQueue > 1 then
            table.remove(directionQueue, 1)
        end

        local nextXPos = snakeSegments[1].x
        local nextYPos = snakeSegments[1].y

        if directionQueue[1] == 'right' then
            nextXPos = nextXPos + 1
        elseif directionQueue[1] == 'up' then
            nextYPos = nextYPos - 1
        elseif directionQueue[1] == 'left' then
            nextXPos = nextXPos - 1
        elseif directionQueue[1] == 'down' then
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

    for directionIndex, direction in ipairs(directionQueue) do
        love.graphics.setColor(191, 191, 191)
        love.graphics.print('directionQueue['..directionIndex..']: '..direction, 15, 15 * directionIndex)
    end
end

function love.keypressed(key)
    if key == 'right' and directionQueue[#directionQueue] ~= 'left' and directionQueue[#directionQueue] ~= 'right' then
        table.insert(directionQueue, 'right')
    elseif key == 'up' and directionQueue[#directionQueue] ~= 'down' and directionQueue[#directionQueue] ~= 'up' then
        table.insert(directionQueue, 'up')
    elseif key == 'left' and directionQueue[#directionQueue] ~= 'right' and directionQueue[#directionQueue] ~= 'left' then
        table.insert(directionQueue, 'left')
    elseif key == 'down' and directionQueue[#directionQueue] ~= 'up' and directionQueue[#directionQueue] ~= 'down' then
        table.insert(directionQueue, 'down')
    end
end