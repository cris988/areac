local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local completaButton = {}

-- variabili


function scene:createScene(event)
    local group = self.view

    print("CREA SCENA REGISTRAZIONE FINE")


    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"

    local options = {
        text = 'Registrazione completata con successo!',
        x = _W*0.5,
        y = _H*0.5,
        width = _W - 30,
        fontSize = 20,
        align = "center"
    }
    local areaT = display.newText( options )

    local BtProfilo = widget.newButton({
        id  = 'BtProfilo',
        label = 'Vai al tuo profilo',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = completaButton
    })


    group:insert(areaT)
    group:insert(BtProfilo)

    return group
end



function completaButton()
    storyboard.gotoScene('profilo')
end


function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE FINE")

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE FINE")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE FINE")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
