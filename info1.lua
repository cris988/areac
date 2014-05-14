local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local navBar = require('classBar')
local myApp = require('myapp')




-- Variabili per muovere il mondo
_W = display.contentWidth
_H = display.contentHeight




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

    local var = event.params.var

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)

	navBar.indietro.isVisible = true

    print('var è ' .. var)

    local myText
    myText = display.newText( strings[var], _W*0.5, _H*0.5, myApp.font, 20 )
    myText:setFillColor(0) 
    group:insert(myText)

end

------------------------------------------------------------------------
--
-- Viene chiamata appena la scena rientra 
-- sullo schermo
--
------------------------------------------------------------------------


function scene:enterScene( event )
    local group = self.view
    navBar.indietro.isVisible = true

end

function scene:exitScene( event )
    local group = self.view

    navBar.indietro.isVisible = false

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
    navBar.indietro.isVisible = false
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