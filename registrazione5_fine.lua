--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

--[[
    
    registrazione5_fine.lua

        Conferma della registrazione
        Rimanda alla home

]]--

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local fineButton = {}

-- variabili


function scene:createScene(event)
    local group = self.view

    print("CREA SCENA REGISTRAZIONE FINE")


    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"

    local options = {
        text = 'Registrazione avvenuta\ncon successo!',
        x = _W*0.5,
        y = _H*0.45,
        width = _W - 30,
        fontSize = 24,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor(0.1333,0.54509,0.13334)

    local optionsProfilo = {
        text = 'Potrai consultare i tuoi dati nel Profilo',
        x = _W*0.5,
        y = _H*0.575,
        width = _W - 30,
        fontSize = 20,
        align = "center"
    }
    local textProfilo = display.newText( optionsProfilo )
    textProfilo:setFillColor( 0,0,0 )

    local BtFine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = fineButton
    })


    group:insert(areaT)
    group:insert(textProfilo)
    group:insert(BtFine)

    return group
end



function fineButton()
    myApp.titleBar.annulla.isVisible = false
    myApp.titleBar.indietro.isVisible = false
    myApp.showHome()
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
