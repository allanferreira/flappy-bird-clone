--[[
                                                       
                                    ______ _                           ____  _         _        _                  
                                    |  ____| |                         |  _ \(_)       | |      | |                 
                                    | |__  | | __ _ _ __  _ __  _   _  | |_) |_ _ __ __| |   ___| | ___  _ __   ___ 
                                    |  __| | |/ _` | '_ \| '_ \| | | | |  _ <| | '__/ _` |  / __| |/ _ \| '_ \ / _ \
                                    | |    | | (_| | |_) | |_) | |_| | | |_) | | | | (_| | | (__| | (_) | | | |  __/
                                    |_|    |_|\__,_| .__/| .__/ \__, | |____/|_|_|  \__,_|  \___|_|\___/|_| |_|\___|
                                                    | |   | |     __/ |                                              
                                                    |_|   |_|    |___/                                               



                                                        @Author:        Eoussama
                                                        @Version:       v0.2.0
                                                        @Created on:    4/15/2018 - 9:26PM
]]
local Menu = {}
local Game = require("modules.game")

function Menu.showMainMenu()
    Game.paused = false
    Game.lost = false
    Game.getstarted.state = false
    Game.getstarted.time = 3
    Game.sounds.played = false
    Game.switchSprites('active')
    Game.bird.activeFrame = 1
    Game.bird.posX = love.graphics.getWidth() / 2
    Game.bird.posY = love.graphics.getHeight() / 2.6
    Game.floor.floorX = 0.0

    Game.physicsWorld = love.physics.newWorld(0, 9.81*64, true)
    Game.floor.physics.world = Game.physicsWorld
    Game.floor.physics.body = love.physics.newBody(Game.floor.physics.world, love.graphics:getWidth() / 2, love.graphics:getHeight(), 'static')
    Game.floor.physics.shape = love.physics.newRectangleShape(Game.floor.current:getWidth(), 210)
    Game.floor.physics.fixture = love.physics.newFixture(Game.floor.physics.body, Game.floor.physics.shape, 1)

    Game.ceilling.physics.world = Game.physicsWorld
    Game.ceilling.physics.body = love.physics.newBody(Game.ceilling.physics.world, love.graphics:getWidth() / 2, 0, 'static')
    Game.ceilling.physics.shape = love.physics.newRectangleShape(love.graphics:getWidth(), 50)
    Game.ceilling.physics.fixture = love.physics.newFixture(Game.ceilling.physics.body, Game.ceilling.physics.shape, 1)

    Game.bird.physics.world = Game.physicsWorld
    Game.bird.physics.body = love.physics.newBody(Game.bird.physics.world, Game.bird.posX, Game.bird.posY, 'dynamic')
    Game.bird.physics.shape = love.physics.newCircleShape(50)
    Game.bird.physics.fixture = love.physics.newFixture(Game.bird.physics.body, Game.bird.physics.shape, 1)
    Game.bird.physics.fixture:setRestitution(0.3)
    Game.bird.physics.body:setX(Game.bird.posX)
    Game.bird.physics.body:setY(Game.bird.posY)

    Game.draw()
    love.graphics.draw(Game.sprites.current, Game.title, love.graphics.getWidth() / 2, love.graphics.getHeight() / 5, 0, 0.4, 0.4, ({Game.title:getViewport()})[3] / 2, ({Game.title:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.current, Game.buttons.play, love.graphics.getWidth() / 4, 2.7 * love.graphics.getHeight() / 4, 0, 0.35, 0.35, ({Game.buttons.play:getViewport()})[3] / 2, ({Game.buttons.play:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.current, Game.buttons.board, 3 * love.graphics.getWidth() / 4, 2.7 * love.graphics.getHeight() / 4, 0, 0.35, 0.35, ({Game.buttons.board:getViewport()})[3] / 2, ({Game.buttons.board:getViewport()})[4] / 2)
end

function Menu.showPauseMenu()
    love.graphics.draw(Game.sprites.active, Game.buttons.tap, love.graphics.getWidth() / 2, 1.8 * love.graphics.getHeight() / 3, 0, 0.5, 0.5, ({Game.buttons.tap:getViewport()})[3] / 2, ({Game.buttons.tap:getViewport()})[4] / 2)
end

function Menu.showGetStartedMenu()
    local activeNumber = math.floor(Game.getstarted.time + 1)

    love.graphics.draw(Game.sprites.active, Game.numbers[activeNumber], love.graphics:getWidth() / 2, 200, 0, 0.4, 0.4, ({Game.numbers[activeNumber]:getViewport()})[3] / 2, ({Game.numbers[activeNumber]:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.active, Game.caption, love.graphics.getWidth() / 2, love.graphics.getHeight() / 5, 0, 0.4, 0.4, ({Game.title:getViewport()})[3] / 2, ({Game.title:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.active, Game.buttons.tap, love.graphics.getWidth() / 2, 1.8 * love.graphics.getHeight() / 3, 0, 0.5, 0.5, ({Game.buttons.tap:getViewport()})[3] / 2, ({Game.buttons.tap:getViewport()})[4] / 2)
end

function Menu.showLossMenu()
    Game.lost = true
    if Game.sounds.played == false then Game.sounds.lost:play() Game.sounds.played = true end
    
    love.graphics.draw(Game.sprites.active, Game.gameOver, love.graphics.getWidth() / 2, love.graphics.getHeight() / 5, 0, 0.4, 0.4, ({Game.title:getViewport()})[3] / 2, ({Game.title:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.active, Game.scoreBoard, love.graphics.getWidth() / 2, love.graphics.getHeight() / 3, 0, 0.4, 0.4, ({Game.gameOver:getViewport()})[3] / 2, ({Game.gameOver:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.current, Game.buttons.play, love.graphics.getWidth() / 4, 2.7 * love.graphics.getHeight() / 4, 0, 0.35, 0.35, ({Game.buttons.play:getViewport()})[3] / 2, ({Game.buttons.play:getViewport()})[4] / 2)
    love.graphics.draw(Game.sprites.current, Game.buttons.board, 3 * love.graphics.getWidth() / 4, 2.7 * love.graphics.getHeight() / 4, 0, 0.35, 0.35, ({Game.buttons.board:getViewport()})[3] / 2, ({Game.buttons.board:getViewport()})[4] / 2)
end


return Menu