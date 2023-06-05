local player = {}
local floor = {}
local gravity = 100
local curQuad = nil
local walkSpriteTime = 0.075
local idleSpriteTime = 0.2
local jumpSpriteTime = 0.05
local attackSpriteTime = 0.05

local walkSpriteTimer = 0
local idleSpriteTimer = 0
local jumpSpriteTimer = 0
local attackSpriteTimer = 0

local attackSpriteAnimationTimer = 0

function love.load()
    player.x = 0
    player.y = 0
    player.width = 128
    player.height = 128
    player.vx = 0
    player.vy = 0
    player.jumps = 0
    player.isIdle = true
    player.isJumping = false
    player.isAttacking = false
    player.isWalking = false
    floor.x = 0
    floor.y = 500
    floor.width = love.graphics.getWidth()
    floor.height = love.graphics.getHeight() - floor.y

    background = love.graphics.newImage("background.png")

    walkingSpriteSheet = love.graphics.newImage("Enchantress/Walk.png")
    idleSpriteSheet = love.graphics.newImage("Enchantress/Idle.png")
    jumpSpriteSheet = love.graphics.newImage("Enchantress/Jump.png")

    quadWidth = 128
    quadHeight = 128

    quad1Walk = love.graphics.newQuad(0, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad2Walk = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad3Walk = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad4Walk = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad5Walk = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad6Walk = love.graphics.newQuad(quadWidth * 5, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad7Walk = love.graphics.newQuad(quadWidth * 6, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())
    quad8Walk = love.graphics.newQuad(quadWidth * 7, 0, quadWidth, quadHeight, walkingSpriteSheet:getDimensions())

    quad1Idle = love.graphics.newQuad(0, 0, quadWidth, quadHeight, idleSpriteSheet:getDimensions())
    quad2Idle = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, idleSpriteSheet:getDimensions())
    quad3Idle = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, idleSpriteSheet:getDimensions())
    quad4Idle = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, idleSpriteSheet:getDimensions())
    quad5Idle = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, idleSpriteSheet:getDimensions())

    quad1Jump = love.graphics.newQuad(0, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad2Jump = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad3Jump = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad4Jump = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad5Jump = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad6Jump = love.graphics.newQuad(quadWidth * 5, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad7Jump = love.graphics.newQuad(quadWidth * 6, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())
    quad8Jump = love.graphics.newQuad(quadWidth * 7, 0, quadWidth, quadHeight, jumpSpriteSheet:getDimensions())

    attackingSpriteSheet = love.graphics.newImage("Enchantress/Attack_4.png")

    quad1Attacking = love.graphics.newQuad(0, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad2Attacking = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad3Attacking = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad4Attacking = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad5Attacking = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad6Attacking = love.graphics.newQuad(quadWidth * 5, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad7Attacking = love.graphics.newQuad(quadWidth * 6, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad8Attacking = love.graphics.newQuad(quadWidth * 7, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad9Attacking = love.graphics.newQuad(quadWidth * 8, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())
    quad10Attacking = love.graphics.newQuad(quadWidth * 9, 0, quadWidth, quadHeight, attackingSpriteSheet:getDimensions())

    curQuad = quad1Idle
end

function love.keypressed(key)
    if key == "up" and player.jumps < 2 then
        player.vy = -20
        player.jumps = player.jumps + 1
        curQuad = quad1Jump
        player.isJumping = true
    elseif key == "right" or key == "left" and not player.isJumping then
        curQuad = quad1Walk
        player.isIdle = false
        player.isAttacking = false
        player.isWalking = true
    elseif key == "down" then
        curQuad = quad1Attacking
        player.isIdle = false
        player.isAttacking = true
    end
end

function love.update(dt)

    if player.isIdle then
        idleSpriteTimer = idleSpriteTimer + dt
        if idleSpriteTimer > idleSpriteTime then
            if curQuad == quad1Idle then
                curQuad = quad2Idle
            elseif curQuad == quad2Idle then
                curQuad = quad3Idle
            elseif curQuad == quad3Idle then
                curQuad = quad4Idle
            elseif curQuad == quad4Idle then
                curQuad = quad5Idle
            elseif curQuad == quad5Idle then
                curQuad = quad1Idle
            elseif curQuad then
                curQuad = quad1Idle
            end
            idleSpriteTimer = idleSpriteTimer - idleSpriteTime
        end
    end

    if love.keyboard.isDown("right") and player.isWalking then
        player.vx = 200
        player.x = player.x + player.vx * dt
        walkSpriteTimer = walkSpriteTimer + dt
        player.isIdle = false
        if walkSpriteTimer > walkSpriteTime and not player.isIdle then
            if curQuad == quad1Walk then
                curQuad = quad2Walk
            elseif curQuad == quad2Walk then
                curQuad = quad3Walk
            elseif curQuad == quad3Walk then
                curQuad = quad4Walk
            elseif curQuad == quad4Walk then
                curQuad = quad5Walk
            elseif curQuad == quad5Walk then
                curQuad = quad6Walk
            elseif curQuad == quad6Walk then
                curQuad = quad7Walk
            elseif curQuad == quad7Walk then
                curQuad = quad8Walk
            elseif curQuad == quad8Walk then
                curQuad = quad1Walk
            end
            walkSpriteTimer = walkSpriteTimer - walkSpriteTime
        end
    end

    if love.keyboard.isDown("left") and player.isWalking then
        player.vx = -200
        player.x = player.x + player.vx * dt
        player.vx = 0
        player.isIdle = false
        walkSpriteTimer = walkSpriteTimer + dt
        if walkSpriteTimer > walkSpriteTime and not player.isIdle then
            if curQuad == quad1Walk then
                curQuad = quad8Walk
            elseif curQuad == quad8Walk then
                curQuad = quad7Walk
            elseif curQuad == quad7Walk then
                curQuad = quad6Walk
            elseif curQuad == quad6Walk then
                curQuad = quad5Walk
            elseif curQuad == quad5Walk then
                curQuad = quad4Walk
            elseif curQuad == quad4Walk then
                curQuad = quad3Walk
            elseif curQuad == quad3Walk then
                curQuad = quad2Walk
            elseif curQuad == quad2Walk then
                curQuad = quad1Walk
            end
            walkSpriteTimer = walkSpriteTimer - walkSpriteTime
        end
    end

    if player.isJumping then
        jumpSpriteTimer = jumpSpriteTimer + dt
        if jumpSpriteTimer > jumpSpriteTime then
            if curQuad == quad1Jump then
                curQuad = quad2Jump
            elseif curQuad == quad2Jump then
                curQuad = quad3Jump
            elseif curQuad == quad3Jump then
                curQuad = quad4Jump
            elseif curQuad == quad4Jump then
                curQuad = quad5Jump
            elseif curQuad == quad5Jump then
                curQuad = quad6Jump
            elseif curQuad == quad6Jump then
                curQuad = quad7Jump
            elseif curQuad == quad7Jump then
                curQuad = quad8Jump
            elseif curQuad == quad8Jump then
                curQuad = quad1Jump
            end
            jumpSpriteTimer = jumpSpriteTimer - jumpSpriteTime
        end
    end

    if player.isIdle == false and not love.keyboard.isDown("right") and not love.keyboard.isDown("left") and not player.isJumping and not player.isAttacking then
        player.isIdle = true
        curQuad = quad1Idle
    end

    if player.isAttacking then
        attackSpriteAnimationTimer = attackSpriteAnimationTimer + dt
        attackSpriteTimer = attackSpriteTimer + dt
        if attackSpriteTimer > attackSpriteTime then
            if curQuad == quad1Attacking then
                curQuad = quad2Attacking
            elseif curQuad == quad2Attacking then
                curQuad = quad3Attacking
            elseif curQuad == quad3Attacking then
                curQuad = quad4Attacking
            elseif curQuad == quad4Attacking then
                curQuad = quad5Attacking
            elseif curQuad == quad5Attacking then
                curQuad = quad6Attacking
            elseif curQuad == quad6Attacking then
                curQuad = quad7Attacking
            elseif curQuad == quad7Attacking then
                curQuad = quad8Attacking
            elseif curQuad == quad8Attacking then
                curQuad = quad9Attacking
            elseif curQuad == quad9Attacking then
                curQuad = quad10Attacking
            elseif curQuad == quad10Attacking then
                curQuad = quad1Idle
            end
            if attackSpriteAnimationTimer > attackSpriteTime * 10 then
                player.isAttacking = false
                player.isIdle = true
                attackSpriteAnimationTimer = 0
                curQuad = quad1Idle
            end
            attackSpriteTimer = attackSpriteTimer - attackSpriteTime
        end
    end

    player.vy = player.vy + gravity * dt

    player.y = player.y + player.vy

    if player.y > floor.y - player.height then
        player.y = floor.y - player.height
        player.vy = 0
        player.jumps = 0
        player.isJumping = false
    end

end

function hexToRGB(hex)
    hex = hex:gsub("#", "") -- Remove the '#' character from the hex code
    local r = tonumber(hex:sub(1, 2), 16) / 255 -- Extract the red component
    local g = tonumber(hex:sub(3, 4), 16) / 255 -- Extract the green component
    local b = tonumber(hex:sub(5, 6), 16) / 255 -- Extract the blue component
    return r, g, b
end

function love.draw()
    love.graphics.setColor(255, 255, 255)

    local scaleX = love.graphics.getWidth() / background:getWidth()
    local scaleY = love.graphics.getHeight() / background:getHeight()

    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)

    if player.isIdle then
        love.graphics.draw(idleSpriteSheet, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
    elseif player.isJumping then
        love.graphics.draw(jumpSpriteSheet, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
    elseif player.isAttacking then
        love.graphics.draw(attackingSpriteSheet, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
    elseif player.isWalking then
        love.graphics.draw(walkingSpriteSheet, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
    end

    -- Convert hex color code to RGB values
    local hexColor = "#FF0000" -- Red color
    local r, g, b = hexToRGB('#4dd640')

    -- Set color using RGB values
    love.graphics.setColor(r, g, b)

    love.graphics.rectangle("fill", floor.x, floor.y, floor.width, floor.height)

    if player.isAttacking then
        love.graphics.print("Jumping", 0, 0)
    else
        love.graphics.print("Not Jumping", 0, 0)
    end
end
