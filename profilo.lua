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
local indietroEffect
local textGratuiti
local numGratuiti
local numNonPagati


-- titoli dei menu
local strings = {}
strings[1] = 'Dati utente'
strings[2] = 'Gestione targhe'
strings[3] = 'Cronologia transiti'





function scene:createScene(event)
    local group = self.view
    
    print("CREA SCENA PROFILO")
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Profilo"
    myApp.titleBar.indietro.isVisible = true
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false
    myApp.titleBar.profilo.isVisible = false

    numNonPagati = 0
    local utente = myApp.transiti[myApp.utenteLoggato]

    -- Controllo se ci sono ingressi e non pagati e se non ci sono ticket acquistati rimanenti
    for i = 1, #utente do
        local transito = utente[i]
        if transito[3] == 'non pagato' then
            numNonPagati = numNonPagati + 1
        end
    end

    -- Imposto effetti indietro
    indietroEffect = myApp.titleBar.indietro.effect
    myApp.titleBar.indietro.func = function () 
        myApp.titleBar.indietro.effect = { effect = "slideUp", time=100 }
        myApp.tabBar.isVisible = true
    end
    

    -- Background

    library.setBackground(group, _Background )

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
        targaText.text = 'TARGA PRINCIPALE AGEVOLATA:'
    end

    local optionsTargaDati = { text = myApp.utenti[myApp.utenteLoggato].targa, x = _W*0.5, y = _H*0.32,  font = myApp.font, fontSize = 24, align = 'center' }
    local targaDatiText = display.newText( optionsTargaDati )
    targaDatiText:setFillColor( 0, 0, 0 ) 

    -- ingressi multipli
    local optionsMulti = { text = 'INGRESSI ACQUISTATI RIMANENTI:', x = _W*0.08, y = _H*0.4, font = myApp.font, fontSize = 13, align = 'center' }
    local multiText = display.newText( optionsMulti )
    multiText.anchorX = 0
    multiText:setFillColor( 0, 0, 0 )

    local optionsMultiDati = { text = myApp.utenti[myApp.utenteLoggato].multiplo, x = _W*0.9, y = _H*0.4, font = myApp.font, fontSize = 20, align = 'center' }
    local multiDatiText = display.newText( optionsMultiDati )
    multiDatiText.anchorX = 1
    multiDatiText:setFillColor( 0, 0, 0 )


    -- ingressi gratuiti residenti
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
       local optionsTextGratuiti = { text = 'INGRESSI GRATUITI RIMANENTI:', x = _W*0.08, y = _H*0.47, font = myApp.font, fontSize = 13, align = 'center' }
        textGratuiti = display.newText( optionsTextGratuiti )
        textGratuiti.anchorX = 0
        textGratuiti:setFillColor( 0, 0, 0 )

        local optionsNumGratuiti = { text = myApp.utenti[myApp.utenteLoggato].accessi, x = _W*0.9, y = _H*0.47, font = myApp.font, fontSize = 20, align = 'center' }
        numGratuiti = display.newText( optionsNumGratuiti )
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

    group:insert(library.makeList("pf", strings, 0, _H*0.6, _W, 150, 50, true, nil, onRowTouch))
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
            storyboard.gotoScene('profilo_gestione_targhe', { effect = "slideLeft", time = 500 } )
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

    -- Ripristino effetti indietro
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.indietro.func = nil
    myApp.titleBar.indietro.effect = indietroEffect
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA PROFILO")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
