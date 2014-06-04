local storyboard = require( "storyboard" )
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- Scene 
local paypal0 = storyboard.newScene("paypal0")
local paypal1 = storyboard.newScene("paypal1")
local paypal2 = storyboard.newScene("paypal2")

-- Funzioni
local avantiButton = {}
local fineAcquisto = {}

-- Variabili
local background = {1,1,1}



function paypal0:createScene(event)

    -- Scena di inserimento dati PayPal

    print("CREA SCENA PAYPAL")

    local group = self.view
    
    myApp.titleBar.titleText.text = "PayPal"
    myApp.titleBar.logo.isVisible = false
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'acquista2'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    myApp.tabBar.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, background )

    print("Paypal Step 0")

    riepilogo = widget.newButton({
        id  = 'BtRiepilogo',
        label = 'Prosegui',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = riepilogoButton
    })
    group:insert(riepilogo)


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


    txtUser = library.textArea(_W*0.5, _H*0.35, 195, 28, {0.75,0.75,0.75}, native.newFont( myApp.font, 17 ), "center", "Username")
    txtPass = library.textArea(_W*0.5, _H*0.5, 195, 28, {0.75,0.75,0.75}, native.newFont( myApp.font, 17 ), "center", "Password")

    group:insert(txtUser)
    group:insert(txtPass)


end

function paypal1:createScene(event)

    -- Scena di riepilogo acquisto Paypal
    
    local group = self.view

    myApp.titleBar.titleText.text = "PayPal"
    myApp.titleBar.logo.isVisible = false
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'paypal0'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    myApp.tabBar.isVisible = true
    
    library.checkLogIn()

    -- Background

    library.setBackground(group, background)

    print("Paypal Step 1")
    print( myApp.acquisto.user)

    local options ={
        parent = group,
        text = 'Stai effettuando il pagamento con l\'account\n\n'..
                        myApp.acquisto.user:upper()..
                        '\n\nper l\'acquisto di un ticket '..myApp.acquisto.ticket..' da '..myApp.acquisto.ingressi..' ingressi '..
                        ' di '..myApp.acquisto.importo..'€'..
                        '\n\nsull\'autovettura targata\n'..myApp.acquisto.targa:upper(),
        x = _W * 0.5,
        y = _H * 0.5,
        width = _W * 0.8,
        height = 400,
        font = myApp.font,
        fontSize = 20,
        align = 'center'
    }

    local areaT = display.newText(options)
    areaT:setFillColor(0)

    completa = widget.newButton({
        id  = 'BtCompleta',
        label = 'Completa acquisto',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = completaButton
    })
    group:insert(completa)

end


function paypal2:createScene(event)

    -- Scena conferma acquisto

    local group = self.view

    myApp.titleBar.titleText.text = "PayPal"
    myApp.titleBar.logo.isVisible = false
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.indietro.scene = 'paypal1'

    myApp.tabBar.isVisible = true
    
    library.checkLogIn()

    -- Background

    library.setBackground(group, background)

   
    print("Paypal Step 2")

    local myText1 = display.newText( 'Il pagamento è stato',  _W*0.5, _H*0.35, myApp.font, 20)
    myText1:setFillColor(0)
    local myText2 = display.newText( 'COMPLETATO',  _W*0.5, _H*0.4, myApp.font, 22)
    myText2:setFillColor(0.1333,0.54509,0.13334)

    local options = {
        text = 'Riceverai un email di conferma dell\'ordine',
        x = _W*0.5,
        y = _H*0.7,
        width = _W * 0.9,
        height = 70,
        font = myApp.font,
        fontSize = 20,
        align = 'center'
    }

    local myText3 = display.newText( options)
    myText3:setFillColor(0)

    group:insert(myText1)
    group:insert(myText2)
    group:insert(myText3)

    fine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = function () storyboard.gotoScene( 'mappa' ) end
    })
    group:insert(fine)

end


function riepilogoButton()
    if txtUser.campo.text ~= '' or txtPass.campo.text ~= '' then
        myApp.acquisto.user = txtUser.campo.text
        storyboard.gotoScene('paypal1', { effect = "slideLeft", time = 500 } )
    end
end

function completaButton()
    if myApp.acquisto.ticket == 'Multiplo' and myApp.utenteLoggato > 0 then
        myApp.utenti[myApp.utenteLoggato].multiplo = myApp.utenti[myApp.utenteLoggato].multiplo + myApp.acquisto.ingressi
    end
    storyboard.gotoScene( 'paypal2', { effect = "slideLeft", time = 500 })
end

function paypal0:enterScene( event ) print("ENTRA SCENA PAYPAL0") end

function paypal0:exitScene( event ) print("ESCI SCENA PAYPAL0") end

function paypal0:destroyScene( event ) print("DISTRUGGI SCENA PAYPAL0") end

function paypal1:enterScene( event ) print("ENTRA SCENA PAYPAL1") end

function paypal1:exitScene( event ) print("ESCI SCENA PAYPAL1") end

function paypal1:destroyScene( event ) print("DISTRUGGI SCENA PAYPAL1") end

function paypal2:enterScene( event ) print("ENTRA SCENA PAYPAL2") end

function paypal2:exitScene( event ) print("ESCI SCENA PAYPAL2") end

function paypal2:destroyScene( event ) print("DISTRUGGI SCENA PAYPAL2") end

paypal0:addEventListener( "createScene" )
paypal0:addEventListener( "enterScene" )
paypal0:addEventListener( "exitScene" )
paypal0:addEventListener( "destroyScene" )

paypal1:addEventListener( "createScene" )
paypal1:addEventListener( "enterScene" )
paypal1:addEventListener( "exitScene" )
paypal1:addEventListener( "destroyScene" )

paypal2:addEventListener( "createScene" )
paypal2:addEventListener( "enterScene" )
paypal2:addEventListener( "exitScene" )
paypal2:addEventListener( "destroyScene" )
