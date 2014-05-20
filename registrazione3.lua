local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local textListener = {}
local clearListener = {}
local trimString = {}
local AvantiScene = {}



-- variabili
local campoInserimento
local sfondoInserimento
local btClear
local checkNonRes
local checkRes
local checkDis
local textNonRes
local textRes
local textDis
local avanti


function scene:createScene(event)
    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

	myApp.tabBar.isVisible = false

	-- testo in alto
    local options = {
        text = 'Inserisci la tua targa principale:',
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


    -- creazione textArea per targa

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = _W*0.5
    sfondoInserimento.y = _H*0.30

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = _W/2
    campoInserimento.y = _H*0.30
    campoInserimento:setTextColor( 0.75,0.75,0.75 )
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center"
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = 'Targa principale'

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = _H*0.30
    btClear.alpha = 0

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    campoInserimento:addEventListener( "userInput", textListenerTarga)

    group:insert(gruppoInserimento)


    -- creazione dei checkBox Profilo

    checkNonRes = widget.newSwitch
    {
       x = _W*0.10,
       y = _H*0.5,
       style = "checkbox",
       id = "Non residente",
       initialSwitchState = true,
       onPress = checkBoxListener
    }
     
    checkRes = widget.newSwitch
    {
       x = _W*0.10,
       y = _H*0.65,
       style = "checkbox",
       id = "Residente",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    checkDis = widget.newSwitch
    {
       x = _W*0.10,
       y = _H*0.8,
       style = "checkbox",
       id = "Disabile",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    group:insert(checkNonRes)
    group:insert(checkRes)
    group:insert(checkDis)

    -- Testo checkBox
    
    textNonRes = display.newText('Non residente', _W*0.20, _H*0.5, myApp.font, 20)
    textNonRes:setFillColor( 0 )
    textNonRes.anchorX = 0
    textRes = display.newText('Residente', _W*0.20, _H*0.65, myApp.font, 20)
    textRes:setFillColor( 0 )
    textRes.anchorX = 0
    textDis = display.newText('Disabile', _W*0.20, _H*0.80, myApp.font, 20)
    textDis:setFillColor( 0 )
    textDis.anchorX = 0

    group:insert(textNonRes)
    group:insert(textRes)
    group:insert(textDis)


    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = AvantiScene
    })
    group:insert(avanti)

end


-- Inibisce la doppia selezione dei checkBox
function checkBoxListener( event )
    if event.target.isOn then
        if event.target.id == 'Residente' then
            checkNonRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif event.target.id == 'Disabile' then
            checkNonRes:setState( { isOn = false } )
            checkRes:setState( { isOn = false } )
        else
            checkRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        end
    else 
        event.target:setState( { isOn = true } )
    end
end


-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end


--gestisce le fasi dell'inserimento della targa
function textListenerTarga( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListenerTarga )
        end
        campoInserimento:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListenerTarga )
        else
            btClear.alpha = 0
            btClear:removeEventListener( "touch", clearListenerTarga )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClear.alpha = 0
            campoInserimento:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerTarga( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimento.text = ''
        native.setKeyboardFocus( campoInserimento )
        btClear.alpha = 0
        btClear:removeEventListener( "touch", clearListenerTarga )
    end
end

function AvantiScene()
	if 	campoInserimento.text == '' then 

	else
        if checkNonRes.isOn then
            myApp.datiUtente = {
    			username = myApp.datiUtente.username,
    			password = myApp.datiUtente.password,
                nome = myApp.datiUtente.nome,
                cognome = myApp.datiUtente.cognome,
                email = myApp.datiUtente.email,
                cellulare = myApp.datiUtente.cellulare,
                targa = campoInserimento.text,
                tipo = 'Non residente'
    		}
            storyboard.gotoScene('riepilogo')
        elseif checkRes.isOn then
            myApp.datiUtente = {
                username = myApp.datiUtente.username,
                password = myApp.datiUtente.password,
                nome = myApp.datiUtente.nome,
                cognome = myApp.datiUtente.cognome,
                email = myApp.datiUtente.email,
                cellulare = myApp.datiUtente.cellulare,
                targa = campoInserimento.text,
                tipo = 'Residente'
            }
            storyboard.gotoScene('riepilogo')
        elseif checkDis.isOn then
            myApp.datiUtente = {
                username = myApp.datiUtente.username,
                password = myApp.datiUtente.password,
                nome = myApp.datiUtente.nome,
                cognome = myApp.datiUtente.cognome,
                email = myApp.datiUtente.email,
                cellulare = myApp.datiUtente.cellulare,
                targa = campoInserimento.text,
                tipo = 'Disabile'
            }
            storyboard.gotoScene('riepilogo')
        end
	end
end


function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE3")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = "registrazione2"
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE3")

    myApp.tabBar.isVisible = false

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE3")
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
