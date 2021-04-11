local score = 0
local playerImage
local distance 
local randomGenerator
local speed = 60
local gameover = 0
local dirX 
local dirY
local playerposX = 275
local playerposY = 275
local scoreSound

local gameName = {
    {character = "C", characterPosX = 10, colorRed = 0, colorGreen = 1, colorBlue = 1},
    {character = "o", characterPosX = 50, colorRed = 0.1, colorGreen = 0.9, colorBlue = 0.9},
    {character = "l", characterPosX = 90, colorRed = 0.2, colorGreen = 0.8, colorBlue = 0.8},
    {character = "o", characterPosX = 110, colorRed = 0.3, colorGreen = 0.7, colorBlue = 0.7},
    {character = "r", characterPosX = 145, colorRed = 0.4, colorGreen = 0.6, colorBlue = 0.6},
    {character = "C", characterPosX = 175, colorRed = 0.5, colorGreen = 0.5, colorBlue = 0.5},
    {character = "h", characterPosX = 215, colorRed = 0.6, colorGreen = 0.4, colorBlue = 0.4},
    {character = "a", characterPosX = 255, colorRed = 0.7, colorGreen = 0.3, colorBlue = 0.3},
    {character = "s", characterPosX = 295, colorRed = 0.8, colorGreen = 0.2, colorBlue = 0.2},
    {character = "e", characterPosX = 335, colorRed = 0.9, colorGreen = 0.1, colorBlue = 0.1},
    {character = "r", characterPosX = 375, colorRed = 1, colorGreen = 0, colorBlue = 0},
}

local targets = {
    { targetPosX = 100, targetPosY = 175, colorRed = 0, colorGreen = 1, colorBlue = 1},
    { targetPosX = 100, targetPosY = 400, colorRed = 0, colorGreen = 1, colorBlue = 1},
    { targetPosX = 475, targetPosY = 175, colorRed = 0, colorGreen = 1, colorBlue = 1},
    { targetPosX = 475, targetPosY = 420, colorRed = 0, colorGreen = 1, colorBlue = 1},
    { targetPosX = 275, targetPosY = 200, colorRed = 0, colorGreen = 1, colorBlue = 1},
}

function love.load() 
 randomGenerator = love.math.newRandomGenerator()
playerImage = love.graphics.newImage("stickmanR.png")
scoreSound = love.audio.newSource("score.wav", "static")
end

function love.draw()
    local position = 1
    for i = 1, 11, 1 do
        love.graphics.setColor(gameName[i].colorRed,gameName[i].colorGreen,gameName[i].colorBlue) 
        love.graphics.print(gameName[i].character, gameName[i].characterPosX, 25, 0, 5, 5)
    end
    love.graphics.setColor( 1, 1, 1)
    love.graphics.print("Score: " .. score, 20, 525, 0, 2, 2)
    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle("line", 5, 105, 590, 390)
    if gameover == 1 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("GameOver", 50, 200, 0, 8, 8)  
    else
        love.graphics.draw(playerImage, playerposX, playerposY)
        for i = 1, 5, 1 do 
            love.graphics.setColor(targets[i].colorRed, targets[i].colorGreen, targets[i].colorBlue) 
            love.graphics.circle("fill", targets[i].targetPosX, targets[i].targetPosY, 12)
        end

    end

end

function love.keypressed(key, scancode, isrepeat) 
    if key == "right" then 
        dirX = 1
        dirY = 0
    elseif key == "left" then
        dirX = -1
        dirY = 0
    elseif key == "down" then 
        dirX = 0
        dirY = 1
    elseif key == "up" then
        dirX = 0
        dirY = -1
    end
end

 function love.update(dt)
    if playerposX < 560 and dirX == 1 then
        playerposX = playerposX + speed * dt
   elseif playerposX > 560 and dirX == 1 then
    playerposX = playerposX - speed * dt
       gameover = 1
   elseif playerposX > 10 and dirX == -1 then
    playerposX = playerposX - speed * dt
   elseif playerposX < 10 and dirX == -1 then 
    playerposX = playerposX + speed * dt
       gameover = 1
   end 
   if playerposY < 445 and dirY == 1 then
    playerposY = playerposY + speed * dt
    elseif playerposY > 445 and dirY == 1 then
        playerposY = playerposY - speed * dt
        gameover = 1
    elseif playerposY > 105 and dirY == -1 then
        playerposY = playerposY - speed * dt
    elseif playerposY < 105 and dirY == -1 then 
        playerposY = playerposY + speed * dt
        gameover = 1
    end
    
    for i = 1, 5, 1 do 
        distance = ((playerposX - targets[i].targetPosX)^2 + (playerposY - targets[i].targetPosY)^2)^0.5
        targets[i].colorRed = targets[i].colorRed + 0.001
        targets[i].colorGreen = targets[i].colorGreen - 0.001
        targets[i].colorBlue = targets[i].colorBlue - 0.001
        
        if distance < 30 then 
            score = score + 10 * targets[i].colorRed 
            love.audio.stop( )
            love.audio.play(scoreSound)
            targets[i].targetPosX = randomGenerator:random(25, 575)
            targets[i].targetPosY = randomGenerator:random(125, 450)
            speed = speed + 10
            targets[i].colorRed = 0
            targets[i].colorGreen = 1
            targets[i].colorBlue = 1
        else if targets[i].colorRed > 1 then 
            targets[i].targetPosX = randomGenerator:random(25, 575)
            targets[i].targetPosY = randomGenerator:random(125, 450)
            targets[i].colorRed = 0
            targets[i].colorGreen = 1
            targets[i].colorBlue = 1
        end
    end 

    for i = 1, 11 , 1 do 
        if gameName[i].colorRed > 1 then
            gameName[i].colorRed = 0
            gameName[i].colorGreen = 1
            gameName[i].colorBlue = 1
        else 
            gameName[i].colorRed = gameName[i].colorRed + 0.001
            gameName[i].colorGreen = gameName[i].colorGreen - 0.001
            gameName[i].colorBlue = gameName[i].colorBlue - 0.001
        end 
    end
            
end


end 