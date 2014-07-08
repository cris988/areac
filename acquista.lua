--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')
local paypal =require('paypal')

widget.setTheme(myApp.theme)


-- Scene
local acquista0 = storyboard.newScene("acquista0")
local acquista1 = storyboard.newScene("acquista1")
local acquista_targheRegistrate = storyboard.newScene("acquista_targheRegistrate")
local acquista_checkTarga = storyboard.newScene("acquista_checkTarga")
local acquista_infoTicket = storyboard.newScene("acquista_infoTicket")

-- funzioni
local selezionaTargaButton = {}
local avantiButton ={}
local acquistaTicket = {}
local checkBoxListener = {}
local onRowTouchInfoTicket = {}
local onRowTouchSelezTargheReg = {}

-- variabili
local checkGiornaliero
local checkMultiplo30
local checkMultiplo60
local txtTarga
local textError
local tariffa
local string = "Da qui puoi acquistare un ticket giornaliero o multiplo per il tuo veicolo"
local importi ={ 2, 5, 30, 60 }
local strings = {}
strings[1] = 'Informazioni su Ticket Giornaliero'
strings[2] = 'Informazioni su Ticket Multiplo'


-- Inizializzo
myApp.acquisto = {

    targa = '',
    ticket = '',
    tariffa = '', -- Tariffa della targa
    importo = '', -- Importo da pagare

}


function acquista0:createScene(event)

    print("CREA SCENA ACQUISTA0")

	local group = self.view

    -- Preparo titleBar
    myApp.titleBar.setTitleBar("acquista0", "Acquista", { 
        indietro = false,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = true
    })

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

    myApp.titleBar.setTitleBar("acquista1", "Acquista", { 
        indietro = true,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = false
    })

    -- Background

    library.setBackground(group, _Background)

    -- Importo da pagare in base alla targa
    -- Targa agevolata 2€
    -- Targa Predefinito 5€

    tariffa = importi[2]

    if myApp.utenteLoggato ~= 0 and myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        local targaAgevolata = myApp.utenti[myApp.utenteLoggato].targa
        if myApp.acquisto.targa == targaAgevolata then
            tariffa = importi[1]
        end
    end
        
    local accesso

    if event.params ~= nil then
        -- Targa già verificata
        myApp.acquisto.targa = event.params.targa
        myApp.acquisto.accesso = "p"
    elseif myApp.acquisto.accesso == nil then
        require("verifica")
        myApp.acquisto.accesso = verificaTarga(myApp.acquisto.targa)
    end

    if myApp.acquisto.accesso == 'p' then

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
        local textMultiplo30 = display.newText('Multiplo                         '..importi[3]..' €', _W*0.57, 230, myApp.font, 20)
        textMultiplo30:setFillColor( 0 )
        local textMultiplo60 = display.newText('Multiplo                         '..importi[4]..' €', _W*0.57, 280, myApp.font, 20)
        textMultiplo60:setFillColor( 0 )

        local info = library.makeList("info", strings, 0, _H * 0.5 +50, _W, 50, {arrow = true}, nil,  onRowTouchInfoTicket)

        local BtAcquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista con PayPal',
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

    elseif myApp.acquisto.accesso == 'g' then

        local groupVerifica = verificaPrint('g', myApp.acquisto.targa)
        group:insert(groupVerifica)

    else
        local groupVerifica = verificaPrint('v', myApp.acquisto.targa)
        group:insert(groupVerifica)
    end

end



function acquista_targheRegistrate:createScene(event)

    local group = self.view
 
    -- Preparo titleBar
    myApp.titleBar.setTitleBar("acquista_targheRegistrate", "Seleziona Targa", { 
        indietro = true,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = false
    })

    -- Background

    library.setBackground(group, _Background)


    -- Testo info

    local posY = _H * 0.25


    local optionsInfo = {
        text ='Le targhe che hanno effettuato un transito oggi e non sono regolarizzate sono indicate con il simbolo escalamativo',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "center"
    }
    infoText = display.newText( optionsInfo )
    infoText:setFillColor( 0, 0, 0 )


    posY = posY + 100

    local targheDaRegolarizzare = {}
    local transiti = myApp.transiti[myApp.utenteLoggato]
    local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)

    local listaTarghe = library.makeList("targhe", targheUtente, 0, posY, _W, 50, {x = 40}, nil, onRowTouchSelezTargheReg)
    group:insert(listaTarghe)

    for i=1, #targheUtente do
        
        for j = 1, #transiti do
            local transito = transiti[j]
            if transito[1] == os.date("%d/%m/%Y") and transito[3] == 'da pagare' and transito[2] == targheUtente[i] then 
                targheDaRegolarizzare[i] = display.newImage(group, "img/acquista_no.jpg", _W - 30, listaTarghe.y + 50 * (i -1) + 25)
                targheDaRegolarizzare[i].width = 20
                targheDaRegolarizzare[i].height = 40
                targheDaRegolarizzare[i].isVisible = true
            end
        end

    end



    local optionsStar = {
            width = 30,
            height = 30,
            numFrames = 2,
            sheetContentWidth = 60,
            sheetContentHeight = 30,
    }    

    local starImage = graphics.newImageSheet( "img/star_sheet.png", optionsStar )

    local topStar

    for i=1, #targheUtente do

        if targheUtente[i] == myApp.utenti[myApp.utenteLoggato].targa then
            topStar = listaTarghe.y + 50 * (i - 1) + 12

        end
    end


    local rowStar = widget.newSwitch {
        top = topStar,
        left = _W*0.025,
        width = 30,
        height = 30,
        style = "radio",
        sheet = starImage,
        frameOn = 1,
        frameOff = 2,
    }
    rowStar:setState({ isOn=true })

    group:insert(infoText)
    group:insert(rowStar)
end





function acquista_checkTarga:createScene(event)

    local group = self.view
 
    -- Preparo titleBar
    myApp.titleBar.setTitleBar("acquista_checkTarga", "Acquista", { 
        indietro = true,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = false
    })


    -- Background

    library.setBackground(group, _Background)

    local options = {
        text = "",
        x = _W*0.5,
        y = _H * 0.4,
        width = _W - 30,
        fontSize = 22,
        align = "center"
    }
    local text = display.newText( options )
    text:setFillColor( 0 )

    if event.params.par == "p" then
        text.text = 'La targa è già stata pagata,\n tutti i transiti effettuati nella data di oggi saranno coperti'
    else
        text.text = 'La targa non ha ancora effettuato dei transiti nella data di oggi.'
    end


    local BtFine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine',
        x = _W*0.5,
        y = _H*0.7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = myApp.showAcquista
    })


    group:insert(text)
    group:insert(BtFine)
end


function acquista_infoTicket:createScene(event)

    local group = self.view
 
    -- Preparo titleBar
    myApp.titleBar.setTitleBar("acquista_infoTicket", "Acquista", { 
        indietro = true,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = false
    })

    -- Background

    library.setBackground(group, _Background)

    local webView = native.newWebView( 0, myApp.titleBar.height , _W, _H - myApp.titleBar.height - myApp.tabBar.height )
    webView.anchorY = 0
    webView.anchorX = 0
    webView:request( "info_ticket"..event.params.index..".html", system.ResourceDirectory )
    group:insert(webView)
end





function avantiButton ()

    local input = library.matchTarga( txtTarga.campo.text)
    
    if input then

       storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500, params = { targa = input:upper()}})
        
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
    storyboard.gotoScene( 'acquista_targheRegistrate', { effect = "slideLeft", time = 500 })
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

-- Elemento della tableview delle targhe utente
function onRowTouchSelezTargheReg( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500, params = { targa = row.params.value}})
    end
end




-- Elemento della tableview delle info ticket
function onRowTouchInfoTicket( event )
    if event.phase == "release" or event.phase == 'tap' then
        storyboard.gotoScene( "acquista_infoTicket", { effect = "slideLeft", time = 500, params = { index = event.target.id} })
    end
end


function acquistaTicket()

    if checkGiornaliero.isOn then

        if myApp:checkTargaPagata(myApp.acquisto.targa) then
            storyboard.gotoScene( "acquista_checkTarga", { effect = "slideLeft", time = 500, params = { par = "p"}  })
        elseif myApp.acquisto.targa == "NT111NT" then
            storyboard.gotoScene( "acquista_checkTarga", { effect = "slideLeft", time = 500, params = { par = "nt"} } )
        else
            myApp.acquisto.ticket = 'Giornaliero'
            myApp.acquisto.tariffa = tariffa
            myApp.acquisto.importo = tariffa
            storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )

        end
    elseif checkMultiplo30.isOn then
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.tariffa = tariffa
        myApp.acquisto.importo = importi[3]
        storyboard.gotoScene('paypal0', { effect = "slideLeft", time = 500 } )
    else
        myApp.acquisto.ticket = 'Multiplo'
        myApp.acquisto.tariffa = tariffa
        myApp.acquisto.importo = importi[4]
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
    myApp.titleBar.indietro.func = {}
end

function acquista1:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA1")
end

function acquista_targheRegistrate:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA TARGHE REGISTRATE") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function acquista_targheRegistrate:exitScene( event )
    print("ESCI SCENA ACQUISTA TARGHE REGISTRATE")
end

function acquista_targheRegistrate:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA TARGHE REGISTRATE")
end

function acquista_checkTarga:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA TARGA PAGATA") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function acquista_checkTarga:exitScene( event )
    print("ESCI SCENA ACQUISTA TARGA PAGATA")
end

function acquista_checkTarga:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA TARGA PAGATA")
end

function acquista_infoTicket:enterScene( event ) 
    print("ENTRA SCENA ACQUISTA TARGA PAGATA") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function acquista_infoTicket:exitScene( event )
    print("ESCI SCENA ACQUISTA TARGA PAGATA")
end

function acquista_infoTicket:destroyScene( event ) 
    print("DISTRUGGI SCENA ACQUISTA TARGA PAGATA")
end

acquista0:addEventListener( "createScene", acquista0 )
acquista0:addEventListener( "enterScene", acquista0 )
acquista0:addEventListener( "exitScene", acquista0 )
acquista0:addEventListener( "destroyScene", acquista0 )

acquista1:addEventListener( "createScene", acquista1 )
acquista1:addEventListener( "enterScene", acquista1 )
acquista1:addEventListener( "exitScene", acquista1 )
acquista1:addEventListener( "destroyScene", acquista1 )

acquista_targheRegistrate:addEventListener( "createScene", acquista_targheRegistrate )
acquista_targheRegistrate:addEventListener( "enterScene", acquista_targheRegistrate )
acquista_targheRegistrate:addEventListener( "exitScene", acquista_targheRegistrate )
acquista_targheRegistrate:addEventListener( "destroyScene", acquista_targheRegistrate )

acquista_checkTarga:addEventListener( "createScene", acquista_checkTarga )
acquista_checkTarga:addEventListener( "enterScene", acquista_checkTarga )
acquista_checkTarga:addEventListener( "exitScene", acquista_checkTarga )
acquista_checkTarga:addEventListener( "destroyScene", acquista_checkTarga )

acquista_infoTicket:addEventListener( "createScene", acquista_infoTicket )
acquista_infoTicket:addEventListener( "enterScene", acquista_infoTicket )
acquista_infoTicket:addEventListener( "exitScene", acquista_infoTicket )
acquista_infoTicket:addEventListener( "destroyScene", acquista_infoTicket )
