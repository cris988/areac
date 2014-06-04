local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')
local paypal =require('paypal')

widget.setTheme(myApp.theme)


-- funzioni
local acquistaTicket = {}
local checkBoxListener = {}
local onRowTouch = {}


-- variabili
local accedi
local targa
local acquista
local checkGiornaliero
local checkMultiplo30
local checkMultiplo60
local checkboxSelected = true
local listaInfo
local right_padding = 10
local textGiornaliero
local textMultiplo30
local textMultiplo60



-- titoli delle informazioni
local strings = {}
strings[1] = 'Varchi e orari'
strings[2] = 'Tariffe e metodi di pagamento'

local importi ={ 5, 30, 60 }
local ingressi ={ 1, 10, 20 }
local ingressiR ={ 1, 20, 30 }



function scene:createScene(event)


    print("CREA SCENA ACQUISTA")

    local group = self.view
 
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.logo.isVisible = false
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'acquista'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    myApp.tabBar.isVisible = true  

    library.checkLogIn()

    -- Background

    library.setBackground(group, {1,1,1})


    -- Recupera parametro da verificatarga
    if myApp.acquisto == nil then
        myApp.acquisto = {}
        myApp.acquisto.targa = event.params.targa
    end

    local accesso = library.verificaTarga(myApp.acquisto.targa)

    if accesso then

        local options = {
            text = 'Seleziona il ticket da acquistare per questa targa: '..myApp.acquisto.targa,
            x = _W*0.5,
            y = 100,
            width = _W - 30,
            fontSize = 16,
            align = "center"
        }
        myText = display.newText( options )
        myText:setFillColor( 0 )

        -- creazione dei checkBox

        checkGiornaliero = widget.newSwitch
        {
           x = _W*0.08,
           y = 190,
           style = "checkbox",
           id = "Giornaliero",
           initialSwitchState = true,
           onPress = checkBoxListener
        }
         
        checkMultiplo30 = widget.newSwitch
        {
           x = _W*0.08,
           y = 240,
           style = "checkbox",
           id = "Multiplo30",
           initialSwitchState = false,
           onPress = checkBoxListener
        }

        checkMultiplo60 = widget.newSwitch
        {
           x = _W*0.08,
           y = 290,
           style = "checkbox",
           id = "Multiplo60",
           initialSwitchState = false,
           onPress = checkBoxListener
        }

        
        textGiornaliero = display.newText('Giornaliero                       '..importi[1]..' €', _W*0.57, 190, myApp.font, 20)
        textGiornaliero:setFillColor( 0 )
        textMultiplo30 = display.newText('Multiplo da '..ingressi[2]..' ingressi    '..importi[2]..' €', _W*0.57, 240, myApp.font, 20)
        textMultiplo30:setFillColor( 0 )
        textMultiplo60 = display.newText('Multiplo da '..ingressi[3]..' ingressi    '..importi[3]..' €', _W*0.57, 290, myApp.font, 20)
        textMultiplo60:setFillColor( 0 )

        info = library.makeList("info", strings, 0, _H * 0.5 +50, _W, 100, 50, true, nil,  onRowTouch)

        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.85,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaTicket
        })
        

        group:insert(myText)
        group:insert(checkGiornaliero)
        group:insert(checkMultiplo30)
        group:insert(checkMultiplo60)
        group:insert(textGiornaliero)
        group:insert(textMultiplo30)
        group:insert(textMultiplo60)
        group:insert(info)
        group:insert(acquista)

    else
        line1 = display.newText( 'Il veicolo con targa '..myApp.acquisto.targa,  _W*0.5, (_H*0.5)-25, myApp.font, 20)
        line1:setFillColor(0)
        line2 = display.newText( '\nNON PUO\' ACCEDERE',  _W*0.5, _H*0.5, myApp.font, 20)
        line2:setFillColor(1,0,0)
        line3 = display.newText( '\n\nall\'area C',  _W*0.5, (_H*0.5)+25, myApp.font, 20)
        line3:setFillColor(0)  

        group:insert(line1)
        group:insert(line2)
        group:insert(line3)
    end
end


-- Inibisce la doppia selezione dei checkBox
function checkBoxListener( event )

    if event.target.isOn then
        if event.target.id == 'Multiplo30' then
            checkGiornaliero:setState( { isOn = false } )
            checkMultiplo60:setState( { isOn = false } )
        elseif event.target.id == 'Multiplo60' then
                checkGiornaliero:setState( { isOn = false } )
                checkMultiplo30:setState( { isOn = false } )
            else 
                checkMultiplo30:setState( { isOn = false } )
                checkMultiplo60:setState( { isOn = false } )
        end
    else
        if event.target.id == 'Multiplo30' then
            checkMultiplo30:setState( { isOn = true } )
        elseif event.target.id == 'Multiplo60' then
                checkMultiplo60:setState( { isOn = true } )
            else 
                checkGiornaliero:setState( { isOn = true } )
        end
    end
end

-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        if event.target.index == 1 then
            storyboard.gotoScene('info_details', { effect = "slideLeft", time = 500, params = { var = 3 } })
        else
            storyboard.gotoScene('info_details', { effect = "slideLeft", time = 500, params = { var = 5 } })
        end
        myApp.titleBar.indietro.scene = 'acquista2'
    end
end


function acquistaTicket()
    if checkGiornaliero.isOn then
        myApp.acquisto.ticket = 'Giornaliero'
        myApp.acquisto.ingressi = ingressi[1]
        myApp.acquisto.importo= importi[1]
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    elseif checkMultiplo30.isOn then
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.ingressi = ingressi[2]
        myApp.acquisto.importo= importi[2]
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    else
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.ingressi = ingressi[3]
        myApp.acquisto.importo= importi[3]
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    end
end



function scene:enterScene( event )
    print("ENTRA SCENA ACQUISTA")
 
end

function scene:exitScene( event )
    print("ESCI SCENA ACQUISTA")
    
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA ACQUISTA")
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
