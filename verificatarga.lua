local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local goBack = {}
local accediProfilo = {}
local inputTarga = {}
local AvantiScene = {}

-- variabili
local accedi
local avanti
local titleBar
local titleText
local titleText
local locationtxt
local campoTarga

local string = "Inserisci la targa\nper controllare se il tuo\nveicolo è adibito ad accedere\nall\'area C e con che modalità"



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

    ------ instanzio nav bar e bottoni
    titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Verifica targa', 0, 0, myApp.fontBold, 20 )
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


    -- local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    -- statusBarBackground.x = display.contentCenterX
    -- statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    -- group:insert(statusBarBackground)

    local options = {
        text = string,
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 18,
        align = "center"
    }
    --Output the text box with the specified options
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)


    campoTarga = display.newImageRect('img/textArea.png', 564*0.5, 62*0.5)
    campoTarga.x = _W*0.5
    campoTarga.y = _H*0.45
    -- campoTarga = native.newTextField( _W*0.5, _H*0.45, _W*0.60, 35, inputTarga)
    -- campoTarga:addEventListener( "userInput", inputTarga )
    group:insert(campoTarga)


    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = AvantiScene
    })

end





function inputTarga( event )
    phase = event.phase
    if phase == 'began' then
        native.setKeyboardFocus( campoTarga )
    end
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
