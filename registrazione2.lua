local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local goBack = {}
local textListenerNome = {}
local clearListenerNome = {}
local textListenerCognome = {}
local clearListenerCognome = {}
local textListenerEmail = {}
local clearListenerEmail = {}
local textListenerCell = {}
local clearListenerCell = {}
local textListenerRipeti = {}
local clearListenerRipeti = {}
local trimString = {}
local AvantiScene = {}



-- variabili
local titleBar
local titleText
local indietro
local campoInserimentoNome
local sfondoInserimentoNome
local btClearNome
local campoInserimentoCognome
local sfondoInserimentoCognome
local btClearCognome
local campoInserimentoEmail
local sfondoInserimentoEmail
local btClearEmail
local campoInserimentoCell
local sfondoInserimentoCell
local btClearCell
local avanti










function scene:createScene(event)
    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

<<<<<<< HEAD
=======
	myApp.tabBar.isVisible = false

	------ instanzio nav bar e bottoni
	titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Registrazione', 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor(0,0,0)
    titleText.x = display.contentCenterX
    titleText.y = titleBarHeight * 0.5 + display.topStatusBarContentHeight

	indietro = widget.newButton({
	    id  = 'BtIndietro',
	    label = 'Indietro',
	    x = display.contentCenterX*0.3,
	    y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = goBack
	})
	group:insert(titleBar)
    group:insert(titleText)
    group:insert(indietro)

--    local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
--    statusBarBackground.x = display.contentCenterX
--    statusBarBackground.y = display.topStatusBarContentHeight * 0.5
--    group:insert(statusBarBackground)







>>>>>>> FETCH_HEAD
	-- testo in alto
    local options = {
        text = 'Inserisci nome utente e password desiderate:',
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

<<<<<<< HEAD
=======








>>>>>>> FETCH_HEAD
    -- creazione textArea per nome

    local gruppoInserimentoNome = display.newGroup()

    sfondoInserimentoNome = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoNome.x = _W*0.5
    sfondoInserimentoNome.y = _H*0.30

    campoInserimentoNome = native.newTextField( 40, 85, 195, 28)
    campoInserimentoNome.x = _W/2
    campoInserimentoNome.y = _H*0.30
    campoInserimentoNome:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoNome.font = native.newFont( myApp.font, 17 )
    campoInserimentoNome.align = "center"
    campoInserimentoNome.hasBackground = false
    campoInserimentoNome.placeholder = 'Nome'


    if myApp.datiUtente.nome == '' then
    else
        campoInserimentoNome.text = myApp.datiUtente.nome
        campoInserimentoNome:setTextColor( 0 )
    end


    btClearNome = display.newImage('img/delete.png', 10,10)
    btClearNome.x = _W*0.85
    btClearNome.y = _H*0.30
    btClearNome.alpha = 0

    gruppoInserimentoNome:insert(sfondoInserimentoNome)
    gruppoInserimentoNome:insert(campoInserimentoNome)
    gruppoInserimentoNome:insert(btClearNome)

    campoInserimentoNome:addEventListener( "userInput", textListenerNome)



<<<<<<< HEAD
=======






>>>>>>> FETCH_HEAD
    -- creazione textArea per cognome

    local gruppoInserimentoCognome = display.newGroup()

    sfondoInserimentoCognome = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCognome.x = _W*0.5
    sfondoInserimentoCognome.y = _H*0.425

    campoInserimentoCognome = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCognome.x = _W/2
    campoInserimentoCognome.y = _H*0.425
    campoInserimentoCognome:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCognome.font = native.newFont( myApp.font, 17 )
    campoInserimentoCognome.align = "center"
    campoInserimentoCognome.hasBackground = false
    campoInserimentoCognome.placeholder = 'Cognome'


    if myApp.datiUtente.cognome == '' then
    else
        campoInserimentoCognome.text = myApp.datiUtente.cognome
        campoInserimentoCognome:setTextColor( 0 )
    end


    btClearCognome = display.newImage('img/delete.png', 10,10)
    btClearCognome.x = _W*0.85
    btClearCognome.y = _H*0.425
    btClearCognome.alpha = 0

    gruppoInserimentoCognome:insert(sfondoInserimentoCognome)
    gruppoInserimentoCognome:insert(campoInserimentoCognome)
    gruppoInserimentoCognome:insert(btClearCognome)

    campoInserimentoCognome:addEventListener( "userInput", textListenerCognome)



<<<<<<< HEAD
=======



>>>>>>> FETCH_HEAD
-- creazione textArea per email

    local gruppoInserimentoEmail = display.newGroup()

    sfondoInserimentoEmail = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoEmail.x = _W*0.5
    sfondoInserimentoEmail.y = _H*0.55

    campoInserimentoEmail = native.newTextField( 40, 85, 195, 28)
    campoInserimentoEmail.x = _W/2
    campoInserimentoEmail.y = _H*0.55
    campoInserimentoEmail:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoEmail.font = native.newFont( myApp.font, 17 )
    campoInserimentoEmail.align = "center"
    campoInserimentoEmail.hasBackground = false
    campoInserimentoEmail.placeholder = 'Email'
    campoInserimentoEmail.inputType = 'email'

    if myApp.datiUtente.email == '' then
    else
        campoInserimentoEmail.text = myApp.datiUtente.email
        campoInserimentoEmail:setTextColor( 0 )
    end


    btClearEmail = display.newImage('img/delete.png', 10,10)
    btClearEmail.x = _W*0.85
    btClearEmail.y = _H*0.55
    btClearEmail
    .alpha = 0

    gruppoInserimentoEmail:insert(sfondoInserimentoEmail)
    gruppoInserimentoEmail:insert(campoInserimentoEmail)
    gruppoInserimentoEmail:insert(btClearEmail)

    campoInserimentoEmail:addEventListener( "userInput", textListenerEmail)


<<<<<<< HEAD
=======










>>>>>>> FETCH_HEAD
    -- creazione textArea per cellulare

    local gruppoInserimentoCell = display.newGroup()

    sfondoInserimentoCell = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCell.x = _W*0.5
    sfondoInserimentoCell.y = _H*0.675

    campoInserimentoCell = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCell.x = _W/2
    campoInserimentoCell.y = _H*0.675
    campoInserimentoCell:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCell.font = native.newFont( myApp.font, 17 )
    campoInserimentoCell.align = "center"
    campoInserimentoCell.hasBackground = false
    campoInserimentoCell.placeholder = 'Cellulare'
    campoInserimentoCell.inputType = 'phone'


    if myApp.datiUtente.cellulare == '' then
    else
        campoInserimentoCell.text = myApp.datiUtente.cellulare
        campoInserimentoCell:setTextColor( 0 )
    end


    btClearCell = display.newImage('img/delete.png', 10,10)
    btClearCell.x = _W*0.85
    btClearCell.y = _H*0.675
    btClearCell.alpha = 0

    gruppoInserimentoCell:insert(sfondoInserimentoCell)
    gruppoInserimentoCell:insert(campoInserimentoCell)
    gruppoInserimentoCell:insert(btClearCell)

    campoInserimentoCell:addEventListener( "userInput", textListenerCell)


<<<<<<< HEAD
=======







    -- creazione textArea per ripetere cellulare

    local gruppoInserimentoRipeti = display.newGroup()

    sfondoInserimentoRipeti = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoRipeti.x = _W*0.5
    sfondoInserimentoRipeti.y = _H*0.80

    campoInserimentoRipeti = native.newTextField( 40, 85, 195, 28)
    campoInserimentoRipeti.x = _W/2
    campoInserimentoRipeti.y = _H*0.80
    campoInserimentoRipeti:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoRipeti.font = native.newFont( myApp.font, 17 )
    campoInserimentoRipeti.align = "center"
    campoInserimentoRipeti.hasBackground = false
    campoInserimentoRipeti.placeholder = 'Ripeti cellulare'
    campoInserimentoRipeti.inputType = 'phone'

    if myApp.datiUtente.cellulare == '' then
    else
        campoInserimentoRipeti.text = myApp.datiUtente.cellulare
        campoInserimentoRipeti:setTextColor( 0 )
    end


    btClearRipeti = display.newImage('img/delete.png', 10,10)
    btClearRipeti.x = _W*0.85
    btClearRipeti.y = _H*0.80
    btClearRipeti.alpha = 0

    gruppoInserimentoRipeti:insert(sfondoInserimentoRipeti)
    gruppoInserimentoRipeti:insert(campoInserimentoRipeti)
    gruppoInserimentoRipeti:insert(btClearRipeti)

    campoInserimentoRipeti:addEventListener( "userInput", textListenerRipeti)






>>>>>>> FETCH_HEAD
    group:insert(gruppoInserimentoNome)
    group:insert(gruppoInserimentoCognome)
    group:insert(gruppoInserimentoEmail)
    group:insert(gruppoInserimentoCell)
<<<<<<< HEAD
=======
    group:insert(gruppoInserimentoRipeti)









>>>>>>> FETCH_HEAD


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



<<<<<<< HEAD
=======



>>>>>>> FETCH_HEAD
end



<<<<<<< HEAD
=======












>>>>>>> FETCH_HEAD
-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end



<<<<<<< HEAD
--gestisce le fasi dell'inserimento del nome
=======










--gestisce le fasi dell'inserimento della targa
>>>>>>> FETCH_HEAD
function textListenerNome( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearNome.alpha = 0.2
            btClearNome:addEventListener( "touch", clearListenerNome )
        end
        campoInserimentoNome:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearNome.alpha = 0.2
            btClearNome:addEventListener( "touch", clearListenerNome )
        else
            btClearNome.alpha = 0
            btClearNome:removeEventListener( "touch", clearListenerNome )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearNome.alpha = 0
            campoInserimentoNome:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerNome( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoNome.text = ''
        native.setKeyboardFocus( campoInserimentoNome )
        btClearNome.alpha = 0
        btClearNome:removeEventListener( "touch", clearListenerNome )
    end
end


<<<<<<< HEAD
--gestisce le fasi dell'inserimento della cognome
=======



--gestisce le fasi dell'inserimento della targa
>>>>>>> FETCH_HEAD
function textListenerCognome( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearCognome.alpha = 0.2
            btClearCognome:addEventListener( "touch", clearListenerCognome )
        end
        campoInserimentoCognome:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearCognome.alpha = 0.2
            btClearCognome:addEventListener( "touch", clearListenerCognome )
        else
            btClearCognome.alpha = 0
            btClearCognome:removeEventListener( "touch", clearListenerCognome )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearCognome.alpha = 0
            campoInserimentoCognome:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerCognome( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoCognome.text = ''
        native.setKeyboardFocus( campoInserimentoCognome )
        btClearCognome.alpha = 0
        btClearCognome:removeEventListener( "touch", clearListenerCognome )
    end
end


<<<<<<< HEAD
--gestisce le fasi dell'inserimento della email
=======








--gestisce le fasi dell'inserimento della targa
>>>>>>> FETCH_HEAD
function textListenerEmail( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearEmail.alpha = 0.2
            btClearEmail
            :addEventListener( "touch", clearListenerEmail )
        end
        campoInserimentoEmail:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearEmail.alpha = 0.2
            btClearEmail:addEventListener( "touch", clearListenerEmail )
        else
            btClearEmail.alpha = 0
            btClearEmail
            :removeEventListener( "touch", clearListenerEmail )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearEmail
            .alpha = 0
            campoInserimentoEmail:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerEmail( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoEmail.text = ''
        native.setKeyboardFocus( campoInserimentoEmail )
        btClearEmail.alpha = 0
        btClearEmail:removeEventListener( "touch", clearListenerEmail )
    end
end



<<<<<<< HEAD
--gestisce le fasi dell'inserimento della cellulare
=======









--gestisce le fasi dell'inserimento della targa
>>>>>>> FETCH_HEAD
function textListenerCell( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearCell.alpha = 0.2
            btClearCell:addEventListener( "touch", clearListenerCell )
        end
        campoInserimentoCell:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearCell.alpha = 0.2
            btClearCell:addEventListener( "touch", clearListenerCell )
        else
            btClearCell.alpha = 0
            btClearCell:removeEventListener( "touch", clearListenerCell )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearCell.alpha = 0
            campoInserimentoCell:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerCell( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoCell.text = ''
        native.setKeyboardFocus( campoInserimentoCell )
        btClearCell.alpha = 0
        btClearCell:removeEventListener( "touch", clearListenerCell )
    end
end

<<<<<<< HEAD
function AvantiScene()
	if 	not (campoInserimentoNome.text == '' or 
        campoInserimentoCognome.text == '' or 
        campoInserimentoEmail.text == '' or
        campoInserimentoCell.text == '' )

    then	
=======







--gestisce le fasi dell'inserimento della targa
function textListenerRipeti( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearRipeti.alpha = 0.2
            btClearRipeti:addEventListener( "touch", clearListenerRipeti )
        end
        campoInserimentoRipeti:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearRipeti.alpha = 0.2
            btClearRipeti:addEventListener( "touch", clearListenerRipeti )
        else
            btClearRipeti.alpha = 0
            btClearRipeti:removeEventListener( "touch", clearListenerRipeti )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearRipeti.alpha = 0
            campoInserimentoRipeti:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerRipeti( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoRipeti.text = ''
        native.setKeyboardFocus( campoInserimentoRipeti )
        btClearRipeti.alpha = 0
        btClearRipeti:removeEventListener( "touch", clearListenerRipeti )
    end
end






























function goBack()
    storyboard.removeAll()
    campoInserimentoNome:removeSelf()
    campoInserimentoCognome:removeSelf()
    campoInserimentoEmail:removeSelf()
    campoInserimentoCell:removeSelf()
    campoInserimentoRipeti:removeSelf()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
 	storyboard.gotoScene('registrazione')
end

function AvantiScene()
	if 	campoInserimentoNome.text == '' or 
        campoInserimentoCognome.text == '' or 
        campoInserimentoEmail.text == '' or
        campoInserimentoCell.text == '' or 
        campoInserimentoRipeti.text == '' then

	else
		if campoInserimentoCell.text == campoInserimentoRipeti.text then
>>>>>>> FETCH_HEAD
            myApp.datiUtente = {
				username = myApp.datiUtente.username,
				password = myApp.datiUtente.password,
                nome = campoInserimentoNome.text,
                cognome = campoInserimentoCognome.text,
                email = campoInserimentoEmail.text,
                cellulare = campoInserimentoCell.text,
                -- targa = '',
			}
			storyboard.gotoScene('registrazione3')
<<<<<<< HEAD
=======
		end
>>>>>>> FETCH_HEAD
	end
end




<<<<<<< HEAD
function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE2")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = "registrazione"
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false
=======

















function scene:enterScene( event )
	local group = self.view
>>>>>>> FETCH_HEAD

end

function scene:exitScene( event )
<<<<<<< HEAD
    print("ESCI SCENA REGISTRAZIONE2")

    myApp.tabBar.isVisible = false
=======
	local group = self.view

	myApp.tabBar.isVisible = true
	campoInserimentoNome:removeSelf()
    campoInserimentoCognome:removeSelf()
    campoInserimentoEmail:removeSelf()
    campoInserimentoCell:removeSelf()
    campoInserimentoRipeti:removeSelf()
	
	--
	-- Clean up native objects
	--
>>>>>>> FETCH_HEAD

end

function scene:destroyScene( event )
<<<<<<< HEAD
    print("DISTRUGGI SCENA REGISTRAZIONE2")
end



=======
	local group = self.view
end

>>>>>>> FETCH_HEAD
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
