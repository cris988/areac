local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local goBack = {}
local textListener = {}
local clearListener = {}
local trimString = {}
local AvantiScene = {}



-- variabili
local titleBar
local titleText
local indietro
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









    -- creazione textArea per username

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

    campoInserimento:addEventListener( "userInput", textListener)





    group:insert(gruppoInserimento)










    -- creazione dei checkBox

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































function goBack()
    storyboard.removeAll()
    campoInserimento:removeSelf()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
 	storyboard.gotoScene('registrazione2')
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
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	myApp.tabBar.isVisible = true
	campoInserimento:removeSelf()
	
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
