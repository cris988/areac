local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local AvantiScene = {}
local selezionaTarga = {}
local textListener = {}
local clearListener = {}
local trimString = {}

-- variabili
local avanti
local targaReg
local titleText
local campoInserimento
local sfondoInserimento
local btClear


local string = "Da qui puoi acquistare un ticket giornaliero o multiplo per il tuo veicolo"


local function ignoreTouch( event )
	return true
end


function scene:createScene(event)

    print("CREA SCENA ACQUISTA")

	local group = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = AvantiScene
    })
    group:insert(avanti)
    

    -- testo in alto
    local options = {
        text = string,
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local text1 = display.newText( options )
    text1:setFillColor( 0, 0, 0 )
    group:insert(text1)


    -- creazione textArea per targa

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = _W*0.5
    sfondoInserimento.y = _H*0.5

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = _W/2
    campoInserimento.y = _H*0.5
    campoInserimento:setTextColor( 0.75,0.75,0.75 )
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center"
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = 'Targa'

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = _H*0.5
    btClear.alpha = 0


    if myApp.targaAcquista == nil then
    else 
        campoInserimento.text = myApp.targaAcquista
        campoInserimento:setTextColor( 0 )
        btClear.alpha = 0.2
        btClear:addEventListener( "touch", clearListener )
    end

    campoInserimento:addEventListener( "userInput", textListener)

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    group:insert(gruppoInserimento)
    




    if myApp.utenteLoggato > 0 then
        
        targaReg = widget.newButton({
            id  = 'BtTargaReg',
            label = 'Seleziona targa registrata',
            x = _W*0.5,
            y = _H*0.4,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = selezionaTarga
        })
        group:insert(targaReg)

        -- testo in alto
        local options2 = {
            text = 'Oppure inserisci una nuova targa:',
            x = _W*0.5,
            y = _H*0.555,
            width = _W - 30,
            fontSize = 16,
            align = "center"
        }
        local text2 = display.newText( options2 )
        text2:setFillColor( 0, 0, 0 )
        group:insert(text2)

        sfondoInserimento.y = _H*0.65
        campoInserimento.y = _H*0.65
        btClear.y = _H*0.65
    else    

    end


end

-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end

--gestisce le fasi dell'inserimento della targa
function textListener( event )
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
function clearListener( event ) 
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

-- funzioni per pulsanti

function AvantiScene ()
    if campoInserimento.text == '' then
    
    -- controllo se il formato della targa è giusto
    elseif #campoInserimento.text == 7 and campoInserimento.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
        storyboard.gotoScene('acquista2', { effect = "slideLeft", time = 500, params = { targa = trimString( campoInserimento.text ):upper() } })
    else
       campoInserimento:setTextColor(1,0,0)
    end
end


function selezionaTarga()
    storyboard.gotoScene( 'gestione_targhe' )
end



function scene:enterScene( event )
    print("ENTRA SCENA ACQUISTA")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.logo.isVisible = true
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
end

function scene:exitScene( event )
    print("ESCI SCENA ACQUISTA")

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA ACQUISTA")
end


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

return scene
