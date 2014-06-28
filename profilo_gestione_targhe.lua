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
local modificaDati = {}
local fineModifica = {}
local aggiungiTarga = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}
local eliminaRow = {}
local selezionaStar = {}
local newTitle = {}


-- variabili
local BtModifica
local BtFine
local BtAggiungi
local rowTitle
local rowDelete = {}
local rowStar = {}
local edit = true
local isClickable = false
local group
local scrollView 
local lineTop
local lineBottom
local title

function scene:createScene(event)
    group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Gestione targhe"
    myApp.titleBar.indietro.isVisible = true


    scrollView = widget.newScrollView
    {
        top = 285,
        left = 0,
        width =  _W,
        height = 180,
        scrollWidth = _W,
        -- scrollHeight = 50*myApp:getNumTargheUtente(myApp.utenteLoggato) + 50,
        scrollHeight = 0,
        -- bottomPadding = 25,
        horizontalScrollDisabled = true,
        hideBackground = true,
        -- maskFile = "img/scrollMask.png"
    }
    -- local mask = graphics.newMask( "img/scrollMask.png" )
    -- scrollView:setMask( mask )

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    
    scrollView:insert(makeList())
    scrollView:setScrollHeight( listaInfo.height )
    group:insert(scrollView)

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
            -- x = _W*0.5,
            x = _W*0.08,
            -- y = listaInfo.height + 90,
            y = listaInfo.y + listaInfo.height/2 + 25,
            -- y = _H*0.925,
            -- width = display.contentWidth,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 20,
            -- fontSize = 26,
            align = 'center',
            onRelease =  aggiungiTarga
        })
        BtAggiungi.anchorX = 0

        -- linee sotto il pulsante aggiungi
        lineBottom = display.newLine( 0, BtAggiungi.y + 25, _W, BtAggiungi.y + 25)
        lineBottom:setStrokeColor( 0.8, 0.8, 0.8 )
        

        -- testo in alto
        local options = {
            text = 'Da qui puoi gestire le tue targhe registrate, aggiungerne di nuove o eliminare qulle inserite',
            x = _W*0.5,
            y = _H*0.2,
            width = _W - 30,
            fontSize = 16,
            align = "center"
        }
        local areaT = display.newText( options )
        areaT:setFillColor( 0, 0, 0 )


        -- targa principale
        local titoloTarga = { text = 'TARGA PRINCIPALE SELEZIONATA:', x = _W*0.5, y = _H*0.32, font = myApp.font, fontSize = 16, align = 'center' }
        local targaText = display.newText( titoloTarga )
        targaText:setFillColor( 0, 0, 0 )

        local targaDati = { text = myApp.utenti[myApp.utenteLoggato].targa, x = _W*0.5, y = _H*0.37,  font = myApp.font, fontSize = 24, align = 'center' }
        local targaDatiText = display.newText( targaDati )
        targaDatiText:setFillColor( 0, 0, 0 ) 
        
        title = newTitle("Targhe utente", _W*0.15, scrollView.y - scrollView.height/2 - 31 , _W, 35)
        if #myApp.targheUtente[myApp.utenteLoggato] > 2 then 
            -- lineTop = display.newLine( 0, title.y + title.height/2, _W, title.y + title.height/2 )
            lineTop = display.newLine( group, 0, scrollView.y + scrollView.height/2, _W, scrollView.y + scrollView.height/2 )
            lineTop:setStrokeColor( 0.8, 0.8, 0.8 )
        end

        scrollView:insert(BtAggiungi)
        scrollView:insert(lineBottom)

        group:insert(areaT)
        group:insert(BtModifica)  
        group:insert(BtFine)
        group:insert(targaText)
        group:insert(targaDatiText)
        group:insert(title)
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
            -- top = 46 + 50*(i-1),
            -- top = 246 + 50*(i-1),
            top = -74 + 50*i,
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
            -- top = 30 + 50*i,
            -- top = 230 + 50*i,
            top = -40 + 50*i,
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


        scrollView:insert(rowDelete[i])
        scrollView:insert(rowStar[i])

    end

   
end


function modificaDati()
    isClickable = true

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
    isClickable = false

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
    
    scrollView:insert(makeList())
    -- scrollView:setScrollHeight( listaInfo.height )
    group:insert(scrollView)

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
                transition.to( rowDelete[i], { time = 480, delay = 430, x =(rowDelete[i].x), y =(rowDelete[i].y-50) } )
            end
            transition.to( BtAggiungi, { time = 480, delay = 430, x =(BtAggiungi.x), y =(BtAggiungi.y-50) } )  
            transition.to( lineBottom, { time = 480, delay = 430, x =(lineBottom.x), y =(lineBottom.y-50) } )  

            if index < myApp.utenti[myApp.utenteLoggato].targaSelezionata then
                myApp.utenti[myApp.utenteLoggato].targaSelezionata = myApp.utenti[myApp.utenteLoggato].targaSelezionata-1
            end

            timer.performWithDelay(910,  listener)

        end
    end
end



function selezionaStar( event )
    if isClickable == true then
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
end

function aggiungiTarga()
    require("profilo_gestione_targhe_verifica")
    storyboard.gotoScene( 'gestioneVerifica0' )
end


-- creo spazio per la lista
function makeList()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    listaInfo = widget.newTableView
    {
        -- top = 70,
        top = 0,
        height = 50*numTarghe,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        isLocked = true,
        listener = function (event) scrollView:takeFocus(event) end
    }
    for i = 1, numTarghe do

        local isCategory = false
        local rowHeight = 50
        local rowColor = { default={ 1, 1, 1 }, over={ 1, 1, 1 } }
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
        if event.phase == "release" then
            local funzioneTargheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
            myApp.acquisto.targa = funzioneTargheUtente[event.target.index]
            require("acquista")
            storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500 })
        end
    else
        scrollView:takeFocus(event)
    end
end


function newTitle(text, x, y, width, height)

  local group = display.newGroup( )

  bg = display.newRect( 0, y, width, height)
  bg.anchorX =0
  bg.anchorY = 0
  bg:setFillColor( 0.95,0.95,0.95 )

    -- Stampo titoli sezioni
    local title = display.newText
    {
        text = text,
        x = 20,
        y = bg.y + 5,
        font = myApp.font,
        fontSize = 20,
        align = "left",
        width = display.contentWidth,
        height = 0
    }
    title:setFillColor( 0, 0, 0 )
    title.anchorX = 0
    title.anchorY = 0

    group:insert(bg)
    group:insert(title)

    return group
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
