larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()

function love.load()
    imgTank = love.graphics.newImage( "imagens/tank.png" )
    love.mouse.setVisible( false )

    tank = {
        posX = larguraTela / 2,
        posY = alturaTela / 2,
        velocidade = 200
    }
    end

function love.update(dt)
    move(dt)
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
    rot = angulo
    love.graphics.draw(imgTank, tank.posX, tank.posY, 0, 1, 1, imgTank:getWidth()/2, imgTank:getHeight()/2)
end