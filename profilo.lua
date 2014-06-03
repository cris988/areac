local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

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



-- titoli dei menu
local strings = {}
strings[1] = 'Dati utente'
strings[2] = 'Gestione targhe'
strings[3] = 'Cronologia transiti'





function scene:createScene(event)
    local group = self.view
    
    print("CREA SCENA PROFILO")

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    -- background:setFillColor(0.9, 0.9, 0.9)
    background:setFillColor( 1 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

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


    makeList()
    group:insert(listaInfo)
    

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



    group:insert(makeList())
    local lineB = display.newLine( group, 0, _H*0.59505, _W, _H*0.59505)
    lineB:setStrokeColor( 0.8, 0.8, 0.8 )
    local lineE = display.newLine( group, 0, _H*0.856, _W, _H*0.856)
    lineE:setStrokeColor( 0.8, 0.8, 0.8 )

end


-- creo spazio per la lista
function makeList()
    listaInfo = widget.newTableView
    {
        x = _W*0.5,
        y = _H*0.725,
        height = 150,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        isLocked = true
    }
    for i = 1, #strings do

        local isCategory = false
        local rowHeight = 50
        local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
        local lineColor = { 0.8, 0.8, 0.8 }

        -- Insert a row into the listaInfo
        listaInfo:insertRow(
            {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor
            }
        )
    end
    return listaInfo
end


-- imposto e riempio le righe della lista
function onRowRender( event )

    -- Get reference to the row group
    local row = event.row
    local id = row.index

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    rowTitle = display.newText( row, strings[row.index], 0, 0, myApp.font, 18 )
    rowTitle:setFillColor( 0 )
    rowTitle.anchorX = 0
    rowTitle.x = 20
    rowTitle.y = rowHeight * 0.5

    rowArrow = display.newImage( row, "img/rowArrow.png", false )
    rowArrow.x = row.contentWidth - right_padding
    rowArrow.anchorX = 1
    rowArrow.y = row.contentHeight * 0.5

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
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Profilo"
    myApp.titleBar.indietro.isVisible = true
    
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

    myApp.titleBar.indietro.scene = myApp.ultimaPagina


    if storyboard.getPrevious() == 'acquista2' or storyboard.getPrevious() == 'paypal' then
        myApp.titleBar.indietro.optionsBack =  { params = { targa = myApp.targaAcquista } }
    end

    myApp.titleBar.indietro.optionsBack = { effect = "slideDown", time = 500 }

    myApp.tabBar.isVisible = false
    myApp.titleBar.logo.isVisible = false

    -- print(
    --     myApp.utenti[myApp.utenteLoggato].username ..' '..
    --     myApp.utenti[myApp.utenteLoggato].password ..' '..
    --     myApp.utenti[myApp.utenteLoggato].nome ..' '..
    --     myApp.utenti[myApp.utenteLoggato].cognome ..' '..
    --     myApp.utenti[myApp.utenteLoggato].tipo ..' '..
    --     myApp.utenti[myApp.utenteLoggato].email ..' '..
    --     myApp.utenti[myApp.utenteLoggato].cellulare ..' '..
    --     myApp.utenti[myApp.utenteLoggato].targa ..' '..
    --     myApp.utenti[myApp.utenteLoggato].targaSelezionata ..' '..
    --     myApp.utenti[myApp.utenteLoggato].accessi ..' '..
    --     myApp.utenti[myApp.utenteLoggato].multiplo
    -- )
end

function scene:exitScene( event )
    print("ESCI SCENA PROFILO")

    myApp.tabBar.isVisible = true
    myApp.titleBar.logo.isVisible = false
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
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
