local storyboard = require( "storyboard" )
local scene = storyboard.newScene()




-- Variabili per muovere il mondo
_W = display.contentWidth
_H = display.contentHeight



function scene:createScene(event)
    local screenGroup = self.view

end

------------------------------------------------------------------------
--
-- Viene chiamata appena la scena rientra 
-- sullo schermo
--
------------------------------------------------------------------------


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

------------------------------------------------------------------------
--
-- Viene chiamata per rimuovere definitivamente la scena
--
--
------------------------------------------------------------------------

function scene:destroyScene( event )
    local group = self.view
    --myMap:removeSelf()
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