larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()

function love.load()
    imgTank = love.graphics.newImage( "imagens/tank.png" )
    love.mouse.setVisible( false )
    atira = true
    delayT = 0.1
    timeTiro = delayT
    tiros = {}
    imgTiro = love.graphics.newImage("imagens/bala.png")
    

    tank = {
        posX = larguraTela / 2,
        posY = alturaTela / 2,
        velocidade = 200
    }
    end

function love.update(dt)
    move(dt)
    atirar(dt)
end

function atirar(dt)
    
    timeTiro = timeTiro - (1 * dt)

    if timeTiro < 0 then 
        atira = true
    end

    if love.keyboard.isDown("space") and atira then
        newtiro = {x = tank.posX, y = tank.posY, img = imgTiro}
        table.insert(tiros, newtiro)
        atira = false
        timeTiro =  delayT
    end

    for i, tiro in ipairs(tiros) do
        tiro.y = tiro.y - (500 * dt)
        if tiro.y < 0 then
            table.remove(tiros, i)
        end
    end

end

function move(dt)
    if love.keyboard.isDown("left") then
        if tank.posX > (0 + imgTank:getWidth()/2)then
            tank.posX = tank.posX - tank.velocidade * dt
        end
        
    end
    
    if love.keyboard.isDown("right") then
        if tank.posX < (larguraTela - imgTank:getWidth()/2) then
            tank.posX = tank.posX + tank.velocidade * dt
        end 
    end

    if love.keyboard.isDown("up") then
        tank.posY = tank.posY - tank.velocidade * dt
    end

    if love.keyboard.isDown("down") then
        tank.posY = tank.posY + tank.velocidade * dt
    end


end
function love.draw()
    love.graphics.draw(imgTank, tank.posX, tank.posY, 0, 1, 1, imgTank:getWidth()/2, imgTank:getHeight()/2)
    
    for i, tiro in ipairs(tiros) do
        love.graphics.draw(tiro.img, tiro.x, tiro.y, 0, 1, 1, imgTiro:getWidth()/2, imgTiro:getHeight()/2)
    end
end