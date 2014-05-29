local storyboard = require( "storyboard" )
local myApp = require('myapp')
local widget = require('widget')

widget.setTheme(myApp.theme)

local scene = storyboard.newScene()

myApp.section = 1

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

    -- scrivo le stringhe riferite a section
    if event.params ~= nil then
        myApp.section = event.params.var
    end
    myText = display.newText( strings[myApp.section], _W*0.5, _H*0.5, myApp.font, 20 )
    myText:setFillColor(0) 
    group:insert(myText)

end

function scene:enterScene( event )
    print("ENTRA SCENA INFO DETTAGLIO "..myApp.section)

    -- Preparo titleBar

    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.titleText.text = 'Info'
    myApp.titleBar.logo.isVisible = false

    myApp.titleBar.indietro.scene = 'informazioni'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    if storyboard.getPrevious() == 'acquista2' then
        myApp.titleBar.indietro.scene = 'acquista2'
        myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500, params = { targa = myApp.targaAcquista } }
    end

    
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end

end

function scene:exitScene( event )    
    print("ESCI SCENA INFO DETTAGLIO "..myApp.section)

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA INFO DETTAGLIO "..myApp.section)
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