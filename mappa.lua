local storyboard = require ('storyboard')
local scene = storyboard.newScene()

local widget = require('widget')
local myApp = require('myapp')
local navBar = require('classBar')

widget.setTheme(myApp.theme)

local titleText
local locationtxt
local views = {}
--local goToAccedi = {}

local _H = display.contentHeight
local _W = display.contentWidth
local titleBarHeight = 50


local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

    navBar:disegna()
    navBar.titleText.text = 'Mappa'

    -- if ( system.getInfo( "environment" ) == "simulator" ) then
    --     local simulatorMessage = "Maps not supported in Corona Simulator.\nYou must build for iOS or Android to test native.newMapView() support."
    --     local allertMap = display.newText( simulatorMessage, _W*0.1, _H*0.40, _W*0.85, _H*0.4, native.systemFont, 16 )
    --     allertMap:setFillColor( 1, 0, 0 )
    --     allertMap.anchorX = 0
    --     allertMap.anchorY = 0
    -- end
    -- group:insert(allertMap)



    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)


    local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    statusBarBackground.x = display.contentCenterX
    statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    group:insert(statusBarBackground)


    local contornoMappa = display.newRect( display.contentCenterX, display.contentCenterY+8, _W, _H*0.7 )
    group:insert(contornoMappa)

    myMap = native.newMapView( display.contentCenterX, display.contentCenterY, _W, _H*0.7 )
    --myMap.x = display.contentCenterX
    --myMap.y = display.contentCenterY
    --myMap.mapType = "standard"
    --lat, long = myMap:getAddressLocation('Duomo di Milano')
    myMap:setCenter( 45.464224, 9.190321 )
    
    myMap:addMarker( 45.461462, 9.188465,
        { title = 'Varco Via Giuseppe Mazzini', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.477366, 9.180947,
        { title = 'Varco Via Legnano', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.477631, 9.181296,
        { title = 'Varco Via di Porta Tenaglia', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.478300, 9.181657,
        { title = 'Varco Via Moscova', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.480798, 9.182773,
        { title = 'Varco Via Volta', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.480328, 9.186689,
        { title = 'Varco Corso Garibaldi', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.480110, 9.187966,
        { title = 'Varco Via Milazzo', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.479637, 9.191952,
        { title = 'Varco Via Castelfidardo', subtitle = 'Aperto dalle 7:00 alle 18:00' })  
    myMap:addMarker( 45.479637, 9.191952,
        { title = 'Varco Via Turati', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.474100, 9.204687,
        { title = 'Varco Corso Venezia', subtitle = 'Aperto dalle 7:00 alle 18:00' })
    myMap:addMarker( 45.471534, 9.205188,
        { title = 'Varco Via Baretti', subtitle = 'Aperto dalle 7:00 alle 18:00' })

    myMap.isLocationVisible = true
    myMap.isZoomEnabled = true
    group:insert(myMap)
end


function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view

    --myMap:removeSelf()
	--
	-- Clean up native objects
	--

end

function scene:destroyScene( event )
	local group = self.view
    --myMap:removeSelf()
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
