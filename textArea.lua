local myApp = require('myapp')


local textArea = {}



local creaArea = {}
local textListener = {}
local clearListener = {}



local campoInserimento
local sfondoInserimento
local btClear






function textArea:creaArea (opt)
    -- creazione textArea

    local gruppoInserimento = display.newGroup()

    -- sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    -- sfondoInserimento.x = _W*0.5
    -- sfondoInserimento.y = _H*0.70

    -- campoInserimento = native.newTextField( 40, 85, 195, 28)
    -- campoInserimento.x = _W/2
    -- campoInserimento.y = _H*0.70
    -- campoInserimento:setTextColor( 0.75,0.75,0.75 )
    -- campoInserimento.font = native.newFont( myApp.font, 17 )
    -- campoInserimento.align = "center"
    -- campoInserimento.hasBackground = false
    -- campoInserimento.placeholder = 'Username'

    -- btClear = display.newImage('img/delete.png', 10,10)
    -- btClear.x = _W*0.85
    -- btClear.y = _H*0.70
    -- btClear.alpha = 0

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = opt.sfondoInserimentoX
    sfondoInserimento.y = opt.sfondoInserimentoY

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = opt.sfondoInserimentoX
    campoInserimento.y = opt.sfondoInserimentoY
    campoInserimento:setTextColor( 0.75,0.75,0.75 )
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center" or opt.campoInserimentoAlign
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = opt.campoInserimentoPlaceHolder

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = opt.sfondoInserimentoY
    btClear.alpha = 0

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)


    campoInserimento:addEventListener( "userInput", textListener)
end








--gestisce le fasi dell'inserimento della targa
function textArea:textListener( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListener )
        end
        campoInserimento:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListener )
        else
            btClear.alpha = 0
            btClear:removeEventListener( "touch", clearListener )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClear.alpha = 0
            campoInserimento:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function textArea:clearListener( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimento.text = ''
        native.setKeyboardFocus( campoInserimento )
        btClear.alpha = 0
        btClear:removeEventListener( "touch", clearListener )
    end
end






return textArea