--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local disconnessioneButton = {}
local onRowTouch = {}


-- variabili

-- titoli dei menu
local strings = {}
strings[1] = 'Dati utente'
strings[2] = 'Gestione targhe'
strings[3] = 'Cronologia transiti'





function scene:createScene(event)
    local group = self.view
    
    print("CREA SCENA PROFILO")

    myApp.tabBar.isVisible = false

    -- Preparo titleBar
    myApp.titleBar.setTitleBar("profilo", "Profilo", { 
        indietro = true,
        accedi =  false,
        profilo = false,
        logo = false
    })

    myApp.titleBar.indietro.func = function () myApp.tabBar.isVisible = true end

    -- Background

    library.setBackground(group, _Background )

    -- crea transito non pagato con la data odierna
    if next(myApp.transiti[myApp.utenteLoggato]) == nil or myApp.transiti[myApp.utenteLoggato][1][1] ~= os.date("%d/%m/%Y")  then
        table.insert(myApp.transiti[myApp.utenteLoggato], 1, { os.date("%d/%m/%Y"), myApp:getTargheUtente(myApp.utenteLoggato)[1], 'da pagare'})
        if myApp:getTargheUtente(myApp.utenteLoggato)[2] ~= nil then
            table.insert(myApp.transiti[myApp.utenteLoggato], 1, { os.date("%d/%m/%Y"), myApp:getTargheUtente(myApp.utenteLoggato)[2], 'da pagare'})
        end
        native.showAlert( "AreaC", "Hai effettuato un transito oggi, ricordati di regolarizzarlo", {"OK"} )
    end    

    local numNonPagati = 0
    local utente = myApp.transiti[myApp.utenteLoggato]

    -- Controllo se ci sono ingressi e non pagati e se non ci sono ticket acquistati rimanenti
    for i = 1, #utente do
        local transito = utente[i]
        if transito[3] == 'da pagare' then
            numNonPagati = numNonPagati + 1
        end
    end



    local BtDisconnetti = widget.newButton({
        id  = 'BtDisconnetti',
        label = 'Disconnetti utente',
        x = _W*0.5,
        y = _H*0.925,
        labelColor = { default = { 0.8470, 0.13725, 0.13725 }, },
        fontSize = 26,
        onRelease = disconnessioneButton
    })
   
    -- Nome e Cognome
    local optionsUtente = {
        text = myApp.utenti[myApp.utenteLoggato].nome ..' '.. myApp.utenti[myApp.utenteLoggato].cognome,
        x = _W*0.5, y = _H*0.175, font = myApp.font, fontSize = 26, align = "center"
    }
    local utente = display.newText( optionsUtente )
    utente:setFillColor( 0, 0, 0 )


    -- targa principale
    local optionsTarga = { text = 'TARGA PRINCIPALE:', x = _W*0.5, y = _H*0.27, font = myApp.font, fontSize = 13, align = 'center' }
    local targaText = display.newText( optionsTarga )
    targaText:setFillColor( 0, 0, 0 )

    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' or myApp.utenti[myApp.utenteLoggato].tipo == 'Disabile' then
        targaText.text = 'TARGA AGEVOLATA:'
    end

    local optionsTargaDati = { text = myApp.utenti[myApp.utenteLoggato].targa, x = _W*0.5, y = _H*0.32,  font = myApp.font, fontSize = 24, align = 'center' }
    local targaDatiText = display.newText( optionsTargaDati )
    targaDatiText:setFillColor( 0, 0, 0 ) 

    -- ingressi multipli
    local optionsMulti = { text = 'CREDITO RIMANENTE:', x = _W*0.08, y = _H*0.4, font = myApp.font, fontSize = 13, align = 'center' }
    local multiText = display.newText( optionsMulti )
    multiText.anchorX = 0
    multiText:setFillColor( 0, 0, 0 )

    local optionsMultiDati = { text = myApp.utenti[myApp.utenteLoggato].multiplo.."€", x = _W*0.9, y = _H*0.4, font = myApp.font, fontSize = 20, align = 'center' }
    local multiDatiText = display.newText( optionsMultiDati )
    multiDatiText.anchorX = 1
    multiDatiText:setFillColor( 0, 0, 0 )


    -- ingressi gratuiti residenti
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
       local optionsTextGratuiti = { text = 'INGRESSI GRATUITI RIMANENTI:', x = _W*0.08, y = _H*0.46, font = myApp.font, fontSize = 13, align = 'center' }
        local textGratuiti = display.newText( optionsTextGratuiti )
        textGratuiti.anchorX = 0
        textGratuiti:setFillColor( 0, 0, 0 )

        local optionsNumGratuiti = { text = myApp.utenti[myApp.utenteLoggato].accessi, x = _W*0.9, y = _H*0.46  , font = myApp.font, fontSize = 20, align = 'center' }
        local numGratuiti = display.newText( optionsNumGratuiti )
        numGratuiti.anchorX = 1
        numGratuiti:setFillColor( 0, 0, 0 )

        group:insert(textGratuiti)
        group:insert(numGratuiti)
    else
        multiText.y = _H*0.42 
        multiDatiText.y = _H*0.42
    end


    local optionsNonPagati = { text = 'ACCESSI NON PAGATI:', x = _W*0.08, y = _H*0.53, font = myApp.font, fontSize = 13, align = 'center' }
    local textNonPagati = display.newText( optionsNonPagati )
    textNonPagati.anchorX = 0
    textNonPagati:setFillColor( 1, 0, 0 )     

    local optionsNumNonPagati = { text = numNonPagati, x = _W*0.9, y = _H*0.53, font = myApp.font, fontSize = 20, align = 'center' }
    local numNonPagati = display.newText( optionsNumNonPagati )
    numNonPagati.anchorX = 1
    numNonPagati:setFillColor( 1, 0, 0 )      

    if myApp.utenti[myApp.utenteLoggato].tipo == 'Non residente' or myApp.utenti[myApp.utenteLoggato].tipo == 'Disabile' then
        textNonPagati.y = _H*0.5
        numNonPagati.y = _H*0.5
    end

    

    group:insert(utente)
    group:insert(targaText)
    group:insert(targaDatiText)
    group:insert(multiText)
    group:insert(multiDatiText)
    group:insert(textNonPagati)
    group:insert(numNonPagati)

    group:insert(library.makeList("pf", strings, 0, _H*0.6, _W, 50, {arrow = true}, nil, onRowTouch))
    group:insert(BtDisconnetti)
    
end

-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        -- è il numero della riga della lista che è stato cliccato
        index = event.target.index
        if index == 1 then
            storyboard.gotoScene('profilo_dati_utente', { effect = "slideLeft", time = 500 } )
        elseif index == 2 then
            storyboard.gotoScene('profilo_gestione_targhe', { effect = "slideLeft", time = 500, params = { edit = true} } )
        elseif index == 3 then
            storyboard.gotoScene('profilo_transiti', { effect = "slideLeft", time = 500 } )
        end
    end
end



function disconnessioneButton()
    myApp.tabBar.isVisible = true
    myApp.utenteLoggato = 0
    storyboard.gotoScene(myApp.story.back(), { effect = "slideUp", time=100 })
end


function scene:enterScene( event )
    print("ENTRA SCENA PROFILO")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA PROFILO")
    myApp.titleBar.indietro.func = {}
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA PROFILO")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
