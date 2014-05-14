local storyboard = require ('storyboard')
local scene = storyboard.newScene()

local widget = require('widget')
local myApp = require('myapp')
local navBar = require('classBar')

widget.setTheme(myApp.theme)

local titleText
local locationtxt
local views = {}
local goToAccedi = {}

local titleBarHeight = 50


local function ignoreTouch( event )
	return true
end






function scene:createScene(event)
	local group = self.view

	navBar:disegna()
	navBar.titleText.text = 'Verifica targa'

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

end


-- function goToAccedi(event)
--         --scene:exitScene(event)
--         --myApp.tabBar:removeSelf()
--         myApp.tabBar.isVisible = false
--         storyboard.gotoScene("accedi")
-- end



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
