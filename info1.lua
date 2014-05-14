local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local myApp = require('myapp')
local widget = require('widget')


local goBack = {}
local accediProfilo = {}


-- Variabili per muovere il mondo
_W = display.contentWidth
_H = display.contentHeight
local titleBarHeight = 50
local indietro
local accedi
local titleBar
local titleText
local var



local strings = {}
strings[1] = 'Cos\'è l\'area C'
strings[2] = 'informazioni varie'
strings[3] = 'Varchi e orari'
strings[4] = 'Veicoli autorizzatti all\'acceso'
strings[5] = 'Tariffe e pagamenti'
strings[6] = 'Come cambiare targa'
strings[7] = 'Come modificare i dati personali'










function scene:createScene(event)
    local group = self.view

    print ('sei in crea scena info')

    titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Informazioni', 0, 0, myApp.fontBold, 20 )
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
    group:insert(accedi)
    group:insert(indietro)
 
 --    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    -- background:setFillColor(0.9, 0.9, 0.9)
 --    background.x = display.contentCenterX
 --    background.y = display.contentCenterY
    -- group:insert(background)


    var = event.params.var
    myApp.index = var
    print ('var info ' .. var)
    local myText = display.newText( strings[var], _W*0.5, _H*0.5, myApp.font, 20 )
    myText:setFillColor(1) 
    group:insert(myText)

end


function AccediProfilo()
    --storyboard.removeAll()
    --scene:destroyScene(event)
    storyboard.gotoScene('accedi', { params = { var } })
end

function goBack()
    --storyboard.removeAll()
    storyboard.gotoScene(storyboard.getPrevious())
    scene:destroyScene()
    -- local sceneName = storyboard.getCurrentSceneName()
    -- storyboard.purgeScene( name )
end



------------------------------------------------------------------------
--
-- Viene chiamata appena la scena rientra 
-- sullo schermo
--
------------------------------------------------------------------------


function scene:enterScene( event )
    local group = self.view
    print ('entra scena info')
end

function scene:exitScene( event )
    local group = self.view

    print ('esci scena info')

    --
    -- Clean up native objects
    --

end

------------------------------------------------------------------------
--
-- Viene chiamata per rimuovere definitivamente la scena
--
--
------------------------------------------------------------------------

function scene:destroyScene( event )
    local group = self.view

    indietro.isVisible = false
    print ('distruggi scena info')
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