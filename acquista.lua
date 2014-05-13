local storyboard = require ('storyboard')
local scene = storyboard.newScene()

local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

local titleText
local locationtxt
local views = {}
local goToAccedi = {}


local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)
	background:addEventListener("touch", ignoreTouch)

    local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    statusBarBackground.x = display.contentCenterX
    statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    group:insert(statusBarBackground)
    
	--
    -- Create the other UI elements
    -- create toolbar to go at the top of the screen
    local titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight
    group:insert(titleBar)
    --
    -- set up the text for the title bar, will be changed based on what page
    -- the viewer is on

    -- create embossed text to go above toolbar
    titleText = display.newText( "Acquista", 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor( 0,0,0 )
    titleText.x = display.contentCenterX
    titleText.y = titleBar.height * 0.5 + display.topStatusBarContentHeight
    group:insert(titleText)

    local profilo = widget.newButton({
    id  = 'BtProfilo',
    label = 'Accedi',
    x = display.contentCenterX*1.75,
    y = display.contentCenterY*0.163,
    color = { 0.062745,0.50980,0.99607 },
    fontSize = 18,
    onRelease = goToAccedi
    })
    group:insert(profilo)
end


function goToAccedi(event)
        --scene:exitScene(event)
        --myApp.tabBar:removeSelf()
        myApp.tabBar.isVisible = false
        storyboard.gotoScene("accedi")
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

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
