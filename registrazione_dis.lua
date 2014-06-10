local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}

-- variabili

local txtPass


function scene:createScene(event)

    print("CREA SCENA REGISTRAZIONE DISABILI")

    local group = self.view

    -- Background

    library.setBackground(group, _Background )

    -- testo in alto
    local options = {
        text = 'Inserisci il numero del Pass per disabile',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor{ 255,0,0 }


    -- Text field dati
    txtPass =library.textArea(group,_W*0.5, _H*0.5, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Numero Pass")


    local BtAvanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = avantiButton
    })
    
    group:insert(areaT)
    group:insert(txtPass)
    group:insert(BtAvanti)



    -- Recupero dati in memoria
    if myApp.datiUtente.pass ~= '' then
        txtPass.campo.text = myApp.datiUtente.pass
    end

end

function avantiButton()
    if txtPass.campo.text ~= '' then
        print("PASS: "..txtPass.campo.text)
        myApp.datiUtente.pass = library.trimString( txtPass.campo.text )
        storyboard.gotoScene('riepilogo', { effect = "slideLeft", time = 500 })
    end
end

function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE DISABILI")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE DISABILI")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE DISABILI")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
