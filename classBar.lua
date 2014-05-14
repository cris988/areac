local classBar = {}

local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 

--local titleText

function classBar:disegna()
	local titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
	titleBar.x = display.contentCenterX
	titleBar.y = 25 + display.topStatusBarContentHeight


	classBar.titleText = display.newText( '', 0, 0, myApp.fontBold, 20 )
	classBar.titleText:setFillColor(0,0,0)
	classBar.titleText.x = display.contentCenterX
	classBar.titleText.y = titleBar.height * 0.5 + display.topStatusBarContentHeight


	classBar.accedi = widget.newButton({
	    id  = 'BtAccedi',
	    label = 'Accedi',
	    x = display.contentCenterX*1.75,
	    y = titleBar.height * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = myApp.AccediProfilo
	})


	classBar.profilo = widget.newButton({
	    id  = 'BtProfilo',
	    label = 'Profilo',
	    x = display.contentCenterX*1.75,
	    y = titleBar.height * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = myApp.showScreen4
	})
	classBar.profilo.isVisible = false


	classBar.indietro = widget.newButton({
	    id  = 'BtIndietro',
	    label = 'Indietro',
	    x = display.contentCenterX*0.3,
	    y = titleBar.height * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = myApp.goBack
	})
	classBar.indietro.isVisible = false
end




function myApp.goBack()
    storyboard.removeAll()
    -- local sceneName = storyboard.getCurrentSceneName()
    -- storyboard.removeScene( name )
    myApp.tabBar.isVisible = true
    classBar.indietro.isVisible = false
    storyboard.gotoScene(storyboard.getPrevious())
end

function myApp.AccediProfilo()
    --storyboard.removeAll()
    myApp.tabBar.isVisible = false
    classBar.accedi.isVisible = false
    classBar.indietro.isVisible = true
    storyboard.gotoScene("accedi")
end




return classBar