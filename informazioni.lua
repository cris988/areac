local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


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
local goToAccedi = {}
local onRowRender = {}
local onRowTouch = {}
local makeList = {}
local goBack = {}
local accediProfilo = {}


-- variabili
local right_padding = 10
local listaInfo
local accedi
local titleText
local locationtxt
local titleBar




local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

    ------ instanzio nav bar e bottoni
    titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Informazioni', 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor(0,0,0)
    titleText.x = display.contentCenterX
    titleText.y = titleBarHeight * 0.5 + display.topStatusBarContentHeight

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
    group:insert(accedi)

	-- local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	-- background:setFillColor(0.9, 0.9, 0.9)
    -- background.x = display.contentCenterX
    -- background.y = display.contentCenterY
	-- group:insert(background)

    -- local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    -- statusBarBackground.x = display.contentCenterX
    -- statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    -- group:insert(statusBarBackground)
    
    
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









function AccediProfilo()
    storyboard.removeAll()
    storyboard.gotoScene("accedi")
end

function goBack()
    storyboard.removeAll()
    storyboard.gotoScene(storyboard.getPrevious())
end














function scene:enterScene( event )
	local group = self.view
end

function scene:exitScene( event )
	local group = self.view
    myApp.targaVerifica = nil
    
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
