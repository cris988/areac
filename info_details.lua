local storyboard = require( "storyboard" )
local myApp = require('myapp')
local widget = require('widget')

widget.setTheme(myApp.theme)

local scene = storyboard.newScene()

local section

-- è il contenuto di testo dei sottomenù delle informazioni
local strings = {}
strings[1] = 'Cos\'è l\'area C'
strings[2] = 'informazioni varie'
strings[3] = 'Varchi e orari'
strings[4] = 'Veicoli autorizzatti all\'acceso'
strings[5] = 'Tariffe e metodi di pagamento'
strings[6] = 'Come cambiare targa'
strings[7] = 'Come modificare i dati personali'



function scene:createScene(event)
    local group = self.view  

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

end

function scene:enterScene( event )
    local group = self.view

     -- è il numero della riga della lista che è stato cliccato
    section = event.params.var

    print("ENTRA SCENA INFO DETTAGLIO "..section)

    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.titleText.text = 'Info'

    -- scrivo le stringhe riferite a var
    myText = display.newText( strings[section], _W*0.5, _H*0.5, myApp.font, 20 )
    myText:setFillColor(0) 
    group:insert(myText)
end

function scene:exitScene( event )
    local group = self.view
    
    group:remove(myText)
    
    print("ESCI SCENA INFO DETTAGLIO "..section)

end

function scene:destroyScene( event )
    local group = self.view

    print("DISTRUGGI SCENA INFO DETTAGLIO "..section)
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