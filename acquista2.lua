local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local acquistaTicket = {}
local checkBoxListener = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}
local infoView = {}
local goBackInfo = {}
local schermataAccesso = {}


-- variabili
local accedi
local targa
local accesso
local acquista
local checkGiornaliero
local checkMultiplo
local checkboxSelected = true
local listaInfo
local right_padding = 10
local myTextInfo
local indietroInfo
local titleTextInfo
local titleBarInfo
local backgroundInfo
local myText
local myText1
local myText2
local myText3
local textGiornaliero
local textMultiplo
local gruppoInfoView
local index



-- titoli delle informazioni
local strings = {}
strings[1] = 'Varchi e orari'
strings[2] = 'Tariffe e metodi di pagamento'



function scene:createScene(event)
    local group = self.view
    print('crea')

    myApp.tabBar.isVisible = true

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

    accesso = math.random(4)

    myApp.targaAcquista = event.params.targa

    schermataAccesso(accesso)


    if accesso < 4 then
        group:insert(myText)
        group:insert(checkGiornaliero)
        group:insert(checkMultiplo)
        group:insert(textGiornaliero)
        group:insert(textMultiplo)
        group:insert(listaInfo)
        group:insert(acquista)
    else
        group:insert(myText1)
        group:insert(myText2)
        group:insert(myText3)
    end


end


function schermataAccesso(numero)
    -- l'auto può transitare
    if numero < 4 then
        local options = {
            text = 'Seleziona il ticket da acquistare per questa targa: '..myApp.targaAcquista,
            x = _W*0.5,
            y = 100,
            width = _W - 30,
            -- height = 300,
            fontSize = 16,
            align = "center"
        }
        myText = display.newText( options )
        myText:setFillColor( 0 )







        -- creazione dei checkBox

        checkGiornaliero = widget.newSwitch
        {
           x = _W*0.10,
           y = 190,
           style = "checkbox",
           id = "Giornaliero",
           initialSwitchState = true,
           onPress = checkBoxListener
        }
         
        checkMultiplo = widget.newSwitch
        {
           x = _W*0.10,
           y = 240,
           style = "checkbox",
           id = "Multiplo",
           initialSwitchState = false,
           onPress = checkBoxListener
        }

        
        textGiornaliero = display.newText('Giornaliero                      5 €', _W*0.57, 190, myApp.font, 20)
        textGiornaliero:setFillColor( 0 )
        textMultiplo = display.newText('Multiplo                         30 €', _W*0.57, 240, myApp.font, 20)
        textMultiplo:setFillColor( 0 )


        makeList()
        

        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.80,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaTicket
        })
        


    -- l'auto può transitare
    else
        myText1 = display.newText( 'Il veicolo con targa '..myApp.targaAcquista,  _W*0.5, (_H*0.5)-25, myApp.font, 20)
        myText1:setFillColor(0)
        myText2 = display.newText( '\nNON PUO\' ACCEDERE',  _W*0.5, _H*0.5, myApp.font, 20)
        myText2:setFillColor(1,0,0)
        myText3 = display.newText( '\n\nall\'area C',  _W*0.5, (_H*0.5)+25, myApp.font, 20)
        myText3:setFillColor(0)  
    end
end




























-- Inibisce la doppia selezione dei checkBox
function checkBoxListener( event )
    if event.target.isOn then
        if event.target.id == 'Multiplo' then
            checkGiornaliero:setState( { isOn = false } )
        else
            checkMultiplo:setState( { isOn = false } )
        end
    end
end




















-- creo spazio per la lista
function makeList()
    listaInfo = widget.newTableView
    {
        x = _W*0.5,
        y = _H*0.6,
        height = 100,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        isLocked = true,
    }
    for i = 1, #strings do

        local isCategory = false
        local rowHeight = 50
        -- local rowColor = { default={ 230,230,230 }, over={ 255, 127, 0 } }
        -- local lineColor = { 220, 220, 220 }
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
        infoView()
    end
end

















function infoView()
    myApp.titleBar.indietro.isVisible = false
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

    backgroundInfo = display.newRect(0,0,display.contentWidth, display.contentHeight)
    backgroundInfo:setFillColor(0.9, 0.9, 0.9)
    backgroundInfo.x = display.contentCenterX
    backgroundInfo.y = display.contentCenterY

    ------ instanzio nav bar e bottoni
    titleBarInfo = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBarInfo.x = display.contentCenterX
    titleBarInfo.y = 25 + display.topStatusBarContentHeight

    titleTextInfo = display.newText( '', 0, 0, myApp.fontBold, 20 )
    titleTextInfo:setFillColor(0,0,0)
    titleTextInfo.x = display.contentCenterX
    titleTextInfo.y = bgTitle.height * 0.5 + 7
    if index == 1 then
        titleTextInfo.text = 'Varchi e orari'
    else
        titleTextInfo.text = 'Pagamenti'
    end

    indietroInfo = widget.newButton({
        id  = 'BtIndietroInfo',
        label = 'Indietro',
        x = display.contentCenterX*0.3,
        y = bgTitle.height * 0.5 + 7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 18,
        onRelease = goBackInfo
    })

    myApp.tabBar.isVisible = false

    -- scrivo le stringhe riferite all'indice
    myTextInfo = display.newText( strings[index], _W*0.5, _H*0.5, myApp.font, 20 )
    myTextInfo:setFillColor(0)
end

function goBackInfo()
    myTextInfo:removeSelf()
    indietroInfo:removeSelf()
    titleTextInfo:removeSelf()
    titleBarInfo:removeSelf()
    backgroundInfo:removeSelf()
    myApp.tabBar.isVisible = true
    myApp.titleBar.indietro.isVisible = true
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
end

















function acquistaTicket()

end






function scene:enterScene( event )
    print("ENTRA SCENA RIEPILOGO")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'acquista'
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end

end

function scene:exitScene( event )
    print("ESCI SCENA RIEPILOGO")
    
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA RIEPILOGO")
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
