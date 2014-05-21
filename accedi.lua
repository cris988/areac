local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local goBack = {}
local registrazioneScene = {}
local accediScene = {}
local textListener = {}
local clearListener = {}
local textListenerPass = {}
local clearListenerPass = {}
local trimString = {}

-- variabili
local indietro
local titleBar
local titleText
local registrati
local accedi
local campoInserimento
local sfondoInserimento
local btClear
local campoInserimentoPass
local sfondoInserimentoPass
local btClearPass

local function ignoreTouch( event )
	return true
end


function scene:createScene(event)
    print("CREA SCENA ACCEDI")
	local group = self.view

    -- Sfondo

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

    -- Contenuto

    local profiloImg = display.newImage('img/profilo.png', _W*0.5, _H*0.25)
	group:insert(profiloImg)

	local options1 = {
		text = 'Se non hai mai effettuato la registrazione su quest\'applicazione o sul sito \"areaC.it\":',
		x = _W*0.5,
		y = _H*0.4,
		width = _W-30,
		fontSize = 16,
        align = "center",
        font = myApp.font
	}
	
	local myText1 = display.newText( options1 )
    myText1:setFillColor(0) 
    group:insert(myText1)

    registrati = widget.newButton({
        id  = 'BtRegistrati',
        label = 'Registrati',
        x = _W*0.5,
        y = _H*0.5,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 22,
        onRelease = registrazioneScene
    })
    group:insert(registrati)

    local options2 = {
		text = 'altrimenti accedi con le tue credenziali',
		x = _W*0.5,
		y = _H*0.6,
		width = _W-30,
		fontSize = 16,
        align = "center",
        font = myApp.font
	}
	
	local myText2 = display.newText( options2 )
    myText2:setFillColor(0) 
    group:insert(myText2)


    -- creazione textArea per username

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = _W*0.5
    sfondoInserimento.y = _H*0.70

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = _W/2
    campoInserimento.y = _H*0.70
    campoInserimento:setTextColor( 0.75,0.75,0.75 )
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center"
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = 'Username'

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = _H*0.70
    btClear.alpha = 0

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    group:insert(gruppoInserimento)


    campoInserimento:addEventListener( "userInput", textListener)


    -- local optUsername = {
    --     sfondoInserimentoX = _W*0.5,
    --     sfondoInserimentoY = _H*0.70,
    --     campoInserimentoPlaceHolder = 'Username'
    -- }

    -- textArea:creaArea(optUsername)
    -- -- creazione textArea per password
    -- -- textArea.campoInserimento:addEventListener( "userInput", textArea:textListenerPass)


    -- local optPassword = {
    --     sfondoInserimentoX = _W*0.5,
    --     sfondoInserimentoY = _H*0.80,
    --     campoInserimentoPlaceHolder = 'Password'
    -- }

    -- textArea:creaArea(optPassword)

  -- creazione textArea per password

    local gruppoInserimentoPass = display.newGroup()

    sfondoInserimentoPass = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoPass.x = _W*0.5
    sfondoInserimentoPass.y = _H*0.80

    campoInserimentoPass = native.newTextField( 40, 85, 195, 28)
    campoInserimentoPass.x = _W/2
    campoInserimentoPass.y = _H*0.80
    campoInserimentoPass:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoPass.font = native.newFont( myApp.font, 17 )
    campoInserimentoPass.align = "center"
    campoInserimentoPass.hasBackground = false
    campoInserimentoPass.placeholder = 'Password'
    -- campoInserimentoPass.isSecure = true

    btClearPass = display.newImage('img/delete.png', 10,10)
    btClearPass.x = _W*0.85
    btClearPass.y = _H*0.80
    btClearPass.alpha = 0

    gruppoInserimentoPass:insert(sfondoInserimentoPass)
    gruppoInserimentoPass:insert(campoInserimentoPass)
    gruppoInserimentoPass:insert(btClearPass)

    group:insert(gruppoInserimentoPass)


    campoInserimentoPass:addEventListener( "userInput", textListenerPass)

    accedi = widget.newButton({
        id  = 'BtAccedi',
        label = 'Accedi',
        x = _W*0.5,
        y = _H*0.9,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 22,
        onRelease = accediScene
    })
    group:insert(accedi)
    
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


--gestisce le fasi dell'inserimento della targa
function textListenerPass( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearPass.alpha = 0.2
            btClearPass:addEventListener( "touch", clearListenerPass )
        end
        campoInserimentoPass:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearPass.alpha = 0.2
            btClearPass:addEventListener( "touch", clearListenerPass )
        else
            btClearPass.alpha = 0
            btClearPass:removeEventListener( "touch", clearListenerPass )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearPass.alpha = 0
            campoInserimentoPass:setTextColor( 0.75,0.75,0.75 )

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

-- gestisce la comparsa del pulsate clear
function clearListenerPass( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoPass.text = ''
        native.setKeyboardFocus( campoInserimentoPass )
        btClearPass.alpha = 0
        btClearPass:removeEventListener( "touch", clearListenerPass )
    end
end


function registrazioneScene()
    myApp.datiUtente = {
        username = '',
        password = '',
        nome = '',
        cognome = '',
        tipo = ',',
        targa  = '',
        cellulare = '',
        email = '',
        cf = '',
        patente = '',
        via = '',
        civico = '',
        cap = '',
        pass = '',
    }
    storyboard.gotoScene('registrazione')
end




function accediScene()
    if campoInserimento.text == '' or campoInserimentoPass.text == '' then

    else
        local indice = myApp:getNumUtenti()
        for i = 1, indice, 1 do
            if myApp.utenti[i].username == campoInserimento.text and
                myApp.utenti[i].password == campoInserimentoPass.text then

                myApp.utenteLoggato = i
                storyboard.gotoScene('profilo')
            end
        end


    end 
end













function scene:enterScene( event )
    print("ENTRA SCENA ACCEDI")

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Profilo utente"
    myApp.titleBar.indietro.isVisible = true
    
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

    myApp.titleBar.indietro.scene = storyboard.getPrevious()

    if storyboard.getPrevious() == 'acquista2' then
        myApp.titleBar.indietro.optionsBack =  { params = { targa = myApp.targaAcquista } }
    elseif storyboard.getPrevious() == 'registrazione' then
        myApp.tabBar:setSelected( 1 )
        myApp.titleBar.indietro.scene = 'mappa'
    end

    myApp.tabBar.isVisible = false
end

function scene:exitScene( event )
    print("ESCI SCENA ACCEDI")
    myApp.tabBar.isVisible = true
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA ACCEDI")
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
