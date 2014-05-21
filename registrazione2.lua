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
local trimString = {}
local checkBoxListener = {}
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







	-- testo in alto
    local options = {
        text = 'Inserisci nome, cognome e selezione la tipologia alla quale appartieni:',
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









    -- creazione textArea per nome

    local gruppoInserimentoNome = display.newGroup()

    sfondoInserimentoNome = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoNome.x = _W*0.5
    sfondoInserimentoNome.y = _H*0.325

    campoInserimentoNome = native.newTextField( 40, 85, 195, 28)
    campoInserimentoNome.x = _W/2
    campoInserimentoNome.y = _H*0.325
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
    btClearNome.y = _H*0.325
    btClearNome.alpha = 0

    gruppoInserimentoNome:insert(sfondoInserimentoNome)
    gruppoInserimentoNome:insert(campoInserimentoNome)
    gruppoInserimentoNome:insert(btClearNome)

    campoInserimentoNome:addEventListener( "userInput", textListenerNome)









    -- creazione textArea per cognome

    local gruppoInserimentoCognome = display.newGroup()

    sfondoInserimentoCognome = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCognome.x = _W*0.5
    sfondoInserimentoCognome.y = _H*0.45

    campoInserimentoCognome = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCognome.x = _W/2
    campoInserimentoCognome.y = _H*0.45
    campoInserimentoCognome:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCognome.font = native.newFont( myApp.font, 17 )
    campoInserimentoCognome.align = "center"
    campoInserimentoCognome.hasBackground = false
    campoInserimentoCognome.placeholder = 'Cognome'

    btClearCognome = display.newImage('img/delete.png', 10,10)
    btClearCognome.x = _W*0.85
    btClearCognome.y = _H*0.45
    btClearCognome.alpha = 0

    gruppoInserimentoCognome:insert(sfondoInserimentoCognome)
    gruppoInserimentoCognome:insert(campoInserimentoCognome)
    gruppoInserimentoCognome:insert(btClearCognome)

    campoInserimentoCognome:addEventListener( "userInput", textListenerCognome)




    group:insert(gruppoInserimentoNome)
    group:insert(gruppoInserimentoCognome)








    -- creazione dei checkBox

    checkNonRes = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.6,
       style = "checkbox",
       id = "Non residente",
       initialSwitchState = true,
       onPress = checkBoxListener
    }
     
    checkRes = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.7,
       style = "checkbox",
       id = "Residente",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    checkDis = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.8,
       style = "checkbox",
       id = "Disabile",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    group:insert(checkNonRes)
    group:insert(checkRes)
    group:insert(checkDis)
    
    textNonRes = display.newText('Non residente a Milano', _W*0.25, _H*0.6, myApp.font, 20)
    textNonRes:setFillColor( 0 )
    textNonRes.anchorX = 0
    textRes = display.newText('Residente a Milano', _W*0.25, _H*0.7, myApp.font, 20)
    textRes:setFillColor( 0 )
    textRes.anchorX = 0
    textDis = display.newText('Disabile', _W*0.25, _H*0.80, myApp.font, 20)
    textDis:setFillColor( 0 )
    textDis.anchorX = 0

    group:insert(textNonRes)
    group:insert(textRes)
    group:insert(textDis)






    if myApp.datiUtente.cognome == '' then
    else
        campoInserimentoCognome.text = myApp.datiUtente.cognome
        campoInserimentoCognome:setTextColor( 0 )
        if myApp.datiUtente.tipo == 'Non residente' then
            checkNonRes:setState( { isOn = true } )
            checkRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif myApp.datiUtente.tipo == 'Residente' then
            checkRes:setState( { isOn = true } )
            checkNonRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif myApp.datiUtente.tipo == 'Disabile' then
            checkDis:setState( { isOn = true } )
            checkRes:setState( { isOn = false } )
            checkNonRes:setState( { isOn = false } )
    end
    end
    






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





--gestisce le fasi dell'inserimento della targa
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





































function goBack()
    storyboard.removeAll()
    campoInserimentoNome:removeSelf()
    campoInserimentoCognome:removeSelf()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
 	storyboard.gotoScene('registrazione')
end

function AvantiScene()
	if 	campoInserimentoNome.text == '' or 
        campoInserimentoCognome.text == '' then

	else
		if checkNonRes.isOn then
            myApp.datiUtente = {
                username = myApp.datiUtente.username,
                password = myApp.datiUtente.password,
                nome = campoInserimentoNome.text,
                cognome = campoInserimentoCognome.text,
                -- email = myApp.datiUtente.email,
                -- cellulare = myApp.datiUtente.cellulare,
                -- targa = campoInserimento.text,
                tipo = 'Non residente'
            }
            storyboard.gotoScene('riepilogo')
        elseif checkRes.isOn then
            myApp.datiUtente = {
                username = myApp.datiUtente.username,
                password = myApp.datiUtente.password,
                nome = campoInserimentoNome.text,
                cognome = campoInserimentoCognome.text,
                -- email = myApp.datiUtente.email,
                -- cellulare = myApp.datiUtente.cellulare,
                -- targa = campoInserimento.text,
                tipo = 'Residente'
            }
            storyboard.gotoScene('registrazione3')
        elseif checkDis.isOn then
            myApp.datiUtente = {
                username = myApp.datiUtente.username,
                password = myApp.datiUtente.password,
                nome = campoInserimentoNome.text,
                cognome = campoInserimentoCognome.text,
                -- email = myApp.datiUtente.email,
                -- cellulare = myApp.datiUtente.cellulare,
                -- targa = campoInserimento.text,
                tipo = 'Disabile'
            }
            storyboard.gotoScene('registrazione4')
        end
	end
end















function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	myApp.tabBar.isVisible = true
	campoInserimentoNome:removeSelf()
    campoInserimentoCognome:removeSelf()
	
	--
	-- Clean up native objects
	--

end

function scene:destroyScene( event )
	local group = self.view
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
