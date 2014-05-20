local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local inputTarga = {}
local AvantiScene = {}
local textListener = {}
local clearListener = {}
local trimString = {}

-- variabili
local campoInserimento
local sfondoInserimento
local btClear
local step
local targa
local group0 
local group1

local string = "Inserisci la targa per controllare se il tuo veicolo è adibito ad accedere all\'area C e con che modalità"



local function ignoreTouch( event )
	return true
end



function scene:createScene(event)

    print("CREA SCENA VERIFICA")
	local group = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    step = 0

end

-- Gestisce il primo step di Verifica Targa

function step0(group)

    print("Verifica Targa Step 0")

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = AvantiScene
    })
    group:insert(avanti)

    -- local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    -- statusBarBackground.x = display.contentCenterX
    -- statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    -- group:insert(statusBarBackground)

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
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)

    group:insert(textTarga())

    return group
end

-- Gestisce il secondo step di Verifica Targa

function step1(group)
   
    print("Verifica Targa Step 1")

    accesso = math.random(4)

    --myApp.targaVerifica = targa

    schermataAccesso(accesso)

    group:insert(myText1)
    group:insert(myText2)
    group:insert(myText3)
    if accesso < 4 then
        group:insert(myText4)
        group:insert(acquista)
    end
    return group
end


function textTarga()
    -- creazione textArea per targa

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = _W*0.5
    sfondoInserimento.y = _H*0.45

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = _W/2
    campoInserimento.y = _H*0.45
    campoInserimento:setTextColor( 0.75,0.75,0.75 )
    campoInserimento.size = 17
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center"
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = 'Targa'

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = _H*0.45
    btClear.alpha = 0


    if targa == nil then
    else 
<<<<<<< HEAD
        campoInserimento.text = targa
=======
        campoInserimento.text = myApp.targaVerifica
>>>>>>> FETCH_HEAD
        campoInserimento:setTextColor( 0 )
        btClear.alpha = 0.2
        btClear:addEventListener( "touch", clearListener )
    end


    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)


    campoInserimento:addEventListener( "userInput", textListener)

    return gruppoInserimento

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

-- Verifica dell'accesso dell'auto tramite funziona random

function schermataAccesso (numero)
    if numero < 4 then
        myText1 = display.newText( 'Il veicolo con targa '..targa,  _W*0.5, 100, myApp.font, 20)
        myText1:setFillColor(0)
        myText2 = display.newText( '\nPUO\' ACCEDERE',  _W*0.5, 125, myApp.font, 20)
        myText2:setFillColor(0.1333,0.54509,0.13334)
        myText3 = display.newText( '\n\nall\'area C',  _W*0.5, 150, myApp.font, 20)
        myText3:setFillColor(0)

        myText4 = display.newText( 'ACCESSO A PAGAMENTO', _W*0.5, _H*0.5, myApp.font, 24 )
        myText4:setFillColor(0.1333,0.54509,0.13334)

        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.7,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaTicket
        })


    -- L'auto non può accedere
    else
        myText1 = display.newText( 'Il veicolo con targa '..targa,  _W*0.5, (_H*0.5)-25, myApp.font, 20)
        myText1:setFillColor(0)
        myText2 = display.newText( '\nNON PUO\' ACCEDERE',  _W*0.5, _H*0.5, myApp.font, 20)
        myText2:setFillColor(1,0,0)
        myText3 = display.newText( '\n\nall\'area C',  _W*0.5, (_H*0.5)+25, myApp.font, 20)
        myText3:setFillColor(0)  
    end

end

function acquistaTicket()
    myApp.tabBar:setSelected( 3 )
    storyboard.gotoScene('acquista2', { params = { targa = targa } })
end


-- funzioni per pulsanti

function AvantiScene ()
    if campoInserimento.text == '' then
    
    -- controllo se il formato della targa è giusto
    elseif #campoInserimento.text == 7 and campoInserimento.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
<<<<<<< HEAD
        targa = trimString( campoInserimento.text ):upper()
        storyboard.reloadScene( )
=======
        storyboard.gotoScene('verificatarga2', { params = { targa = trimString( campoInserimento.text ):upper() } })
>>>>>>> FETCH_HEAD
    else
       campoInserimento:setTextColor(1,0,0)
    end
end

function scene:enterScene( event )
    print("ENTRA SCENA VERIFICA")
    local group = self.view
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Verifica Targa"


    --[[ Se sono al 1° step creo il group0 locale
        Se sono al 2° step creo il group1 locale
        Alla fine aggancio il group0 o group1 al group della scena
    ]]--

    if step == 0 then

        group0 = display.newGroup()
        group:insert(step0(group0))
        myApp.titleBar.indietro.isVisible = false
    else
        group1 = display.newGroup()
        group:insert(step1(group1))
        myApp.titleBar.indietro.isVisible = true
        myApp.titleBar.accedi.isVisible = true
        myApp.titleBar.indietro.scene = "verificatarga"

    end

end

function scene:exitScene( event )
    print("ESCI SCENA VERIFICA")

    local group = self.view

    --[[ Se sono al 1° step distruggo il group0 e passo allo step1
        Se sono al 2° step distruggo il group1 e passo allo step0 (con il tasto indietro)
    ]]--

    if step == 0 then
        step = 1
        group:remove(group0)
    else
        step = 0
        group:remove(group1)
    end
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA VERIFICA")
    group0 = nil
    group1 = nil
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
