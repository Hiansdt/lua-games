-- Variables
local player = {}
local enemies = {}
local enemySpeed = 100
local bulletSpeed = 200
local bullets = {}
local timer = 0
score = 0
local killEffects = {}
local randomPosition1 = nil
local randomPosition2 = nil
local randomPosition3 = nil
local randomPosition4 = nil

-- Load assets and initialize variables
function love.load()
    -- Load assets (e.g., player and enemy images)

    -- Initialize player position
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2

    -- Create enemies
    for i = 1, 10 do
        local enemy = {}
        enemy.x = math.random(0, love.graphics.getWidth())
        enemy.y = math.random(0, love.graphics.getHeight())
        table.insert(enemies, enemy)
    end

end

-- Update game state
function love.update(dt)

    -- Timer

    timer = timer + dt

    local interval = 1

    -- Bullet creation

    if timer > interval then
        local bullet = {}
        bullet.x = player.x
        bullet.y = player.y
        table.insert(bullets, bullet)
        timer = timer - interval
    end

    -- Bullet movement

    for bulletIndex, bullet in ipairs(bullets) do
        bullet.x = bullet.x + bulletSpeed * -dt

        if bullet.x < 0 then
            table.remove(bullets, 1)
        end

        randomPosition1 = math.random(-100, 300)
        randomPosition2 = math.random(-100, 300)
        randomPosition3 = math.random(-100, 300)
        randomPosition4 = math.random(-100, 300)

        local bulletradius = 5
        local bulletCenterX = bullet.x + bulletradius
        local bulletCenterY = bullet.y + bulletradius

        for enemyIndex, enemy in ipairs(enemies) do

            local enemyRadius = 10
            local enemyCenterX = enemy.x + enemyRadius
            local enemyCenterY = enemy.y + enemyRadius

            local distanceSq = (enemyCenterX - bulletCenterX) ^ 2 + (enemyCenterY - bulletCenterY) ^ 2
            local radiusSumSq = (enemyRadius + bulletradius) ^ 2

            if distanceSq < radiusSumSq then
                table.remove(bullets, bulletIndex)
                local killEffect = {}
                killEffect.killEffect1 = {}
                killEffect.killEffect2 = {}
                killEffect.killEffect3 = {}
                killEffect.killEffect4 = {}
                killEffect.duration = 0.5

                killEffect.killEffect1.x = enemy.x + 10
                killEffect.killEffect1.y = enemy.y + 10
                killEffect.killEffect2.x = enemy.x - 10
                killEffect.killEffect2.y = enemy.y + 10
                killEffect.killEffect3.x = enemy.x - 10
                killEffect.killEffect3.y = enemy.y - 10
                killEffect.killEffect4.x = enemy.x + 10
                killEffect.killEffect4.y = enemy.y - 10
                table.insert(killEffects, killEffect)
                enemy.x = -20
                enemy.y = math.random(0, love.graphics.getHeight())
                score = score + 1
                if score % 10 == 0 then
                    enemySpeed = enemySpeed + 20
                end
                break
            end

        end

        for effectIndex, effect in ipairs(killEffects) do
            effect.duration = effect.duration - dt
            if effect.duration < 0 then
                table.remove(killEffects, effectIndex)
            end

            effect.killEffect1.x = effect.killEffect1.x + randomPosition1 * dt
            effect.killEffect1.y = effect.killEffect1.y + randomPosition1 * dt
            effect.killEffect2.x = effect.killEffect2.x - randomPosition2 * dt
            effect.killEffect2.y = effect.killEffect2.y + randomPosition2 * dt
            effect.killEffect3.x = effect.killEffect3.x - randomPosition3 * dt
            effect.killEffect3.y = effect.killEffect3.y - randomPosition3 * dt
            effect.killEffect4.x = effect.killEffect4.x + randomPosition4 * dt
            effect.killEffect4.y = effect.killEffect4.y - randomPosition4 * dt
        end

    end

    -- Player movement
    if love.keyboard.isDown("up") then
        player.y = player.y - 200 * dt
    elseif love.keyboard.isDown("down") then
        player.y = player.y + 200 * dt
    end

    if love.keyboard.isDown("left") then
        player.x = player.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        player.x = player.x + 200 * dt
    end

    -- Enemy movement
    for _, enemy in ipairs(enemies) do
        enemy.x = enemy.x + enemySpeed * dt
        if enemy.x > love.graphics.getWidth() then
            enemy.x = -20
            enemy.y = math.random(0, love.graphics.getHeight())
        end

        -- Collision check
        if CheckCollision(player.x, player.y, 20, 20, enemy.x, enemy.y, 20, 20) then
            -- Game over condition
            love.event.quit()
        end
    end
end

-- Draw game elements
function love.draw()
    -- Draw player

    love.graphics.setColor(1, 1, 1)

    love.graphics.print("Score: " .. score, 0, 0)

    love.graphics.rectangle("fill", player.x, player.y, 20, 20)
    -- Draw enemies
    love.graphics.setColor(1, 0, 0)

    for _, enemy in ipairs(enemies) do
        love.graphics.circle("fill", enemy.x, enemy.y, 10)
    end

    love.graphics.setColor(0, 150, 200)

    for _, bullet in ipairs(bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, 10, 5)
    end

    love.graphics.setColor(1, 1, 1)

    for _, effect in ipairs(killEffects) do
        love.graphics.circle("fill", effect.killEffect1.x, effect.killEffect1.y, 10)
        love.graphics.circle("fill", effect.killEffect2.x, effect.killEffect2.y, 10)
        love.graphics.circle("fill", effect.killEffect3.x, effect.killEffect3.y, 10)
        love.graphics.circle("fill", effect.killEffect4.x, effect.killEffect4.y, 10)
    end
end

-- Collision detection function
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end
