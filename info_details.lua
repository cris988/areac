local storyboard = require( "storyboard" )
local myApp = require('myapp')
local widget = require('widget')

widget.setTheme(myApp.theme)

local scene = storyboard.newScene()

myApp.section = 1


function scene:createScene(event)

    print("CREA SCENA INFORMAZIONI "..myApp.section)

    local group = self.view  

    -- Preparo titleBar

    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.titleText.text = 'Info'

    library.checkLogIn()

    -- Background

    library.setBackground(group, _Background)

     -- scrivo le stringhe riferite a section
    if event.params ~= nil then
        myApp.section = event.params.var
    end
    
    local webView = native.newWebView( 0, myApp.titleBar.height , _W, _H - myApp.titleBar.height - myApp.tabBar.height )
    webView.anchorY = 0
    webView.anchorX = 0
    webView:request( "info"..myApp.section..".html", system.ResourceDirectory )
    group:insert(webView)

end

function scene:enterScene( event ) 
    print("ENTRA SCENA INFO DETTAGLIO "..myApp.section) 
    myApp.story.add(storyboard.getCurrentSceneName())
end
function scene:exitScene( event ) 
    print("ESCI SCENA INFO DETTAGLIO "..myApp.section)
    myApp.titleBar.indietro.isVisible = false
end
function scene:destroyScene( event )
    print("DISTRUGGI SCENA INFO DETTAGLIO "..myApp.section)
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene