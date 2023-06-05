local player = {}
local floor = {}
local gravity = 100
local curQuad = nil
local walkSpriteTime = 0.075
local idleSpriteTime = 0.2
local jumpSpriteTime = 0.05
local attackSpriteTime = 0.15

local walkSpriteTimer = 0
local idleSpriteTimer = 0
local jumpSpriteTimer = 0
local attackSpriteTimer = 0

local attackSpriteAnimationTimer = 0
local idleSpriteAnimationTimer = 0

local notAttackingTimer = 0
local totalAttacks = 0
local currentAttack = 1
local AttacksDone = 0

function love.load()
    player.x = 0
    player.y = 0
    player.width = 128
    player.height = 128
    player.vx = 0
    player.vy = 0
    player.jumps = 0
    player.attacks = 0
    player.isIdle = true
    player.isJumping = false
    player.isAttacking4 = false
    player.isWalking = false
    player.blinkTimes = 0
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

    attackingSpriteSheet4 = love.graphics.newImage("Enchantress/Attack_4.png")
    attackingSpriteSheet3 = love.graphics.newImage("Enchantress/Attack_3.png")
    attackingSpriteSheet2 = love.graphics.newImage("Enchantress/Attack_2.png")
    attackingSpriteSheet1 = love.graphics.newImage("Enchantress/Attack_1.png")

    quad1Attacking4 = love.graphics.newQuad(0, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad2Attacking4 = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad3Attacking4 = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad4Attacking4 = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad5Attacking4 = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad6Attacking4 = love.graphics.newQuad(quadWidth * 5, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad7Attacking4 = love.graphics.newQuad(quadWidth * 6, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad8Attacking4 = love.graphics.newQuad(quadWidth * 7, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad9Attacking4 = love.graphics.newQuad(quadWidth * 8, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())
    quad10Attacking4 = love.graphics.newQuad(quadWidth * 9, 0, quadWidth, quadHeight, attackingSpriteSheet4:getDimensions())

    quad1Attacking3 = love.graphics.newQuad(0, 0, quadWidth, quadHeight, attackingSpriteSheet3:getDimensions())
    quad2Attacking3 = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, attackingSpriteSheet3:getDimensions())
    quad3Attacking3 = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, attackingSpriteSheet3:getDimensions())

    quad1Attacking2 = love.graphics.newQuad(0, 0, quadWidth, quadHeight, attackingSpriteSheet2:getDimensions())
    quad2Attacking2 = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, attackingSpriteSheet2:getDimensions())
    quad3Attacking2 = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, attackingSpriteSheet2:getDimensions())

    quad1Attacking1 = love.graphics.newQuad(0, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())
    quad2Attacking1 = love.graphics.newQuad(quadWidth, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())
    quad3Attacking1 = love.graphics.newQuad(quadWidth * 2, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())
    quad4Attacking1 = love.graphics.newQuad(quadWidth * 3, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())
    quad5Attacking1 = love.graphics.newQuad(quadWidth * 4, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())
    quad6Attacking1 = love.graphics.newQuad(quadWidth * 5, 0, quadWidth, quadHeight, attackingSpriteSheet1:getDimensions())

    curQuad = quad1Idle
end

function love.keypressed(key)
    if key == "up" and player.jumps < 2 then
        player.vy = -20
        player.jumps = player.jumps + 1
        curQuad = quad1Jump
        player.isIdle = false
        player.isJumping = true
    elseif key == "right" or key == "left" and not player.isJumping then
        curQuad = quad1Walk
        player.isIdle = false
        player.isAttacking = false
        player.isWalking = true
    elseif key == "down" then
        if currentAttack == 1 then
            curQuad = quad1Attacking1
        totalAttacks = totalAttacks + 1
        player.attacks = player.attacks + 1
        player.isIdle = false
        player.isAttacking = true
        end
    end
end

function love.update(dt)

    if player.isIdle then
        idleSpriteTimer = idleSpriteTimer + dt
        idleSpriteAnimationTimer = idleSpriteAnimationTimer + dt
        if idleSpriteTimer > idleSpriteTime and idleSpriteAnimationTimer > 3 and player.blinkTimes < 1 then
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
                player.blinkTimes = player.blinkTimes + 1
            end
            idleSpriteTimer = idleSpriteTimer - idleSpriteTime
        end
    end

    if idleSpriteAnimationTimer > 5 then
        idleSpriteAnimationTimer = 0
        player.blinkTimes = 0
    end

    if love.keyboard.isDown("right") and player.isWalking then
        player.vx = 200
        player.x = player.x + player.vx * dt
        walkSpriteTimer = walkSpriteTimer + dt
        player.isIdle = false
        player.isAttacking = false
        currentAttack = 1
        AttacksDone = 0
        totalAttacks = 0
        player.isWalking = true
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
        player.isAttacking = false
        currentAttack = 1
        AttacksDone = 0
        totalAttacks = 0
        player.isWalking = true
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
            if curQuad == quad1Attacking1 then
                currentAttack = 1
                curQuad = quad2Attacking1
            elseif curQuad == quad2Attacking1 then
                curQuad = quad3Attacking1
            elseif curQuad == quad3Attacking1 then
                curQuad = quad4Attacking1
            elseif curQuad == quad4Attacking1 then
                curQuad = quad5Attacking1
            elseif curQuad == quad5Attacking1 then
                curQuad = quad6Attacking1
                AttacksDone = AttacksDone + 1
            elseif curQuad == quad6Attacking1 and totalAttacks == 1 then
                player.isAttacking = false
                player.isIdle = true
                curQuad = quad1Idle
                totalAttacks = 0
                currentAttack = 1
                AttacksDone = 0
            elseif curQuad == quad6Attacking1 and totalAttacks > 1 then
                currentAttack = 2
                curQuad = quad1Attacking2
            elseif curQuad == quad1Attacking2 then
                curQuad = quad2Attacking2
            elseif curQuad == quad2Attacking2 then
                curQuad = quad3Attacking2
                AttacksDone = AttacksDone + 1
            elseif curQuad == quad3Attacking2 and totalAttacks <= 2 then
                player.isAttacking = false
                player.isIdle = true
                curQuad = quad1Idle
                totalAttacks = 0
                currentAttack = 1
                AttacksDone = 0
            elseif curQuad == quad3Attacking2 and totalAttacks > 2 then
                currentAttack = 3
                curQuad = quad1Attacking3
            elseif curQuad == quad1Attacking3 then
                curQuad = quad2Attacking3
            elseif curQuad == quad2Attacking3 then
                curQuad = quad3Attacking3
                AttacksDone = AttacksDone + 1
            elseif curQuad == quad3Attacking3 and totalAttacks <= 3 then
                player.isAttacking = false
                player.isIdle = true
                curQuad = quad1Idle
                totalAttacks = 0
                currentAttack = 1
                AttacksDone = 0
            elseif curQuad == quad3Attacking3 and totalAttacks > 3 then
                currentAttack = 4
                curQuad = quad1Attacking4
            elseif curQuad == quad1Attacking4 then
                curQuad = quad2Attacking4
            elseif curQuad == quad2Attacking4 then
                curQuad = quad3Attacking4
            elseif curQuad == quad3Attacking4 then
                curQuad = quad4Attacking4
            elseif curQuad == quad4Attacking4 then
                curQuad = quad5Attacking4
            elseif curQuad == quad5Attacking4 then
                curQuad = quad6Attacking4
            elseif curQuad == quad6Attacking4 then
                curQuad = quad7Attacking4
            elseif curQuad == quad7Attacking4 then
                curQuad = quad8Attacking4
            elseif curQuad == quad8Attacking4 then
                curQuad = quad9Attacking4
            elseif curQuad == quad9Attacking4 then
                curQuad = quad10Attacking4
                AttacksDone = AttacksDone + 1
            elseif curQuad == quad10Attacking4 and totalAttacks <= 4 then
                player.isAttacking = false
                player.isIdle = true
                curQuad = quad1Idle
                totalAttacks = 0
                currentAttack = 1
                AttacksDone = 0
            else
                currentAttack = 1
                curQuad = quad1Attacking1
            end
            if AttacksDone == totalAttacks then
                player.isAttacking = false
                player.isIdle = true
                curQuad = quad1Idle
                totalAttacks = 0
                currentAttack = 1
                AttacksDone = 0
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
        if currentAttack == 1 then
            love.graphics.draw(attackingSpriteSheet1, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
        elseif currentAttack == 2 then
            love.graphics.draw(attackingSpriteSheet2, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
        elseif currentAttack == 3 then
            love.graphics.draw(attackingSpriteSheet3, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
        elseif currentAttack == 4 then
            love.graphics.draw(attackingSpriteSheet4, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
        end
    elseif player.isWalking then
        love.graphics.draw(walkingSpriteSheet, curQuad, player.x, player.y, 0, 1, 1, 0, 0)
    end

    -- Convert hex color code to RGB values
    local hexColor = "#FF0000" -- Red color
    local r, g, b = hexToRGB('#4dd640')

    -- Set color using RGB values
    love.graphics.setColor(r, g, b)

    love.graphics.rectangle("fill", floor.x, floor.y, floor.width, floor.height)

    love.graphics.setColor(0, 0, 0)

    if player.isIdle then
        love.graphics.print("Idle", 0, 0)
    else
        love.graphics.print("Not Idle", 0, 0)
    end

    love.graphics.print("Attacks Done: " .. AttacksDone, 0, 20)
    love.graphics.print("Total Attacks: " .. totalAttacks, 0, 40)
    love.graphics.print("Current Attack: " .. currentAttack, 0, 60)
    love.graphics.print("Attack Sprite Timer: " .. attackSpriteTimer, 0, 80)
    love.graphics.print("Attack Sprite Time: " .. attackSpriteTime, 0, 100)
    love.graphics.print("Idle sprite animation timer: " .. idleSpriteTimer, 0, 120)
    love.graphics.print("Idle sprite animation time: " .. idleSpriteTime, 0, 140)
end
