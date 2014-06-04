local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')
local library = require('library')

widget.setTheme(myApp.theme)

-- funzioni
local views = {}
local disconnessione = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}


-- variabili
local listaInfo
local disconnetti
local right_padding = 10
local background = {1,1,1}



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
    myApp.titleBar.logo.isVisible = false
    myApp.titleBar.accedi.isVisible = false
    myApp.titleBar.profilo.isVisible = false

    myApp.titleBar.indietro.scene = myApp.ultimaPagina
    myApp.titleBar.indietro.optionsBack = { effect = "slideDown", time = 500 }


    -- Background

    library.setBackground(group, background )

    local disconnetti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Disconnetti utente',
        x = _W*0.5,
        y = _H*0.925,
        labelColor = { default = { 0.8470, 0.13725, 0.13725 }, },
        fontSize = 26,
        onRelease = disconnessione
    })
    group:insert(disconnetti)
   

    -- Nome e Cognome
    local optionsNome = {
        text = myApp.utenti[myApp.utenteLoggato].nome ..' '.. myApp.utenti[myApp.utenteLoggato].cognome,
        x = _W*0.5,
        y = _H*0.175,
        font = myApp.font,
        fontSize = 26,
        align = "center"
    }
    local areaT = display.newText( optionsNome )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)


    -- targa principale
    local optionsTarga1 = {
        text = 'TARGA PRINCIPALE:',
        x = _W*0.5,
        y = _H*0.27,
        font = myApp.font,
        fontSize = 13,
        align = 'center'
    }
    local text1 = display.newText( optionsTarga1 )
    text1:setFillColor( 0, 0, 0 )
    group:insert(text1)

    local optionsTarga2 = {
        text = myApp.utenti[myApp.utenteLoggato].targa,
        x = _W*0.5,
        y = _H*0.31,
        font = myApp.font,
        fontSize = 20,
        align = 'center'
    }
    local text2 = display.newText( optionsTarga2 )
    text2:setFillColor( 0, 0, 0 )
    group:insert(text2)    



    -- ingressi multipli
    local optionsMulti1 = {
        text = 'INGRESSI ACQUISTATI RIMANENTI:',
        x = _W*0.5,
        y = _H*0.37,
        font = myApp.font,
        fontSize = 13,
        align = 'center'
    }
    local text3 = display.newText( optionsMulti1 )
    text3:setFillColor( 0, 0, 0 )
    group:insert(text3)

    local optionsMulti2 = {
        text = myApp.utenti[myApp.utenteLoggato].multiplo,
        x = _W*0.5,
        y = _H*0.41,
        font = myApp.font,
        fontSize = 20,
        align = 'center'
    }
    local text4 = display.newText( optionsMulti2 )
    text4:setFillColor( 0, 0, 0 )
    group:insert(text4)



    -- ingressi gratuiti residenti
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
       local optionsGratis1 = {
            text = 'INGRESSI GRATUITI RIMANENTI:',
            x = _W*0.5,
            y = _H*0.47,
            font = myApp.font,
            fontSize = 13,
            align = 'center'
        }
        local text5 = display.newText( optionsGratis1 )
        text5:setFillColor( 0, 0, 0 )
        group:insert(text5)

        local optionsGratis2 = {
            text = myApp.utenti[myApp.utenteLoggato].accessi,
            x = _W*0.5,
            y = _H*0.51,
            font = myApp.font,
            fontSize = 20,
            align = 'center'
        }
        local text6 = display.newText( optionsGratis2 )
        text6:setFillColor( 0, 0, 0 )
        group:insert(text6)
    else
        text3.y = _H*0.45 
        text4.y = _H*0.49
    end

    group:insert(library.makeList("pf", strings, 0, _H*0.6, _W, 150, 50, true, nil, onRowTouch))
    
end

-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        -- è il numero della riga della lista che è stato cliccato
        index = event.target.index
        if index == 1 then
            storyboard.gotoScene('dati_utente', { effect = "slideLeft", time = 500 } )
        elseif index == 2 then
            storyboard.gotoScene('gestione_targhe', { effect = "slideLeft", time = 500 } )
        elseif index == 3 then
            storyboard.gotoScene('transiti', { effect = "slideLeft", time = 500 } )
        end
    end
end



function disconnessione()
    myApp.utenteLoggato = 0
    storyboard.gotoScene(myApp.ultimaPagina, { effect = "slideDown", time = 500, params = { targa = myApp.targaAcquista } })
end


function scene:enterScene( event )
    print("ENTRA SCENA PROFILO")
end

function scene:exitScene( event )
    print("ESCI SCENA PROFILO")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA PROFILO")
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
