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
local AvantiScene = {}
local fineAcquisto = {}
local step0 = {}
local step1 = {}


-- variabili
local titleText
local campoInserimentoUser
local sfondoInserimentoUser
local btClearUser
local campoInserimentoPass
local sfondoInserimentoPass
local btClearPass
local avanti
local fine
local checkbox



function scene:createScene(event)
    print("CREA SCENA PAYPAL")

    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

    checkbox = event.params.checkbox

    step = 0

end

-- Gestisce il primo step

function step0(group)

    print("Verifica Targa Step 0")

    avanti = widget.newButton({
        id  = 'BtCompleta',
        label = 'Completa acquisto',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = AvantiScene
    })
    group:insert(avanti)



	-- testo in alto
    local options = {
        text = 'Inserisci i tuoi dati PayPal per il pagamento:',
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
    sfondoInserimentoUser.y = _H*0.35

    campoInserimentoUser = native.newTextField( 40, 85, 195, 28)
    campoInserimentoUser.x = _W/2
    campoInserimentoUser.y = _H*0.35
    campoInserimentoUser:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoUser.font = native.newFont( myApp.font, 17 )
    campoInserimentoUser.align = "center"
    campoInserimentoUser.hasBackground = false
    campoInserimentoUser.placeholder = 'Username'

    btClearUser = display.newImage('img/delete.png', 10,10)
    btClearUser.x = _W*0.85
    btClearUser.y = _H*0.35
    btClearUser.alpha = 0

    gruppoInserimentoUser:insert(sfondoInserimentoUser)
    gruppoInserimentoUser:insert(campoInserimentoUser)
    gruppoInserimentoUser:insert(btClearUser)

    campoInserimentoUser:addEventListener( "userInput", textListenerUser)




    -- creazione textArea per Password

    local gruppoInserimentoPass = display.newGroup()

    sfondoInserimentoPass = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoPass.x = _W*0.5
    sfondoInserimentoPass.y = _H*0.5

    campoInserimentoPass = native.newTextField( 40, 85, 195, 28)
    campoInserimentoPass.x = _W/2
    campoInserimentoPass.y = _H*0.5
    campoInserimentoPass:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoPass.font = native.newFont( myApp.font, 17 )
    campoInserimentoPass.align = "center"
    campoInserimentoPass.hasBackground = false
    campoInserimentoPass.placeholder = 'Password'

    btClearPass = display.newImage('img/delete.png', 10,10)
    btClearPass.x = _W*0.85
    btClearPass.y = _H*0.5
    btClearPass.alpha = 0

    gruppoInserimentoPass:insert(sfondoInserimentoPass)
    gruppoInserimentoPass:insert(campoInserimentoPass)
    gruppoInserimentoPass:insert(btClearPass)

    campoInserimentoPass:addEventListener( "userInput", textListenerPass)



    group:insert(gruppoInserimentoUser)
    group:insert(gruppoInserimentoPass)


    return group
end





-- Gestisce il secondo step di Verifica Targa

function step1(group)
   
    print("Verifica Targa Step 1")

    local myText1 = display.newText( 'Il pagamento è stato',  _W*0.5, _H*0.45, myApp.font, 20)
    myText1:setFillColor(0)
    local myText2 = display.newText( 'COMPLETATO',  _W*0.5, _H*0.5, myApp.font, 22)
    myText2:setFillColor(0.1333,0.54509,0.13334)

    group:insert(myText1)
    group:insert(myText2)

    fine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = fineAcquisto
    })
    group:insert(fine)

    return group
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




function AvantiScene()
    if campoInserimentoPass.text == '' or campoInserimentoUser.text == '' then

    else
        print(checkbox)
        if myApp.utenteLoggato > 0 then
            if checkbox == 'Multiplo' then
                myApp.utenti[myApp.utenteLoggato].multiplo = myApp.utenti[myApp.utenteLoggato].multiplo + 50
            else
                myApp.utenti[myApp.utenteLoggato].multiplo = myApp.utenti[myApp.utenteLoggato].multiplo + 1
            end
        end
        storyboard.reloadScene( )
    end
end



function fineAcquisto()
    storyboard.gotoScene('mappa')
end





function scene:enterScene( event )
    print("ENTRA SCENA PAYPAL")

    local group = self.view
    

    myApp.titleBar.titleText.text = "PayPal"

    myApp.tabBar.isVisible = true


    --[[ Se sono al 1° step creo il group0 locale
        Se sono al 2° step creo il group1 locale
        Alla fine aggancio il group0 o group1 al group della scena
    ]]--

    if step == 0 then

        group0 = display.newGroup()
        group:insert(step0(group0))
        myApp.titleBar.logo.isVisible = false
        myApp.titleBar.indietro.isVisible = true
        myApp.titleBar.indietro.scene = 'acquista2'
        myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500, params = { targa = myApp.targaAcquista } }

        if myApp.utenteLoggato == 0 then
            myApp.titleBar.accedi.isVisible = true
        else
            myApp.titleBar.profilo.isVisible = true
        end
    else
        group1 = display.newGroup()
        group:insert(step1(group1))
        myApp.titleBar.indietro.isVisible = false

        if myApp.utenteLoggato == 0 then
            myApp.titleBar.accedi.isVisible = false
        else
            myApp.titleBar.profilo.isVisible = false
        end
    end

end

function scene:exitScene( event )
    print("ESCI SCENA PAYPAL")

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
        myApp.tabBar:setSelected(1)
    end

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA PAYPAL")
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
