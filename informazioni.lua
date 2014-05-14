local storyboard = require ('storyboard')
local scene = storyboard.newScene()

local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

local _H = display.contentHeight
local _W = display.contentWidth
local titleBarHeight = 50
local right_padding = 10
local listaInfo
local accedi

local strings = {}
strings[1] = 'Cos\'è l\'area C'
strings[2] = 'informazioni varie'
strings[3] = 'Varchi e orari'
strings[4] = 'Veicoli autorizzatti all\'acceso'
strings[5] = 'Tariffe e pagamenti'
strings[6] = 'Come cambiare targa'
strings[7] = 'Come modificare i dati personali'


local titleText
local locationtxt
local titleBar
local titleText
local views = {}
local goToAccedi = {}
local onRowRender = {}
local onRowTouch = {}
local makeList = {}
local goBack = {}
local accediProfilo = {}


local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

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
 --    background.x = display.contentCenterX
 --    background.y = display.contentCenterY
	-- group:insert(background)

 --    local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
 --    statusBarBackground.x = display.contentCenterX
 --    statusBarBackground.y = display.topStatusBarContentHeight * 0.5
 --    group:insert(statusBarBackground)
    

    makeList()

    group:insert(listaInfo)
end

function makeList()
    listaInfo = widget.newTableView
    {
        left = 0,
        top = 70,
        height = _H-70,
        width = _W,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener,
        isLocked = false
    }
    for i = 1, 7 do

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

function AccediProfilo()
    storyboard.removeAll()
    storyboard.gotoScene("accedi", { params = { var = 0 } })
end

function goBack()
    storyboard.removeAll()
    -- local sceneName = storyboard.getCurrentSceneName()
    -- storyboard.removeScene( name )
    storyboard.gotoScene(storyboard.getPrevious())
end


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





function onRowTouch( event )
    local row = event.target

    print('sono in onRowT')
    if event.phase == "release" or event.phase == 'tap' then
        print ('var informazioni ' .. event.target.index)
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





function scene:enterScene( event )
	local group = self.view
    --storyboard.reloadScene()
    --listaInfo:reloadData()

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

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
