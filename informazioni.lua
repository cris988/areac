local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

local scene = storyboard.newScene()


-- titolo dei menù delle informazioni
local strings = {}
strings[1] = 'Cos\'è l\'area C'
strings[2] = 'informazioni varie'
strings[3] = 'Varchi e orari'
strings[4] = 'Veicoli autorizzatti all\'acceso'
strings[5] = 'Tariffe e metodi di pagamento'
strings[6] = 'Come cambiare targa'
strings[7] = 'Come modificare i dati personali'


-- funzioni
local views = {}
local onRowRender = {}
local onRowTouch = {}
local makeList = {}


-- variabili
local right_padding = 10
local listaInfo
local locationtxt

local function ignoreTouch( event )
	return true
end

function scene:createScene(event)

    print("CREA SCENA INFORMAZIONI")
    
	local group = self.view

    makeList()

    group:insert(listaInfo)

end


-- creo spazio per la lista
function makeList()
    listaInfo = widget.newTableView
    {
        left = 0,
        top = 70,
        height = _H-70,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        -- listener = scrollListener,
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
end


-- imposto e riempio le righe della lista
function onRowRender( event )

    -- Get reference to the row group
    local row = event.row

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    local rowTitle = display.newText( row, strings[row.index], 0, 0, myApp.font, 18 )
    rowTitle:setFillColor( 0 )

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 20
    rowTitle.y = rowHeight * 0.5

    local rowArrow = display.newImage( row, "img/rowArrow.png", false )
    rowArrow.x = row.contentWidth - right_padding
    rowArrow.anchorX = 1
    rowArrow.y = row.contentHeight * 0.5
end



-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        -- è il numero della riga della lista che è stato cliccato
        myApp.index = event.target.index
        storyboard.gotoScene('info_details', { params = { var = event.target.index } })
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


------ EVENTI SCENA -------

function scene:enterScene( event )
    print("ENTRA SCENA INFORMAZIONI")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Informazioni"
    myApp.titleBar.indietro.isVisible = false
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
end

function scene:exitScene( event )
    print("ESCI SCENA INFORMAZIONI")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA INFORMAZIONI")
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
