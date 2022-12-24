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
    
    delayInimigo = 0.4
    tempoCriaInimigo = delayInimigo
    imgInimmigo = love.graphics.newImage("imagens/inimigo.png")
    inimigos= {}

    estaVivo = true
    pontuacao = 0


    tank = {
        posX = larguraTela / 2,
        posY = alturaTela / 2,
        velocidade = 200
    }
end


function love.update(dt)
    move(dt)
    atirar(dt)
    inimigo(dt)
    colisoes()

    if not estaVivo and love.keyboard.isDown('r') then
    tiros = {}
    inimigos = {}

    atira = timeTiro
    tempoCriaInimigo = delayInimigo

    tank.posX = larguraTela / 2
    tank.posY = alturaTela / 2

    pontuacao = 0
    estaVivo = true

    end

end

function atirar(dt)
    
    timeTiro = timeTiro - (1 * dt)

    if timeTiro < 0 then 
        atira = true
    end
    
    if estaVivo then
        if love.keyboard.isDown("space") and atira then
            newtiro = {x = tank.posX, y = tank.posY, img = imgTiro}
            table.insert(tiros, newtiro)
            atira = false
            timeTiro =  delayT
        end
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

function inimigo(dt)
    tempoCriaInimigo = tempoCriaInimigo - (1 * dt)
    if tempoCriaInimigo < 0 then
        tempoCriaInimigo = delayInimigo
        numAleatorio = math.random(10, love.graphics.getWidth() - ((imgInimmigo:getWidth() / 2 ) + 10))
        novoInimigo = { x = numAleatorio, y = - imgInimmigo:getWidth(), img = imgInimmigo}
        table.insert(inimigos, novoInimigo)
    end

    for i, inimigo in ipairs(inimigos) do 
        inimigo.y = inimigo.y + (200 * dt)
        if inimigo.y > 850 then
            table.remove(inimigos, i)
        end
    end
end

function colisoes()
    for i, inimigo in ipairs(inimigos) do
        for j, tiro in ipairs(tiros) do
            if saberColisao(inimigo.x, inimigo.y, imgInimmigo:getWidth(), imgInimmigo:getHeight(), tiro.x, tiro.y, imgTiro:getWidth(), imgTiro:getHeight()) then
            table.remove(tiros, j)
            table.remove(inimigos, i)
            pontuacao = pontuacao + 1
            end
        end
        if saberColisao(inimigo.x, inimigo.y, imgInimmigo:getWidth(), imgInimmigo:getHeight(), tank.posX - (imgTank:getWidth()/2), tank.posY, imgTank:getWidth(), imgTank:getHeight()) and estaVivo then
            table.remove(inimigos, i)
            estaVivo = false
        end
        
    end

end

function saberColisao(x1, y1, w1, h1, x2,y2,w2,h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function love.draw()
  
    
    for i, tiro in ipairs(tiros) do
        love.graphics.draw(tiro.img, tiro.x, tiro.y, 0, 1, 1, imgTiro:getWidth()/2, imgTiro:getHeight()/2)
    end

    for i, inimigo in ipairs(inimigos) do 
        love.graphics.draw(inimigo.img, inimigo.x, inimigo.y)
    end

    if estaVivo then
        love.graphics.draw(imgTank, tank.posX, tank.posY, 0, 1, 1, imgTank:getWidth()/2, imgTank:getHeight()/2)
    else
        love.graphics.print("Pressione a tecla R para reiniciar.", larguraTela / 3, alturaTela / 2)
    end
    
end