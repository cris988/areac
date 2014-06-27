--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require( "storyboard" )
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- Scene 
local paypal0 = storyboard.newScene("paypal0")
local paypal1 = storyboard.newScene("paypal1")
local paypal2 = storyboard.newScene("paypal2")

-- Funzioni
local avantiButton
local fineAcquisto
local loginButton
local completaButton

-- Variabili
local txtUser
local txtPass






function paypal0:createScene(event)

    -- Scena di inserimento dati PayPal

    print("CREA SCENA PAYPAL0")

    local group = self.view
    
    myApp.titleBar.titleText.text = "PayPal"
    myApp.titleBar.indietro.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background )

    -- Sfondo paypal
    local paypal = display.newImageRect( "img/paypal_login.png", _W, _H)
    paypal.anchorX = 0
    paypal.anchorY = 0

    local optionsImp = {
        text = myApp.acquisto.importo.."€",
        x = _W * 0.85,
        y = _H * 0.25,
        font = native.systemFontBold,
        fontSize = 20,
        align = 'center'

    }
    local textImporto = display.newText(optionsImp)
    textImporto:setFillColor(0.1019, 0.5411, 0)
    
    local BtLogin = widget.newButton({
        id  = 'BtLogin',
        x = _W*0.5,
        y = _H*0.84,
        width = 270,
        height = 40,
        onRelease = loginButton
    })
    BtLogin.isHitTestable = true

    txtUser = library.textArea(group, _W*0.5, _H*0.58, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Username")
    txtPass = library.textArea(group, _W*0.5, _H*0.67, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Password", true)

    txtUser.bg.alpha = 0
    txtPass.bg.alpha = 0


    if debugMode then
        txtUser.campo.text = myApp.acquisto.user
        txtPass.campo.text = myApp.acquisto.pass
    end

    group:insert(paypal)
    group:insert(textImporto)
    group:insert(BtLogin)
    group:insert(txtUser)
    group:insert(txtPass)


end

function paypal1:createScene(event)

    print("CREA SCENA PAYPAL1")

    -- Scena di riepilogo acquisto Paypal
    
    local group = self.view

    myApp.titleBar.titleText.text = "PayPal"
    myApp.titleBar.indietro.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)

    -- Sfondo paypal
    local paypal = display.newImageRect( "img/paypal_payment.png", _W, _H)
    paypal.anchorX = 0
    paypal.anchorY = 0

    local optionsImp = {
        text = myApp.acquisto.importo.."€",
        x = _W * 0.85,
        y = _H * 0.25,
        font = native.systemFontBold,
        fontSize = 20,
        align = 'center'

    }
    local textImporto = display.newText(optionsImp)
    textImporto:setFillColor(0.1019, 0.5411, 0)

    local optionsAcc = {
        text = myApp.acquisto.user,
        x = _W * 0.3,
        y = _H * 0.43,
        font = myApp.font,
        fontSize = 16,
        align = 'center'

    }
    local textAccount = display.newText(optionsAcc)
    textAccount:setFillColor(0.0588, 0.2235, 0.4156)

    local options ={
        text = 'Acquisto di un ticket:\n\n'..myApp.acquisto.ticket..' da '..
                        myApp.acquisto.ingressi..' ingressi '..
                        '\nsull\'autovettura targata\n'..myApp.acquisto.targa:upper(),
        x = _W * 0.47,
        y = _H * 0.88,
        width = _W * 0.8,
        height = 400,
        font = myApp.font,
        fontSize = 19,
        align = 'left'
    }

    local areaT = display.newText(options)
    areaT:setFillColor(0)

    local BtCompleta = widget.newButton({
        id  = 'BtCompleta',
        x = _W*0.5,
        y = _H*0.84,
        width = 270,
        height = 40,
        onRelease = completaButton
    })

    BtCompleta.isHitTestable = true

    group:insert(paypal)
    group:insert(textAccount)
    group:insert(textImporto)
    group:insert(areaT)
    group:insert(BtCompleta)

end


function paypal2:createScene(event)

    print("CREA SCENA PAYPAL2")

    -- Scena conferma acquisto

    local group = self.view

    myApp.titleBar.titleText.text = "PayPal"
    
    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)

    -- Sfondo paypal
    local paypal = display.newImageRect( "img/paypal_fine.png", _W, _H)
    paypal.anchorX = 0
    paypal.anchorY = 0

    local myText1 = display.newText( 'Il pagamento è stato',  _W*0.5, _H*0.35, myApp.font, 20)
    myText1:setFillColor(0)
    local myText2 = display.newText( 'COMPLETATO',  _W*0.5, _H*0.45, myApp.font, 23)
    myText2:setFillColor(0.1333,0.54509,0.13334)

    local options = {
        text = 'Riceverai un email di conferma dell\'ordine',
        x = _W*0.5,
        y = _H*0.6,
        width = 270,
        height = 60,
        font = myApp.font,
        fontSize = 20,
        align = 'center'
    }

    local myText3 = display.newText( options)
    myText3:setFillColor(0)

    local BtFine = widget.newButton({
        id  = 'BtFine',
        x = _W*0.5,
        y = _H*0.84,
        width = 270,
        height = 40,
        onRelease = myApp.showHome
    })
    BtFine.isHitTestable = true

    group:insert(paypal)
    group:insert(myText1)
    group:insert(myText2)
    group:insert(myText3)
    group:insert(BtFine)

end


function loginButton()
    if txtUser.campo.text ~= '' or txtPass.campo.text ~= '' then
        myApp.acquisto.user = txtUser.campo.text
        storyboard.gotoScene('paypal1', { effect = "slideLeft", time = 500 } )
    end
end

function completaButton()
    if myApp.acquisto.ticket == 'Multiplo' and myApp.utenteLoggato > 0 then
        myApp.utenti[myApp.utenteLoggato].multiplo = myApp.utenti[myApp.utenteLoggato].multiplo + myApp.acquisto.ingressi

        local numNonPagati = 0
        local utente = myApp.transiti[myApp.utenteLoggato]

        -- Controllo se ci sono ingressi e non pagati e se non ci sono ticket acquistati rimanenti
        for i = 1, #utente do
            local transito = utente[i]
            if transito[3] == 'non pagato' then
                nonPagati = true
                numNonPagati = numNonPagati + 1
            end
        end
        for i = #utente, 1, -1 do
            local transito = utente[i]
            if transito[3] == 'non pagato' then
                if myApp.utenti[myApp.utenteLoggato].multiplo > 0 then
                    transito[3] = '5€'
                    myApp.utenti[myApp.utenteLoggato].multiplo = myApp.utenti[myApp.utenteLoggato].multiplo - 1
                    numNonPagati = numNonPagati - 1
                end
            end
        end

    elseif myApp.acquisto.ticket == 'Giornaliero' and myApp.utenteLoggato > 0 then
        
        local nonPagati = false
        local posizioneNonPagata
        local utente = myApp.transiti[myApp.utenteLoggato]

        for i = #utente, 1, -1 do
            local transito = utente[i]
            if transito[3] == 'non pagato' and nonPagati == false then
                nonPagati = true
                posizioneNonPagata = i
            end
        end

        if nonPagati == true then
            local transito = utente[posizioneNonPagata]
            transito[3] = '5€'
        else
            table.insert(myApp.transiti[myApp.utenteLoggato], 1, { os.date("%d/%m/%Y"), myApp.acquisto.targa, myApp.acquisto.importo.."€"})
        end

    end
    myApp.acquisto = nil
    storyboard.gotoScene( 'paypal2', { effect = "slideLeft", time = 500 })
end


function paypal0:enterScene( event )
    print("ENTRA SCENA PAYPAL0")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function paypal0:exitScene( event ) 
    print("ESCI SCENA PAYPAL0")
    myApp.titleBar.indietro.isVisible = false
end

function paypal0:destroyScene( event ) 
    print("DISTRUGGI SCENA PAYPAL0") 
end

function paypal1:enterScene( event ) 
    print("ENTRA SCENA PAYPAL1")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function paypal1:exitScene( event ) 
    print("ESCI SCENA PAYPAL1") 
    myApp.titleBar.indietro.isVisible = false
end

function paypal1:destroyScene( event )
    print("DISTRUGGI SCENA PAYPAL1") 
end

function paypal2:enterScene( event ) 
    print("ENTRA SCENA PAYPAL2")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function paypal2:exitScene( event ) 
    print("ESCI SCENA PAYPAL2") 
end

function paypal2:destroyScene( event ) 
    print("DISTRUGGI SCENA PAYPAL2") 
end

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
