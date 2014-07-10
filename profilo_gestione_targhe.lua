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
local eliminaRow = {}
local selezionaStar = {}
local newTitle = {}


-- variabili
local group
local infoText
local textInfo
local textEditInfoPrincipale
local textEditInfoResidente
--local targaText
local scrollView
local listaTarghe
local rowDelete = {}
local rowStar = {}
local borderBottomScroll
local BtAggiungi
local starInfo
local indexToSaved
local isClickable = false

function scene:createScene(event)

    group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    -- Background

    library.setBackground(group, _Background)

    -- Preparo titleBar
    myApp.titleBar.setTitleBar("gestioneTarghe", "Gestione Targhe", { 
        indietro = true,
        modifica = true,
        fine = false
    })
    myApp.titleBar.modifica.func = inizioModifica
    myApp.titleBar.fine.func = fineModifica

    scrollView = widget.newScrollView
    {
        top = myApp.titleBar.height,
        left = 0,
        width =  _W,
        height = _H - myApp.titleBar.height,
        scrollWidth = _W,
        scrollHeight = 0,
        horizontalScrollDisabled = true,
        isBounceEnabled = false,
        hideBackground = true,
    }

    -- Star image

    local optionsStar = {
        width = 30,
        height = 30,
        numFrames = 2,
        sheetContentWidth = 60,
        sheetContentHeight = 30,
    }

    local starImage = graphics.newImageSheet( "img/star_sheet.png", optionsStar )

    

    -- Testo info

    local posY = scrollView.height * 0.09

    textInfo = 'Qui puoi gestire le tue targhe registrate, aggiungerne di nuove o eliminare le inserite. '
    textEditInfoPrincipale = "Per modificare la targa principale selezionane un'altra con la stella"
    textEditInfoResidente = "Per modifica la targa agevolata selezionane un'altra con la stella"

    local optionsInfo = {
        text = textInfo,
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 16,
        width = _W-30,
        align = "center"
    }
    infoText = display.newText( optionsInfo )
    infoText:setFillColor( 0, 0, 0 )

    starInfo = display.newImage( starImage, 1 )
    starInfo.x = _W * 0.89
    starInfo.y = posY+7
    starInfo.width = 22.5
    starInfo.height = 22.5
    starInfo.alpha = 0



    -- -- Titolo Targa Principale o Agevolata

    -- posY = posY + 75

    -- local text

    -- if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente'then
    --     text = "TARGA AGEVOLATA"
    -- else
    --     text = "TARGA PRINCIPALE"
    -- end

    -- local titleT = newTitle(text, _W * 0.5, posY, _W, 50, 20, true)


    -- -- Stampa Targa Principale o Agevolata

    -- posY = posY + 50

    -- local optionsTarga = {
    --     text = myApp.utenti[myApp.utenteLoggato].targa,
    --     x = _W*0.5,
    --     y = posY,
    --     font = myApp.font,
    --     fontSize = 20,
    --     align = "center"
    -- }
    -- targaText = display.newText( optionsTarga )
    -- targaText:setFillColor( 0, 0, 0 )


    -- Titolo Targhe Registrate

    posY = posY + 70

    -- local titleR = newTitle("TARGHE REGISTRATE", _W * 0.5, posY, _W, 50)
    local titleR = newTitle("TARGHE UTENTE", _W * 0.5, posY, _W, 50, 20, true)


    -- Stampa tabella targhe

    posY = posY + 24

    listaTarghe = library.makeList("targhe", myApp:getTargheUtente(myApp.utenteLoggato), 0, posY, _W, 50, {x = 40}, nil, nil, scrollView)

    -- Creazione pulsanti per eliminazione e star nella lista di targhe

    for i=1, myApp:getNumTargheUtente(myApp.utenteLoggato) do
        
        rowDelete[i] = widget.newButton({
            id = i,
            top = listaTarghe.y + 50 * (i -1),
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
            top = listaTarghe.y + 50 * (i - 1) + 12,
            left = _W*0.025 ,
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

    end

    -- Button di editing

    BtAggiungi = widget.newButton({
        id  = 'BtAggiungi',
        label = 'Aggiungi targa...',
        x = _W*0.08,
        y = listaTarghe.height + listaTarghe.y,
        height = 50,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 20,
        align = 'center',
        onRelease =  aggiungiButton
    })
    BtAggiungi.anchorX = 0
    BtAggiungi.anchorY = 0

    
    BtModifica = widget.newButton({
        id  = 'BtModifica',
        label = 'Gestisci targhe',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease =  inizioModifica
    })
    BtModifica.isVisible = false

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


    borderBottomScroll = display.newLine( 0, BtAggiungi.y + BtAggiungi.height, _W, BtAggiungi.y + BtAggiungi.height)
    borderBottomScroll:setStrokeColor( 0.8, 0.8, 0.8 )  

    scrollView:insert(infoText)
    scrollView:insert(starInfo)
    -- scrollView:insert(titleT)
    -- scrollView:insert(targaText)

    scrollView:insert(titleR)
    scrollView:insert(listaTarghe)

    for i = 1, #rowDelete do
        scrollView:insert(rowDelete[i])
        scrollView:insert(rowStar[i])
    end

    scrollView:insert(BtAggiungi)
    scrollView:insert(borderBottomScroll)
    if borderBottomScroll.y > scrollView.height then
        scrollView:setScrollHeight( borderBottomScroll.y)
    else
        scrollView:setScrollHeight( scrollView.height)
    end

    group:insert(scrollView)


    group:insert(BtModifica)  
    group:insert(BtFine)



   
end





function newTitle(text, x, y, width, height, fontSize, background)

    local group = display.newGroup( )

    -- Stampo titoli sezioni
    local title = display.newText
    {
        text = text,
        x = x,
        y = y,
        font = myApp.font,
        fontSize = fontSize,
        align = "center",
        height = 0
    }
    title:setFillColor( 0, 0, 0 )

    if background then

        local bg = display.newRect( 0, y, width, height)
        bg.anchorX = 0
        bg:setFillColor( 0.95,0.95,0.95 )

        local line = display.newLine( group, 0, height / 2 + y, width, height / 2 + y)
        line:setStrokeColor( 0.8, 0.8, 0.8 )

        group:insert(bg)
        group:insert(line)

    end

    group:insert(title)

    return group

end

function inizioModifica()

    -- Cambia info text in base utente

    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente'then
        infoText.text = textEditInfoResidente
    else
        infoText.text = textEditInfoPrincipale
    end

    isClickable = true

    -- Mostra i controlli di modifica

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        rowStar[i].isVisible = true
        if i == myApp.utenti[myApp.utenteLoggato].targaSelezionata then
            indexToSaved = i
            rowDelete[i].isVisible = false
        else
            rowDelete[i].isVisible = true
        end
    end

    starInfo.alpha = 1
    myApp.titleBar.modifica.isVisible = false
    myApp.titleBar.fine.isVisible = true


end


function fineModifica()

    --infoText.text = textInfo

    myApp.utenti[myApp.utenteLoggato].targaSelezionata = indexToSaved

    local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)

    myApp.utenti[myApp.utenteLoggato].targa = targheUtente[indexToSaved]

    isClickable = false

    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    for i=1, numTarghe do
        if rowStar[i].isOn == false then
            rowDelete[i].isVisible = false
            rowStar[i].isVisible = false
        end
    end

    myApp.titleBar.modifica.isVisible = true
    myApp.titleBar.fine.isVisible = false

end


function aggiungiButton()
    require("profilo_gestione_targhe_verifica")
    storyboard.gotoScene( 'gestioneVerifica0', { effect = "slideLeft", time = 500 } )
end


local function listenerRecreateList( event )

    -- Ricreazione lista perchè gli indici 
    -- della tabella non vengono aggiornati automaticamente

    -- Ricreo lista
    listaTarghe:removeSelf( )
    listaTarghe = library.makeList("targhe", myApp:getTargheUtente(myApp.utenteLoggato), 0, listaTarghe.y, _W, 50, {x = 40}, nil, nil, scrollView)
    scrollView:insert(listaTarghe)

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
                transition.to( rowDelete[i], { time = 480, delay = 430, x =(rowDelete[i].x), y =(rowDelete[i].y-50) } )
            end
            transition.to( BtAggiungi, { time = 480, delay = 430, x =(BtAggiungi.x), y =(BtAggiungi.y-50) } )  
            transition.to( borderBottomScroll, { time = 480, delay = 430, x =(borderBottomScroll.x), y =(borderBottomScroll.y-50) } )  

            if index < myApp.utenti[myApp.utenteLoggato].targaSelezionata then
                myApp.utenti[myApp.utenteLoggato].targaSelezionata = myApp.utenti[myApp.utenteLoggato].targaSelezionata-1
            end

            timer.performWithDelay(910,  listenerRecreateList)

        end
    end
end



function selezionaStar( event )

    --Seleziona targa principale o agevolata

   if isClickable == true then

        local index = event.target.id

        indexToSaved = index

        local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)

        for i=1, numTarghe do
            if i == index then
                rowDelete[i].isVisible = false
            else
                rowDelete[i].isVisible = true
            end
        end
        --targaText.text = targheUtente[index]
    end


end
    

function scene:enterScene( event )
    print("ENTRA SCENA GESTIONE TARGHE")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA GESTIONE TARGHE")
    myApp.titleBar.modifica.isVisible = false
    myApp.titleBar.fine.isVisible = false
    listaTarghe:removeSelf()
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA GESTIONE TARGHE")
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
