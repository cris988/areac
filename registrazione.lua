local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local textListenerUser = {}
local clearListenerUser = {}
local textListenerPass = {}
local clearListenerPass = {}
local textListenerPass2 = {}
local clearListenerPass2 = {}
local AvantiScene = {}



-- variabili
local titleText
local campoInserimentoUser
local sfondoInserimentoUser
local btClearUser
local campoInserimentoPass
local sfondoInserimentoPass
local btClearPass
local campoInserimentoPass2
local sfondoInserimentoPass2
local btClearPass2
local avanti



function scene:createScene(event)
    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

	-- testo in alto
    local options = {
        text = 'Inserisci le informazioni:',
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




    -- creazione textArea per Username

    local gruppoInserimentoUser = display.newGroup()

    sfondoInserimentoUser = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoUser.x = _W*0.5
    sfondoInserimentoUser.y = _H*0.40

    campoInserimentoUser = native.newTextField( 40, 85, 195, 28)
    campoInserimentoUser.x = _W/2
    campoInserimentoUser.y = _H*0.40
    campoInserimentoUser:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoUser.font = native.newFont( myApp.font, 17 )
    campoInserimentoUser.align = "center"
    campoInserimentoUser.hasBackground = false
    campoInserimentoUser.placeholder = 'Username'

  

  	print("USERNAME: "..myApp.datiUtente.username)


    if myApp.datiUtente.username == '' then
    else
    	campoInserimentoUser.text = myApp.datiUtente.username
    	campoInserimentoUser:setTextColor( 0 )
    end

    btClearUser = display.newImage('img/delete.png', 10,10)
    btClearUser.x = _W*0.85
    btClearUser.y = _H*0.40
    btClearUser.alpha = 0

    gruppoInserimentoUser:insert(sfondoInserimentoUser)
    gruppoInserimentoUser:insert(campoInserimentoUser)
    gruppoInserimentoUser:insert(btClearUser)

    campoInserimentoUser:addEventListener( "userInput", textListenerUser)




    -- creazione textArea per Password

    local gruppoInserimentoPass = display.newGroup()

    sfondoInserimentoPass = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoPass.x = _W*0.5
    sfondoInserimentoPass.y = _H*0.55

    campoInserimentoPass = native.newTextField( 40, 85, 195, 28)
    campoInserimentoPass.x = _W/2
    campoInserimentoPass.y = _H*0.55
    campoInserimentoPass:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoPass.font = native.newFont( myApp.font, 17 )
    campoInserimentoPass.align = "center"
    campoInserimentoPass.hasBackground = false
    campoInserimentoPass.placeholder = 'Password'


    print("PASSWORD: "..myApp.datiUtente.username)

    btClearPass = display.newImage('img/delete.png', 10,10)
    btClearPass.x = _W*0.85
    btClearPass.y = _H*0.55
    btClearPass.alpha = 0

    gruppoInserimentoPass:insert(sfondoInserimentoPass)
    gruppoInserimentoPass:insert(campoInserimentoPass)
    gruppoInserimentoPass:insert(btClearPass)

    campoInserimentoPass:addEventListener( "userInput", textListenerPass)


    -- creazione textArea per Conferma Password

    local gruppoInserimentoPass2 = display.newGroup()

    sfondoInserimentoPass2 = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoPass2.x = _W*0.5
    sfondoInserimentoPass2.y = _H*0.70

    campoInserimentoPass2 = native.newTextField( 40, 85, 195, 28)
    campoInserimentoPass2.x = _W/2
    campoInserimentoPass2.y = _H*0.70
    campoInserimentoPass2:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoPass2.font = native.newFont( myApp.font, 17 )
    campoInserimentoPass2.align = "center"
    campoInserimentoPass2.hasBackground = false
    campoInserimentoPass2.placeholder = 'Ripeti Password'

    btClearPass2 = display.newImage('img/delete.png', 10,10)
    btClearPass2.x = _W*0.85
    btClearPass2.y = _H*0.70
    btClearPass2.alpha = 0

    gruppoInserimentoPass2:insert(sfondoInserimentoPass2)
    gruppoInserimentoPass2:insert(campoInserimentoPass2)
    gruppoInserimentoPass2:insert(btClearPass2)

    campoInserimentoPass2:addEventListener( "userInput", textListenerPass2)


    group:insert(gruppoInserimentoUser)
    group:insert(gruppoInserimentoPass)
    group:insert(gruppoInserimentoPass2)

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


--gestisce le fasi dell'inserimento dell'Username
function textListenerUser( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearUser.alpha = 0.2
            btClearUser:addEventListener( "touch", clearListenerUser )
        end
        campoInserimentoUser:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearUser.alpha = 0.2
            btClearUser:addEventListener( "touch", clearListenerUser )
        else
            btClearUser.alpha = 0
            btClearUser:removeEventListener( "touch", clearListenerUser )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearUser.alpha = 0
            campoInserimentoUser:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerUser( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoUser.text = ''
        native.setKeyboardFocus( campoInserimentoUser )
        btClearUser.alpha = 0
        btClearUser:removeEventListener( "touch", clearListenerUser )
    end
end


--gestisce le fasi dell'inserimento della Password
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

--gestisce le fasi dell'inserimento della Conferma Password
function textListenerPass2( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearPass2.alpha = 0.2
            btClearPass2:addEventListener( "touch", clearListenerPass2 )
        end
        campoInserimentoPass2:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearPass2.alpha = 0.2
            btClearPass2:addEventListener( "touch", clearListenerPass2 )
        else
            btClearPass2.alpha = 0
            btClearPass2:removeEventListener( "touch", clearListenerPass2 )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearPass2.alpha = 0
            campoInserimentoPass2:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerPass2( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoPass2.text = ''
        native.setKeyboardFocus( campoInserimentoPass2 )
        btClearPass2.alpha = 0
        btClearPass2:removeEventListener( "touch", clearListenerPass2 )
    end
end



function AvantiScene()
	if 	campoInserimentoUser.text == '' or campoInserimentoPass.text == '' or campoInserimentoPass2.text == '' then

	else
		if campoInserimentoPass.text == campoInserimentoPass2.text then

			myApp.datiUtente = {
				username = campoInserimentoUser.text,
				password = campoInserimentoPass.text,
				-- nome = '',
	   --  		cognome = '',
	   --  		email = '',
	   --  		cellulare = '',
	   --  		targa = '',
	   --  		tipo = '',
			}

			storyboard.gotoScene('registrazione2', { effect = "slideLeft", time = 500 })
		end
	end
end





function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = "accedi"
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }
    myApp.titleBar.accedi.isVisible = false
    myApp.tabBar.isVisible = false

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE")

	myApp.tabBar.isVisible = false

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE")
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
