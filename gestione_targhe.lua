local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local views = {}
local modificaDati = {}
local fineModifica = {}
local aggiungiTarga = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}
local eliminaRow = {}
local selezionaStar = {}
local sistemaRighe = {}


-- variabili
local modifica
local fine
local aggiungi
local rowTitle
local rowDelete = {}
local rowStar = {}
local numTargheIniz

function scene:createScene(event)
    local group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    -- Background

    library.setBackground(group, {1,1,1})

    numTargheIniz = myApp:getNumTargheUtente(myApp.utenteLoggato)

    makeList()
    group:insert(listaInfo)

    if storyboard.getPrevious( ) == 'profilo' or storyboard.getPrevious( ) == 'gestione_targhe_verifica' then
    
        modifica = widget.newButton({
            id  = 'BtModifica',
            label = 'Gestisci targhe',
            x = _W*0.5,
            y = _H*0.925,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease =  modificaDati
        })
        group:insert(modifica)

    
        fine = widget.newButton({
            id  = 'BtModifica',
            label = 'Fine modifiche',
            x = _W*0.5,
            y = _H*0.925,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease =  fineModifica
        })
        group:insert(fine)
        fine.isVisible = false


        aggiungi = widget.newButton({
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
        aggiungi.anchorX = 0.5
        -- aggiungi.isVisible = false    
        group:insert(aggiungi)
    end


    local opt = {
            width = 30,
            height = 30,
            numFrames = 2,
            sheetContentWidth = 60,
            sheetContentHeight = 30,
        }
    local mySheet = graphics.newImageSheet( "img/star_sheet.png", opt )

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTargheIniz do
        
        rowDelete[i] = widget.newButton({
            id = i,
            top = 46 + 50*(i-1),
            left = _W - 80,
            width = 80,
            height = 49,
            defaultFile = "img/elimina_on.png",
            overFile = "img/elimina_off.png",
            onRelease = eliminaRow
        })
        rowDelete[i].anchorY = 0
        rowDelete[i].isVisible = false
        group:insert(rowDelete[i])


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
        group:insert(rowStar[i])

    end

   
end








function modificaDati()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTargheIniz do
        rowStar[i].isVisible = true
        if i == myApp.utenti[myApp.utenteLoggato].targaSelezionata then
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end

    -- aggiungi.isVisible = true
    modifica.isVisible = false
    fine.isVisible = true
    myApp.titleBar.indietro.isVisible = false
end


function fineModifica()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTargheIniz do
        if rowStar[i].isOn == false then
            rowDelete[i].isVisible = false
            rowStar[i].isVisible = false
        end
    end

    -- aggiungi.isVisible = false
    modifica.isVisible = true
    fine.isVisible = false
    myApp.titleBar.indietro.isVisible = true
end

function eliminaRow( event )
    local index = event.target.id
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)

    rowStar[index]:removeSelf( )
    rowDelete[index]:removeSelf( )
    listaInfo:deleteRow( index )
    
    local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
    table.remove( funzioneTargheUtente, index )
    
    for i = index+1, numTargheIniz do        
        transition.to( rowStar[i], { time = 480, delay = 430, x =(rowStar[i].x), y =(rowStar[i].y-50) } )
        transition.to( rowDelete[i], { time = 480, delay = 430, x =(rowDelete[i].x), y =(rowDelete[i].y-49) } )       
    end
    transition.to( aggiungi, { time = 480, delay = 430, x =(aggiungi.x), y =(aggiungi.y-50) } )       

    if index < myApp.utenti[myApp.utenteLoggato].targaSelezionata then
        myApp.utenti[myApp.utenteLoggato].targaSelezionata = myApp.utenti[myApp.utenteLoggato].targaSelezionata-1
    end
end



function selezionaStar( event )
    local index = event.target.id
    myApp.utenti[myApp.utenteLoggato].targaSelezionata = index

    local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
    myApp.utenti[myApp.utenteLoggato].targa = funzioneTargheUtente[index]

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTargheIniz do
        if i == myApp.utenti[myApp.utenteLoggato].targaSelezionata then
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end
end

function aggiungiTarga()
        storyboard.gotoScene( 'gestione_targhe_verifica' )
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

        if storyboard.getPrevious( ) == 'acquista' then
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
    if storyboard.getPrevious( ) == 'acquista' then
        local row = event.target
        if event.phase == "release" or event.phase == 'tap' then
            local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
            myApp.acquisto.targa = funzioneTargheUtente[event.target.index]
            storyboard.gotoScene('acquista2', { effect = "slideLeft", time = 500 })
        end
    end
end












function scene:enterScene( event )
    print("ENTRA SCENA GESTIONE TARGHE")


    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Gestione targhe"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'profilo'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

    myApp.tabBar.isVisible = false


    if storyboard.getPrevious( ) == 'acquista' then
        myApp.titleBar.titleText.text = 'Seleziona targa'
        myApp.titleBar.indietro.isVisible = false
        myApp.titleBar.chiudi.isVisible = true
        myApp.titleBar.logo.isVisible = false
        myApp.titleBar.indietro.scene = 'acquista'
        myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }
    end
end

function scene:exitScene( event )
    print("ESCI SCENA GESTIONE TARGHE")
    myApp.titleBar.chiudi.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA GESTIONE TARGHE")
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
