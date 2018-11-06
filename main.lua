function love.load()
    reset()
    
    gridXCount = 20
    gridYCount = 15

    moveFood()
end

function love.update(dt)
    timer = timer + dt

    if snakeAlive then 
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
                if nextXPos > gridXCount then
                    nextXPos = 1
                end
            elseif directionQueue[1] == 'up' then
                nextYPos = nextYPos - 1
                if nextYPos < 1 then
                    nextYPos = gridYCount
                end
            elseif directionQueue[1] == 'left' then
                nextXPos = nextXPos - 1
                if nextXPos < 1 then
                    nextXPos = gridXCount
                end
            elseif directionQueue[1] == 'down' then
                nextYPos = nextYPos + 1
                if nextYPos > gridYCount then
                    nextYPos = 1
                end
            end

            local canMove = true

            for segmentIndex, segment in ipairs(snakeSegments) do
                if segmentIndex ~= #snakeSegments and 
                    nextXPos == segment.x and
                    nextYPos == segment.y  then
                    canMove = false
                end
            end

            if canMove then
                table.insert(snakeSegments, 1, { x = nextXPos, y = nextYPos })
                
                if snakeSegments[1].x == foodPos.x and snakeSegments[1].y == foodPos.y then
                    moveFood()
                else
                    table.remove(snakeSegments)
                end
            else
                snakeAlive = false
            end
        end
    elseif timer >= 2 then
        reset()
    end
end

function love.draw()
    local cellSize = 35

    love.graphics.setColor(63 / 255, 63 / 255, 63 / 255)
    love.graphics.rectangle('fill', 0, 0, gridXCount * cellSize, gridYCount * cellSize)

    local function drawCell(x, y)
        love.graphics.rectangle(
            'fill',
            (x - 1) * cellSize,
            (y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end

    for segmentIndex, segment in ipairs(snakeSegments) do
        if snakeAlive then
            love.graphics.setColor(95 / 255, 191 / 255, 95 / 255)
        else
            love.graphics.setColor(127 / 255, 127 / 255, 127 / 255)
        end
        drawCell(segment.x, segment.y)
    end

    love.graphics.setColor(191 / 255, 0 / 255, 0 / 255)
    drawCell(foodPos.x, foodPos.y)
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

function moveFood()
    local possibleFoodPos = {}

    for foodX = 1, gridXCount do
        for foodY = 1, gridYCount do
            local possible = true

            for segmentIndex, segment in ipairs(snakeSegments) do
                if foodX == segment.x and foodY == segment.y then
                    possible = false
                end
            end

            if possible then
                table.insert(possibleFoodPos, { x = foodX, y = foodY })
            end
        end
    end

    foodPos = possibleFoodPos[love.math.random(#possibleFoodPos)]
end

function reset()
    snakeSegments = {
        { x = 3, y = 1},
        { x = 2, y = 1},
        { x = 1, y = 1},
    }
    
    timer = 0
    directionQueue = { 'right' }
    snakeAlive = true
end