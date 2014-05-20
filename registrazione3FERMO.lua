local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local goBack = {}
local textListenerTarga = {}
local clearListenerTarga = {}
local textListenerCell = {}
local clearListenerCell = {}
local textListenerEmail = {}
local clearListenerEmail = {}
local trimString = {}
local AvantiScene = {}



-- variabili
local titleBar
local titleText
local indietro
local campoInserimentoTarga
local sfondoInserimentoTarga
local btClearTarga
local campoInserimentoCell
local sfondoInserimentoCell
local btClearCell
local campoInserimentoEmail
local sfondoInserimentoEmail
local btClearEmail
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
        text = 'Inserisci i dati. Potranno anche essere modificati in seguito dall\'applicazione',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor{ 255,0,0 }
    group:insert(areaT)










    -- creazione textArea per targa

    local gruppoInserimentoTarga = display.newGroup()

    sfondoInserimentoTarga = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoTarga.x = _W*0.5
    sfondoInserimentoTarga.y = _H*0.40

    campoInserimentoTarga = native.newTextField( 40, 85, 195, 28)
    campoInserimentoTarga.x = _W/2
    campoInserimentoTarga.y = _H*0.4
    campoInserimentoTarga:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoTarga.font = native.newFont( myApp.font, 17 )
    campoInserimentoTarga.align = "center"
    campoInserimentoTarga.hasBackground = false
    campoInserimentoTarga.placeholder = 'Targa principale'

    btClearTarga = display.newImage('img/delete.png', 10,10)
    btClearTarga.x = _W*0.85
    btClearTarga.y = _H*0.4
    btClearTarga.alpha = 0

    gruppoInserimentoTarga:insert(sfondoInserimentoTarga)
    gruppoInserimentoTarga:insert(campoInserimentoTarga)
    gruppoInserimentoTarga:insert(btClearTarga)

    campoInserimentoTarga:addEventListener( "userInput", textListenerTarga)





    -- creazione textArea per cellulare

    local gruppoInserimentoCell = display.newGroup()

    sfondoInserimentoCell = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCell.x = _W*0.5
    sfondoInserimentoCell.y = _H*0.55

    campoInserimentoCell = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCell.x = _W/2
    campoInserimentoCell.y = _H*0.55
    campoInserimentoCell:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCell.font = native.newFont( myApp.font, 17 )
    campoInserimentoCell.align = "center"
    campoInserimentoCell.hasBackground = false
    campoInserimentoCell.placeholder = 'Cellulare'

    btClearCell = display.newImage('img/delete.png', 10,10)
    btClearCell.x = _W*0.85
    btClearCell.y = _H*0.55
    btClearCell.alpha = 0

    gruppoInserimentoCell:insert(sfondoInserimentoCell)
    gruppoInserimentoCell:insert(campoInserimentoCell)
    gruppoInserimentoCell:insert(btClearCell)

    campoInserimentoCell:addEventListener( "userInput", textListenerCell)



    -- creazione textArea per email

    local gruppoInserimentoEmail = display.newGroup()

    sfondoInserimentoEmail = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoEmail.x = _W*0.5
    sfondoInserimentoEmail.y = _H*0.7

    campoInserimentoEmail = native.newTextField( 40, 85, 195, 28)
    campoInserimentoEmail.x = _W/2
    campoInserimentoEmail.y = _H*0.7
    campoInserimentoEmail:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoEmail.font = native.newFont( myApp.font, 17 )
    campoInserimentoEmail.align = "center"
    campoInserimentoEmail.hasBackground = false
    campoInserimentoEmail.placeholder = 'Email'

    btClearEmail = display.newImage('img/delete.png', 10,10)
    btClearEmail.x = _W*0.85
    btClearEmail.y = _H*0.7
    btClearEmail.alpha = 0

    gruppoInserimentoEmail:insert(sfondoInserimentoEmail)
    gruppoInserimentoEmail:insert(campoInserimentoEmail)
    gruppoInserimentoEmail:insert(btClearEmail)

    campoInserimentoEmail:addEventListener( "userInput", textListenerEmail)


    group:insert(gruppoInserimentoTarga)
    group:insert(gruppoInserimentoCell)
    group:insert(gruppoInserimentoEmail)










   


    if myApp.datiUtente.targa == '' then
    else
        campoInserimentoTarga.text = myApp.datiUtente.targa
        campoInserimentoTarga:setTextColor( 0 )
    end
    
    if myApp.datiUtente.cellulare == '' then
    else
        campoInserimentoCell.text = myApp.datiUtente.cellulare
        campoInserimentoCell:setTextColor( 0 )
    end

    if myApp.datiUtente.email == '' then
    else
        campoInserimentoEmail.text = myApp.datiUtente.email
        campoInserimentoEmail:setTextColor( 0 )
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


























-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end













--gestisce le fasi dell'inserimento della targa
function textListenerTarga( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearTarga.alpha = 0.2
            btClearTarga:addEventListener( "touch", clearListenerTarga )
        end
        campoInserimentoTarga:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearTarga.alpha = 0.2
            btClearTarga:addEventListener( "touch", clearListenerTarga )
        else
            btClearTarga.alpha = 0
            btClearTarga:removeEventListener( "touch", clearListenerTarga )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearTarga.alpha = 0
            campoInserimentoTarga:setTextColor( 0.75,0.75,0.75 )

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
        campoInserimentoTarga.text = ''
        native.setKeyboardFocus( campoInserimentoTarga )
        btClearTarga.alpha = 0
        btClearTarga:removeEventListener( "touch", clearListenerTarga )
    end
end




--gestisce le fasi dell'inserimento del cellulare
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




--gestisce le fasi dell'inserimento della mail
function textListenerEmail( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearEmail.alpha = 0.2
            btClearEmail:addEventListener( "touch", clearListenerEmail )
        end
        campoInserimentoEmail:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearEmail.alpha = 0.2
            btClearEmail:addEventListener( "touch", clearListenerEmail )
        else
            btClearEmail.alpha = 0
            btClearEmail:removeEventListener( "touch", clearListenerEmail )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearEmail.alpha = 0
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




























function goBack()
    storyboard.removeAll()
    campoInserimentoTarga:removeSelf()
    campoInserimentoCell:removeSelf()
    campoInserimentoEmail:removeSelf()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
    storyboard.gotoScene('riepilogo')
end

function AvantiScene()
    if  campoInserimentoTarga.text == '' or campoInserimentoCell.text == '' or campoInserimentoEmail.text == '' then

    else
        myApp.datiUtente = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = campoInserimentoTarga.text,
        }

        storyboard.gotoScene('riepilogo2')
    end
end





















function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	myApp.tabBar.isVisible = true
	campoInserimentoTarga:removeSelf()
    campoInserimentoCell:removeSelf()
    campoInserimentoEmail:removeSelf()
	
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
