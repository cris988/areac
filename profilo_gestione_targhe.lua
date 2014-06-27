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
local inizioModifica = {}
local fineModifica = {}
local aggiungiButton = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}
local eliminaRow = {}
local selezionaStar = {}
local createList = {}


-- variabili
local listaTarghe
local BtModifica
local BtFine
local BtAggiungi
local rowTitle
local rowDelete = {}
local rowStar = {}
local group
local targaText


function scene:createScene(event)
    group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    -- Background

    library.setBackground(group, _Background)

    -- Preparo titleBar
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.titleText.text = "Gestione targhe"

    -- Stampa tabella targhe

    listaTarghe = createList()

    listaTarghe.y = myApp.titleBar.height + 20

    group:insert(listaTarghe)


    -- Testo info

    local posY = _H * 0.18

    local optionsInfo = {
        text = 'Qui puoi gestire le tue targhe registrate, aggiungerne di nuove o eliminare le inserite. ',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 15,
        width = _W-30,
        align = "center"
    }
    local infoText = display.newText( optionsInfo )
    infoText:setFillColor( 0, 0, 0 )


    -- Titolo Targa Principale o Agevolata

    posY = posY + 50

    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente'then
        text = "TARGA AGEVOLATA"
    else
        text = "TARGA PRINCIPALE"
    end

    local titleT = newTitle(text, _W * 0.5, posY, _W, 50)


    -- Stampa Targa Principale o Agevolata

    posY = posY + 55

    local optionsTarga = {
        text = myApp.utenti[myApp.utenteLoggato].targa,
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 24,
        align = "center"
    }
    targaText = display.newText( optionsTarga )
    targaText:setFillColor( 0, 0, 0 )


    -- Titolo Targhe Registrate

    posY = posY + 65

    local titleR = newTitle("TARGHE REGISTRATE", _W * 0.5, posY, _W, 50)


    -- Posizionamento lista taghe sotto titolo

    posY = posY + 25

    listaTarghe.y = posY

    -- Creazione pulsanti per eliminazione e star nella lista di targhe

    local optionsStar = {
            width = 30,
            height = 30,
            numFrames = 2,
            sheetContentWidth = 60,
            sheetContentHeight = 30,
    }

    local starImage = graphics.newImageSheet( "img/star_sheet.png", optionsStar )

    for i=1, myApp:getNumTargheUtente(myApp.utenteLoggato) do
        
        rowDelete[i] = widget.newButton({
            id = i,
            top = posY + 50 * (i -1),
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
        rowDelete[i].isVisible = false

        rowStar[i] = widget.newSwitch {
            id = i,
            top = posY + 50 * (i - 1) + 12,
            left = _W*0.025,
            width = 30,
            height = 30,
            style = "radio",
            sheet = starImage,
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

    -- Button di editing

    posY = posY + listaTarghe.height + 25

    BtAggiungi = widget.newButton({
        id  = 'BtAggiungi',
        label = '+ Aggiungi nuova targa',
        x = _W*0.5,
        y = posY,
        width = _W-30,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 20,
        align = 'center',
        onRelease =  aggiungiButton
    })
    BtAggiungi.anchorX = 0.5

    titleBar.modificaTarghe.func = inizioModifica
    titleBar.modificaTarghe.isVisible = true

    titleBar.fineTarghe.func = fineModifica

    group:insert(infoText)
    group:insert(targaText)
    group:insert(titleT)
    group:insert(titleR)
    group:insert(BtAggiungi)

   
end












function newTitle(text, x, y, width, height)

    local group = display.newGroup( )

    local bg = display.newRect( 0, y, width, height)
    bg.anchorX =0
    bg:setFillColor( 0.95,0.95,0.95 )

    -- Stampo titoli sezioni
    local title = display.newText
    {
        text = text,
        x = x,
        y = y,
        font = myApp.font,
        fontSize = 20,
        align = "center",
        width = 370,
        height = 0
    }
    title:setFillColor( 0, 0, 0 )

    local line = display.newLine( group, 0, height / 2 + y, width, height / 2 + y)
    line:setStrokeColor( 0.8, 0.8, 0.8 )

    group:insert(bg)
    group:insert(title)

    return group
end


function createList()
    return library.makeList("targhe", myApp:getTargheUtente(myApp.utenteLoggato), 0, 0, _W, 50)
end


function inizioModifica()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        rowStar[i].isVisible = true
        if i == myApp.utenti[myApp.utenteLoggato].targaSelezionata then
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end

    titleBar.modificaTarghe.isVisible = false
    titleBar.fineTarghe.isVisible = true

end


function fineModifica()
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        if rowStar[i].isOn == false then
            rowDelete[i].isVisible = false
            rowStar[i].isVisible = false
        end
    end

    titleBar.modificaTarghe.isVisible = true
    titleBar.fineTarghe.isVisible = false
end


function aggiungiButton()
    require("profilo_gestione_targhe_verifica")
    storyboard.gotoScene( 'gestioneVerifica0', { effect = "slideLeft", time = 500 } )
end



local function listenerRecreateList( event )

    --Ricreazione lista perchè gli indici 
    --della tabella non vengono aggiornati automaticamente

    -- Posizione attuale lista
    local posY = listaTarghe.y

    -- Ricreo lista
    listaTarghe:removeSelf( )
    listaTarghe = createList()
    group:insert(listaTarghe)

    -- Riposizionamento lista
    listaTarghe.y = posY

    -- In primo piano i pulsanti elimina e star
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

            listaTarghe.deleteRow( index, 480, 430 )
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

            timer.performWithDelay(910,  listenerRecreateList)

        end
    end
end



function selezionaStar( event )

    --Seleziona targa principale o agevolata

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

    targaText.text = targheUtente[index]

end
    

function scene:enterScene( event )
    print("ENTRA SCENA GESTIONE TARGHE")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA GESTIONE TARGHE")
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.modificaTarghe.isVisible = false
    myApp.titleBar.fineTarghe.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA GESTIONE TARGHE")
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
