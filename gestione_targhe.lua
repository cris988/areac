local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local modificaDati = {}
local fineModifica = {}
local aggiungiTarga = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}
local eliminaRow = {}
local selezionaStar = {}


-- variabili
local BtModifica
local BtFine
local BtAggiungi
local rowTitle
local rowDelete = {}
local rowStar = {}
local edit = true
local group

function scene:createScene(event)
    group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Gestione targhe"
    myApp.titleBar.indietro.isVisible = true


    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)

    
    group:insert(makeList())

    if event.params ~= nil then edit = event.params.edit end
    if edit == false then myApp.titleBar.titleText.text = 'Seleziona targa' end

    if edit ~= false then
    
        BtModifica = widget.newButton({
            id  = 'BtModifica',
            label = 'Gestisci targhe',
            x = _W*0.5,
            y = _H*0.925,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease =  modificaDati
        })
    
        BtFine = widget.newButton({
            id  = 'BtModifica',
            label = 'Fine modifiche',
            x = _W*0.5,
            y = _H*0.925,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease =  fineModifica
        })
        BtFine.isVisible = false

        BtAggiungi = widget.newButton({
            id  = 'BtAggiungi',
            label = '+ Aggiungi targa',
            x = _W*0.5,
            y = listaInfo.height + 90,
            width = _W-30,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 20,
            align = 'center',
            onRelease =  aggiungiTarga
        })
        BtAggiungi.anchorX = 0.5

        group:insert(BtModifica)  
        group:insert(BtAggiungi)
        group:insert(BtFine)

    end


    local opt = {
            width = 30,
            height = 30,
            numFrames = 2,
            sheetContentWidth = 60,
            sheetContentHeight = 30,
    }

    local mySheet = graphics.newImageSheet( "img/star_sheet.png", opt )

    for i=1, numTarghe do
        
        rowDelete[i] = widget.newButton({
            id = i,
            top = 46 + 50*(i-1),
            left = _W - 80,
            width = 80,
            height = 49,
            defaultFile = "img/elimina_on.png",
            overFile = "img/elimina_off.png",
            onRelease = function(event) 
                local index = event.target.id
                native.showAlert( "Eliminazione", "Sei sicuro di voler eliminare la targa?", {"Ok", "Annulla "}, 
                function(event) eliminaRow(event, index) end ) end
        })
        rowDelete[i].anchorY = 0
        rowDelete[i].isVisible = false

        rowStar[i] = widget.newSwitch {
            id = i,
            top = 30 + 50*i,
            left = _W*0.025 ,
            width = 30,
            height = 30,
            style = "radio",
            sheet = mySheet,
            frameOn = 1,
            frameOff = 2,
            onRelease = selezionaStar
        }
        if myApp.utenti[myApp.utenteLoggato].targaSelezionata == i then
            rowStar[i].isVisible = true
            rowStar[i]:setState({ isOn=true })
        else
            rowStar[i].isVisible = false
        end


        group:insert(rowDelete[i])
        group:insert(rowStar[i])

    end

   
end


function modificaDati()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        rowStar[i].isVisible = true
        if i == myApp.utenti[myApp.utenteLoggato].targaSelezionata then
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end

    BtModifica.isVisible = false
    BtFine.isVisible = true

end


function fineModifica()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        if rowStar[i].isOn == false then
            rowDelete[i].isVisible = false
            rowStar[i].isVisible = false
        end
    end
    BtModifica.isVisible = true
    BtFine.isVisible = false
end

local function listener( event )
    listaInfo:removeSelf( )
    group:insert(makeList())

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        rowStar[i]:toFront( )
        rowDelete[i]:toFront( )
    end
end

function eliminaRow( event, index )

    if "clicked" == event.action then
        local i = event.index
        if 1 == i then

            local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)

            listaInfo:deleteRow( index )
            rowStar[index]:removeSelf( )
            rowDelete[index]:removeSelf( )
            table.remove( rowStar, index )
            table.remove( rowDelete, index )
            table.remove( targheUtente, index )

            local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
            for i = index, numTarghe do 
                rowStar[i].id = i
                rowDelete[i].id = i
                transition.to( rowStar[i], { time = 480, delay = 430, x =(rowStar[i].x), y =(rowStar[i].y-50) } )
                transition.to( rowDelete[i], { time = 480, delay = 430, x =(rowDelete[i].x), y =(rowDelete[i].y-49) } )
            end
            transition.to( BtAggiungi, { time = 480, delay = 430, x =(BtAggiungi.x), y =(BtAggiungi.y-50) } )  

            if index < myApp.utenti[myApp.utenteLoggato].targaSelezionata then
                myApp.utenti[myApp.utenteLoggato].targaSelezionata = myApp.utenti[myApp.utenteLoggato].targaSelezionata-1
            end

            timer.performWithDelay(910,  listener)

        end
    end
end



function selezionaStar( event )
    local index = event.target.id
    myApp.utenti[myApp.utenteLoggato].targaSelezionata = index

    local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
    myApp.utenti[myApp.utenteLoggato].targa = targheUtente[index]

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)

    for i=1, numTarghe do
        if i == index then
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end
end

function aggiungiTarga()
    require("gestione_targhe_verifica")
    storyboard.gotoScene( 'gestioneVerifica0' )
end


-- creo spazio per la lista
function makeList()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    listaInfo = widget.newTableView
    {
        top = 70,
        height = 50*numTarghe,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        isLocked = true,
    }
    for i = 1, numTarghe do

        local isCategory = false
        local rowHeight = 50
        local rowColor = { default={ 1, 1, 1 }, }
        local lineColor = { 0.8, 0.8, 0.8 }

        if edit == false then
            rowColor = { default = { 1, 1, 1 }, over = { 0.3, 0.3, 0.3 } }
        end

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

    local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
    rowTitle = display.newText( row, funzioneTargheUtente[row.index], 0, 0, myApp.font, 18 )
    rowTitle:setFillColor( 0 )
    rowTitle.anchorX = 0
    rowTitle.x = _W*0.15
    rowTitle.y = rowHeight * 0.5
end


-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    if edit == false then
        local row = event.target
        if event.phase == "release" or event.phase == 'tap' then
            local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
            myApp.acquisto.targa = funzioneTargheUtente[event.target.index]
            require("acquista")
            storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500 })
        end
    end
end
    

function scene:enterScene( event )
    print("ENTRA SCENA GESTIONE TARGHE")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA GESTIONE TARGHE")
    myApp.titleBar.indietro.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA GESTIONE TARGHE")
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
