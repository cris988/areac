local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local goBack = {}
local accediProfilo = {}
local acquistaTicket = {}
local checkBoxListener = {}
local makeList = {}
local onRowRender = {}
local onRowTouch = {}


-- variabili
local indietro
local accedi
local titleBar
local titleText
local targa
local accesso
local acquista
local checkGiornaliero
local checkMultiplo
local checkboxSelected = true
local listaInfo
local right_padding = 10






-- titoli delle informazioni
local strings = {}
strings[1] = 'Varchi e orari'
strings[2] = 'Tariffe e metodi di pagamento'













function scene:createScene(event)
    local group = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

	------ instanzio nav bar e bottoni
	titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Profilo', 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor(0,0,0)
    titleText.x = display.contentCenterX
    titleText.y = titleBarHeight * 0.5 + display.topStatusBarContentHeight

	indietro = widget.newButton({
	    id  = 'BtIndietro',
	    label = 'Indietro',
	    x = display.contentCenterX*0.3,
	    y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = goBack
	})
	accedi = widget.newButton({
        id  = 'BtAccedi',
        label = 'Accedi',
        x = display.contentCenterX*1.75,
        y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 18,
        onRelease = AccediProfilo
    })
	group:insert(titleBar)
    group:insert(titleText)
    group:insert(indietro)
    group:insert(accedi)

    myApp.targaAcquista = event.params.targa





    accesso = math.random(4)


    -- l'auto può transitare
    if accesso < 4 then
        local options = {
            text = 'Seleziona il ticket da acquistare per questa targa: '..myApp.targaAcquista,
            x = _W*0.5,
            y = 100,
            width = _W - 30,
            -- height = 300,
            fontSize = 16,
            align = "center"
        }
        local myText = display.newText( options )
        myText:setFillColor( 0 )
        group:insert(myText)







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

        group:insert(checkGiornaliero)
        group:insert(checkMultiplo)



        local textGiornaliero = display.newText('Giornaliero                      5 €', _W*0.57, 190, myApp.font, 20)
        textGiornaliero:setFillColor( 0 )
        group:insert(textGiornaliero)
        local textMultiplo = display.newText('Multiplo                         30 €', _W*0.57, 240, myApp.font, 20)
        textMultiplo:setFillColor( 0 )
        group:insert(textMultiplo)





        makeList()
        group:insert(listaInfo)



        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.80,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaTicket
        })
        group:insert(acquista)


    -- l'auto può transitare
    else
        local options = {
            text = 'Il veicolo con targa '..myApp.targaAcquista..'\nNON PUO\' ACCEDERE all\'area C',
            x = _W*0.5,
            y = _H*0.5,
            width = _W - 30,
            -- height = 300,
            fontSize = 18,
            align = "center"
        }
        local myText = display.newText( options )
        myText:setFillColor( 0 )
        group:insert(myText)
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
        height = 102,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener,
        isLocked = true,
        noLines = true,
        hideBackground = true,
    }
    for i = 1, #strings do

        local isCategory = false
        local rowHeight = 50
        local rowColor = { default={ 0.90196, 0.90196, 0.90196 }, over={ 1, 0.5, 0, 0.2 } }
        local lineColor = { 0.8, 0.8, 0.8 }

        -- Insert a row into the listaInfo
        listaInfo:insertRow(
            {
            isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            --lineColor = lineColor,
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


    row.bg = display.newRect( 0, 0, rowWidth, rowHeight )
    row.bg.anchorX = 0
    row.bg.anchorY = 0
    row.bg:setFillColor( 1, 1, 1 )

    row.rowTitle = display.newText( row, strings[row.index], 0, 0, myApp.font, 18 )
    row.rowTitle:setFillColor( 0 )
    row.rowTitle.anchorX = 0
    row.rowTitle.x = 20
    row.rowTitle.y = rowHeight * 0.5

    row.rowArrow = display.newImage( row, "img/rowArrow.png", false )
    row.rowArrow.x = row.contentWidth - right_padding
    row.rowArrow.anchorX = 1
    row.rowArrow.y = row.contentHeight * 0.5

    row:insert( row.bg )
    row:insert( row.rowTitle )
    row:insert( row.rowArrow )

end



-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        -- è il numero della riga della lista che è stato cliccato
        myApp.index = event.target.index
        storyboard.gotoScene('info1', { params = { var = event.target.index } })
    end
                
-- --[[ This part handles the swipe left and right to show and hide the delete button ]]--
--     if (event.phase == "swipeLeft") then
--             transition.to( rowGroup.del, {time=rowGroup.del.transtime,maskX=-rowGroup.del.width/2,onComplete=rowGroup.del.setActive} )
--     elseif (event.phase == "swipeRight") then
--             transition.to( rowGroup.del, {time=rowGroup.del.transtime,maskX=rowGroup.del.width/2,onComplete=rowGroup.del.setInactive} )
--     end
-- --[[ End of delete handling ]]--
 
--     return true
end
















function acquistaTicket()

end

function AccediProfilo()
    storyboard.removeAll()
    storyboard.gotoScene("accedi")
end
function goBack()
    storyboard.removeAll()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
    storyboard.gotoScene('acquista')
end











function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
 
    --
    -- Clean up native objects
    --

end


function scene:destroyScene( event )
    local group = self.view
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