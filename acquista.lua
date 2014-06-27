--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')
local paypal =require('paypal')

widget.setTheme(myApp.theme)


-- acquista0 
local acquista0 = storyboard.newScene("acquista0")
local acquista1 = storyboard.newScene("acquista1")
local targheRegistrate = storyboard.newScene("targheRegistrate")

-- funzioni
local selezionaTargaButton = {}
local avantiButton ={}
local acquistaTicket = {}
local checkBoxListener = {}
local onRowTouch = {}
local onRowTouchTarghe = {}

-- variabili
local checkGiornaliero
local checkMultiplo30
local checkMultiplo60

-- variabili
local txtTarga
local textError
local tariffa

local string = "Da qui puoi acquistare un ticket giornaliero o multiplo per il tuo veicolo"
local strings = {}
strings[1] = 'Varchi e orari'
strings[2] = 'Tariffe e metodi di pagamento'

local importi ={ 2, 5, 30, 60 }
local ingressiN ={ 1, 10, 20 }
local ingressiR ={ 1, 20, 30 }

-- Inizializzo
myApp.acquisto = {}

function acquista0:createScene(event)

    print("CREA SCENA ACQUISTA0")

	local group = self.view

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.logo.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)


    if debugMode then
        myApp.acquisto = {
            targa = 'SI111SI',
            user = 'mario.rossi@paypal.it',
            pass = 'ciao'
        }
    end

    local BtAvanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.75,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = avantiButton
    })
    

    -- testo in alto
    local options = {
        text = string,
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local text1 = display.newText( options )
    text1:setFillColor( 0, 0, 0 )


    group:insert(BtAvanti)
    group:insert(text1)


    y = 0.5

    if myApp.utenteLoggato > 0 then
        
        local targaReg = widget.newButton({
            id  = 'BtTargaReg',
            label = 'Seleziona targa registrata',
            x = _W*0.5,
            y = _H*0.4,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = selezionaTargaButton
        })

        -- testo in alto
        local options2 = {
            text = 'Oppure inserisci una nuova targa:',
            x = _W*0.5,
            y = _H*0.555,
            width = _W - 30,
            fontSize = 16,
            align = "center"
        }
        local text2 = display.newText( options2 )
        text2:setFillColor( 0, 0, 0 )



        group:insert(targaReg)
        group:insert(text2)


        y = 0.65
    
    end 

    txtTarga = library.textArea(group, _W*0.5, _H*y, 160, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa")

    if debugMode then
        txtTarga.campo.text = myApp.acquisto.targa
    end

    textError = display.newText('FORMATO NON CORRETTO',_W*0.5,_H*0.555, myApp.font, 13)
    textError:setFillColor( 1, 0, 0 )
    textError.alpha = 0

    group:insert(txtTarga)
    group:insert(textError)

end















function acquista1:createScene(event)

    print("CREA SCENA ACQUISTA1")

    local group = self.view
 
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.indietro.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)

    tariffa = importi[2]

    if myApp.utenteLoggato ~= 0 and myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        local targaAgevolata = myApp.utenti[myApp.utenteLoggato].targa
        if myApp.acquisto.targa == targaAgevolata then
            tariffa = importi[1]
        end
        ingressi = ingressiR
    else
        ingressi = ingressiN
    end
        

    -- Recupera parametro da verificatarga
    if event.params ~= nil then
        myApp.acquisto.targa = event.params.targa
        myApp.tabBar:setSelected(3)
    end


    require("verifica")
    local accesso = verificaTarga(myApp.acquisto.targa)

    if accesso == 'p' then

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
           y = 180,
           style = "checkbox",
           id = "Giornaliero",
           initialSwitchState = true,
           onPress = checkBoxListener
        }
         
        checkMultiplo30 = widget.newSwitch
        {
           x = _W*0.08,
           y = 230,
           style = "checkbox",
           id = "Multiplo30",
           initialSwitchState = false,
           onPress = checkBoxListener
        }

        checkMultiplo60 = widget.newSwitch
        {
           x = _W*0.08,
           y = 280,
           style = "checkbox",
           id = "Multiplo60",
           initialSwitchState = false,
           onPress = checkBoxListener
        }

        local textGiornaliero = display.newText('Giornaliero                       '..tariffa..' €', _W*0.57, 180, myApp.font, 20)
        textGiornaliero:setFillColor( 0 )
        local textMultiplo30 = display.newText('Multiplo da '..ingressi[2]..' ingressi    '..importi[3]..' €', _W*0.57, 230, myApp.font, 20)
        textMultiplo30:setFillColor( 0 )
        local textMultiplo60 = display.newText('Multiplo da '..ingressi[3]..' ingressi    '..importi[4]..' €', _W*0.57, 280, myApp.font, 20)
        textMultiplo60:setFillColor( 0 )

        local info = library.makeList("info", strings, 0, _H * 0.5 +50, _W, 50, {arrow = true}, nil,  onRowTouch)

        local BtAcquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.83,
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
        group:insert(BtAcquista)

    elseif accesso == 'g' then

        local groupVerifica = verificaPrint('g', myApp.acquisto.targa)
        group:insert(groupVerifica)

    else
        
        local groupVerifica = verificaPrint('v', myApp.acquisto.targa)

        group:insert(groupVerifica)
    end

end



function targheRegistrate:createScene(event)

    local group = self.view
 
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Seleziona Targa"
    myApp.titleBar.indietro.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)

    local listaTarghe = library.makeList("targhe", myApp:getTargheUtente(myApp.utenteLoggato), 0, myApp.titleBar.height + 20, _W, 50, {x = 40}, nil, onRowTouchTarghe)
    

    local optionsStar = {
            width = 30,
            height = 30,
            numFrames = 2,
            sheetContentWidth = 60,
            sheetContentHeight = 30,
    }

    local starImage = graphics.newImageSheet( "img/star_sheet.png", optionsStar )

    local rowStar = widget.newSwitch {
        top = myApp.titleBar.height + 20 + 50 * (myApp.utenti[myApp.utenteLoggato].targaSelezionata - 1) + 12,
        left = _W*0.025,
        width = 30,
        height = 30,
        style = "radio",
        sheet = starImage,
        frameOn = 1,
        frameOff = 2,
    }
    rowStar:setState({ isOn=true })

    group:insert(listaTarghe)
    group:insert(rowStar)
end







-- Gestisce le azioni dell'utente sulle righe della lista
function onRowTouchTarghe( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
        myApp.acquisto.targa = funzioneTargheUtente[event.target.index]
        storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500 })
    end
end





function avantiButton ()
    if txtTarga.campo.text == '' then
    
    -- controllo se il formato della targa è giusto
    elseif #txtTarga.campo.text == 7 and txtTarga.campo.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
        myApp.acquisto.targa = library.trimString( txtTarga.campo.text ):upper()
        storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500 })
    else
       txtTarga.campo:setTextColor(1,0,0)

        -- testo di errore
        textError.alpha = 1

        if myApp.utenteLoggato > 0 then
            textError.y = _H*0.725
        end
    end
end


function selezionaTargaButton()
    storyboard.gotoScene( 'targheRegistrate', { effect = "slideLeft", time = 500 })
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
    end
end


function acquistaTicket()
    if checkGiornaliero.isOn then
        myApp.acquisto.ticket = 'Giornaliero'
        myApp.acquisto.ingressi = ingressi[1]
        myApp.acquisto.importo = tariffa
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    elseif checkMultiplo30.isOn then
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.ingressi = ingressi[2]
        myApp.acquisto.importo = tariffa
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    else
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.ingressi = ingressi[3]
        myApp.acquisto.importo = tariffa
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    end
end






function acquista0:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA0") 
    myApp.story.removeAll()
    myApp.story.add(storyboard.getCurrentSceneName())
end

function acquista0:exitScene( event )
    print("ESCI SCENA ACQUISTA0")
    myApp.titleBar.logo.isVisible = false
end

function acquista0:destroyScene( event )
    print("DISTRUGGI SCENA ACQUISTA0")
end


function acquista1:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA1") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function acquista1:exitScene( event )
    print("ESCI SCENA ACQUISTA1")
    myApp.titleBar.indietro.isVisible = false
end

function acquista1:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA1")
end

function targheRegistrate:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA TARGHE REGISTRATE") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function targheRegistrate:exitScene( event )
    print("ESCI SCENA ACQUISTA TARGHE REGISTRATE")
    myApp.titleBar.indietro.isVisible = false
end

function targheRegistrate:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA TARGHE REGISTRATE")
end

acquista0:addEventListener( "createScene", acquista0 )
acquista0:addEventListener( "enterScene", acquista0 )
acquista0:addEventListener( "exitScene", acquista0 )
acquista0:addEventListener( "destroyScene", acquista0 )

acquista1:addEventListener( "createScene", acquista1 )
acquista1:addEventListener( "enterScene", acquista1 )
acquista1:addEventListener( "exitScene", acquista1 )
acquista1:addEventListener( "destroyScene", acquista1 )

targheRegistrate:addEventListener( "createScene", targheRegistrate )
targheRegistrate:addEventListener( "enterScene", targheRegistrate )
targheRegistrate:addEventListener( "exitScene", targheRegistrate )
targheRegistrate:addEventListener( "destroyScene", targheRegistrate )
