larguraTela = love.graphics.getWidth()
alturaTela = love.graphics.getHeight()

function love.load()
    imgTank = love.graphics.newImage( "imagens/game.png" )
    love.mouse.setVisible( false )

    nave = {
        posX = larguraTela / 2,
        posY = alturaTela / 2,
        velocidade = 200
    }
    end

function love.update(dt)
    if love.keyboard.isDown("left") then
        if nave.posX > (0 + imgTank:getWidth()/2)then
            nave.posX = nave.posX - nave.velocidade * dt
        end
        
    end
    
    if love.keyboard.isDown("right") then
        if nave.posX < (larguraTela - imgTank:getWidth()/2) then
            nave.posX = nave.posX + nave.velocidade * dt
        end 
    end

    if love.keyboard.isDown("up") then
        nave.posY = nave.posY - nave.velocidade * dt
    end

    if love.keyboard.isDown("down") then
        nave.posY = nave.posY + nave.velocidade * dt
    end



end

function love.draw()
    rot = angulo
    love.graphics.draw(imgTank, nave.posX, nave.posY, 0, 1, 1, imgTank:getWidth()/2, imgTank:getHeight()/2)
end