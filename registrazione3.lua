local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local goBack = {}
local textListenerCf = {}
local clearListenerCf = {}
local textListenerPatente = {}
local clearListenerPatente = {}
local textListenerVia = {}
local clearListenerVia = {}
local textListenerNum = {}
local clearListenerNum = {}
local textListenerCap = {}
local clearListenerCap = {}
local trimString = {}
local AvantiScene = {}



-- variabili
local titleBar
local titleText
local indietro
local campoInserimentoCf
local sfondoInserimentoCf
local btClearCf
local campoInserimentoPatente
local sfondoInserimentoPatente
local btClearPatente
local campoInserimentoVia
local sfondoInserimentoVia
local btClearVia
local campoInserimentoNum
local sfondoInserimentoNum
local btClearNum
local campoInserimentoCap
local sfondoInserimentoCap
local btClearCap
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










    -- creazione textArea per Cf

    local gruppoInserimentoCf = display.newGroup()

    sfondoInserimentoCf = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCf.x = _W*0.5
    sfondoInserimentoCf.y = _H*0.37

    campoInserimentoCf = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCf.x = _W/2
    campoInserimentoCf.y = _H*0.37
    campoInserimentoCf:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCf.font = native.newFont( myApp.font, 17 )
    campoInserimentoCf.align = "center"
    campoInserimentoCf.hasBackground = false
    campoInserimentoCf.placeholder = 'Codice fiscale'

    btClearCf = display.newImage('img/delete.png', 10,10)
    btClearCf.x = _W*0.85
    btClearCf.y = _H*0.37
    btClearCf.alpha = 0

    gruppoInserimentoCf:insert(sfondoInserimentoCf)
    gruppoInserimentoCf:insert(campoInserimentoCf)
    gruppoInserimentoCf:insert(btClearCf)

    campoInserimentoCf:addEventListener( "userInput", textListenerCf)





    -- creazione textArea per num patente

    local gruppoInserimentoPatente = display.newGroup()

    sfondoInserimentoPatente = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoPatente.x = _W*0.5
    sfondoInserimentoPatente.y = _H*0.47

    campoInserimentoPatente = native.newTextField( 40, 85, 195, 28)
    campoInserimentoPatente.x = _W/2
    campoInserimentoPatente.y = _H*0.47
    campoInserimentoPatente:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoPatente.font = native.newFont( myApp.font, 17 )
    campoInserimentoPatente.align = "center"
    campoInserimentoPatente.hasBackground = false
    campoInserimentoPatente.placeholder = 'Numero di patente'

    btClearPatente = display.newImage('img/delete.png', 10,10)
    btClearPatente.x = _W*0.85
    btClearPatente.y = _H*0.47
    btClearPatente.alpha = 0

    gruppoInserimentoPatente:insert(sfondoInserimentoPatente)
    gruppoInserimentoPatente:insert(campoInserimentoPatente)
    gruppoInserimentoPatente:insert(btClearPatente)

    campoInserimentoPatente:addEventListener( "userInput", textListenerPatente)


    -- creazione textArea per indirizzo

    local gruppoInserimentoVia = display.newGroup()

    sfondoInserimentoVia = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoVia.x = _W*0.5
    sfondoInserimentoVia.y = _H*0.57

    campoInserimentoVia = native.newTextField( 40, 85, 195, 28)
    campoInserimentoVia.x = _W/2
    campoInserimentoVia.y = _H*0.57
    campoInserimentoVia:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoVia.font = native.newFont( myApp.font, 17 )
    campoInserimentoVia.align = "center"
    campoInserimentoVia.hasBackground = false
    campoInserimentoVia.placeholder = 'Via di domicilio'

    btClearVia = display.newImage('img/delete.png', 10,10)
    btClearVia.x = _W*0.85
    btClearVia.y = _H*0.57
    btClearVia.alpha = 0

    gruppoInserimentoVia:insert(sfondoInserimentoVia)
    gruppoInserimentoVia:insert(campoInserimentoVia)
    gruppoInserimentoVia:insert(btClearVia)

    campoInserimentoVia:addEventListener( "userInput", textListenerVia)




    -- creazione textArea per numero civico

    local gruppoInserimentoNum = display.newGroup()

    sfondoInserimentoNum = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoNum.x = _W*0.5
    sfondoInserimentoNum.y = _H*0.67

    campoInserimentoNum = native.newTextField( 40, 85, 195, 28)
    campoInserimentoNum.x = _W/2
    campoInserimentoNum.y = _H*0.67
    campoInserimentoNum:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoNum.font = native.newFont( myApp.font, 17 )
    campoInserimentoNum.align = "center"
    campoInserimentoNum.hasBackground = false
    campoInserimentoNum.placeholder = 'Numero civico'

    btClearNum = display.newImage('img/delete.png', 10,10)
    btClearNum.x = _W*0.85
    btClearNum.y = _H*0.67
    btClearNum.alpha = 0

    gruppoInserimentoNum:insert(sfondoInserimentoNum)
    gruppoInserimentoNum:insert(campoInserimentoNum)
    gruppoInserimentoNum:insert(btClearNum)

    campoInserimentoNum:addEventListener( "userInput", textListenerNum)




    -- creazione textArea per cap

    local gruppoInserimentoCap = display.newGroup()

    sfondoInserimentoCap = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCap.x = _W*0.5
    sfondoInserimentoCap.y = _H*0.77

    campoInserimentoCap = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCap.x = _W/2
    campoInserimentoCap.y = _H*0.77
    campoInserimentoCap:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCap.font = native.newFont( myApp.font, 17 )
    campoInserimentoCap.align = "center"
    campoInserimentoCap.hasBackground = false
    campoInserimentoCap.placeholder = 'CAP'

    btClearCap = display.newImage('img/delete.png', 10,10)
    btClearCap.x = _W*0.85
    btClearCap.y = _H*0.77
    btClearCap.alpha = 0

    gruppoInserimentoCap:insert(sfondoInserimentoCap)
    gruppoInserimentoCap:insert(campoInserimentoCap)
    gruppoInserimentoCap:insert(btClearCap)

    campoInserimentoCap:addEventListener( "userInput", textListenerCap)





    group:insert(gruppoInserimentoCf)
    group:insert(gruppoInserimentoPatente)
    group:insert(gruppoInserimentoVia)
    group:insert(gruppoInserimentoNum)
    group:insert(gruppoInserimentoCap)






















    if myApp.datiUtente.cf == '' then
    else
        campoInserimentoCf.text = myApp.datiUtente.cf
        campoInserimentoCf:setTextColor( 0 )

        campoInserimentoPatente.text = myApp.datiUtente.patente
        campoInserimentoPatente:setTextColor( 0 )

        campoInserimentoVia.text = myApp.datiUtente.via
        campoInserimentoVia:setTextColor( 0 )

        campoInserimentoNum.text = myApp.datiUtente.civico
        campoInserimentoNum:setTextColor( 0 )

        campoInserimentoCap.text = myApp.datiUtente.cap
        campoInserimentoCap:setTextColor( 0 )
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













--gestisce le fasi dell'inserimento della codice fiscale
function textListenerCf( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearCf.alpha = 0.2
            btClearCf:addEventListener( "touch", clearListenerCf )
        end
        campoInserimentoCf:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearCf.alpha = 0.2
            btClearCf:addEventListener( "touch", clearListenerCf )
        else
            btClearCf.alpha = 0
            btClearCf:removeEventListener( "touch", clearListenerCf )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearCf.alpha = 0
            campoInserimentoCf:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerCf( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoCf.text = ''
        native.setKeyboardFocus( campoInserimentoCf )
        btClearCf.alpha = 0
        btClearCf:removeEventListener( "touch", clearListenerCf )
    end
end




--gestisce le fasi dell'inserimento del numero patente
function textListenerPatente( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearPatente.alpha = 0.2
            btClearPatente:addEventListener( "touch", clearListenerPatente )
        end
        campoInserimentoPatente:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearPatente.alpha = 0.2
            btClearPatente:addEventListener( "touch", clearListenerPatente )
        else
            btClearPatente.alpha = 0
            btClearPatente:removeEventListener( "touch", clearListenerPatente )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearPatente.alpha = 0
            campoInserimentoPatente:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerPatente( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoPatente.text = ''
        native.setKeyboardFocus( campoInserimentoPatente )
        btClearPatente.alpha = 0
        btClearPatente:removeEventListener( "touch", clearListenerPatente )
    end
end




--gestisce le fasi dell'inserimento della indirizzo
function textListenerVia( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearVia.alpha = 0.2
            btClearVia:addEventListener( "touch", clearListenerVia )
        end
        campoInserimentoVia:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearVia.alpha = 0.2
            btClearVia:addEventListener( "touch", clearListenerVia )
        else
            btClearVia.alpha = 0
            btClearVia:removeEventListener( "touch", clearListenerVia )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearVia.alpha = 0
            campoInserimentoVia:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerVia( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoVia.text = ''
        native.setKeyboardFocus( campoInserimentoVia )
        btClearVia.alpha = 0
        btClearVia:removeEventListener( "touch", clearListenerVia )
    end
end




--gestisce le fasi dell'inserimento della numero civico
function textListenerNum( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearNum.alpha = 0.2
            btClearNum:addEventListener( "touch", clearListenerNum )
        end
        campoInserimentoNum:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearNum.alpha = 0.2
            btClearNum:addEventListener( "touch", clearListenerNum )
        else
            btClearNum.alpha = 0
            btClearNum:removeEventListener( "touch", clearListenerNum )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearNum.alpha = 0
            campoInserimentoNum:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerNum( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoNum.text = ''
        native.setKeyboardFocus( campoInserimentoNum )
        btClearNum.alpha = 0
        btClearNum:removeEventListener( "touch", clearListenerNum )
    end
end




--gestisce le fasi dell'inserimento della CAP
function textListenerCap( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearCap.alpha = 0.2
            btClearCap:addEventListener( "touch", clearListenerCap )
        end
        campoInserimentoCap:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearCap.alpha = 0.2
            btClearCap:addEventListener( "touch", clearListenerCap )
        else
            btClearCap.alpha = 0
            btClearCap:removeEventListener( "touch", clearListenerCap )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearCap.alpha = 0
            campoInserimentoCap:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerCap( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoCap.text = ''
        native.setKeyboardFocus( campoInserimentoCap )
        btClearCap.alpha = 0
        btClearCap:removeEventListener( "touch", clearListenerCap )
    end
end


























function goBack()
    storyboard.removeAll()
    campoInserimentoCf:removeSelf()
    campoInserimentoPatente:removeSelf()
    campoInserimentoVia:removeSelf()
    campoInserimentoNum:removeSelf()
    campoInserimentoCap:removeSelf()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
    storyboard.gotoScene('registrazione2')
end

function AvantiScene()
    if  campoInserimentoCf.text == '' or 
        campoInserimentoPatente.text == '' or 
        campoInserimentoVia.text == '' or
        campoInserimentoNum.text == '' or 
        campoInserimentoCap.text == '' then

    else
        myApp.datiUtente = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            email = myApp.datiUtente.email,
            cellulare = myApp.datiUtente.cellulare,
            targa = myApp.datiUtente.targa,
            cf = campoInserimentoCf.text,
            patente = campoInserimentoPatente.text,
            via = campoInserimentoVia.text,
            civico = campoInserimentoNum.text,
            cap = campoInserimentoCap.text,
        }

        storyboard.gotoScene('riepilogo')
    end
end





















function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

	myApp.tabBar.isVisible = true
	campoInserimentoCf:removeSelf()
    campoInserimentoPatente:removeSelf()
    campoInserimentoVia:removeSelf()
    campoInserimentoNum:removeSelf()
    campoInserimentoCap:removeSelf()
	
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
