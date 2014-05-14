local storyboard = require ('storyboard')
local scene = storyboard.newScene()

local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

local titleText
local locationtxt
local views = {}
local goBack = {}
local accediProfilo = {}

local titleBarHeight = 50
local accedi
local titleBar
local titleText


local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

    titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Acquista', 0, 0, myApp.fontBold, 20 )
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
	-- background:addEventListener("touch", ignoreTouch)

 --    local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
 --    statusBarBackground.x = display.contentCenterX
 --    statusBarBackground.y = display.topStatusBarContentHeight * 0.5
 --    group:insert(statusBarBackground)


end


-- function goToAccedi(event)
--         --scene:exitScene(event)
--         --myApp.tabBar:removeSelf()
--         myApp.tabBar.isVisible = false
--         storyboard.gotoScene("accedi")
-- end


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
