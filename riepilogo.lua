local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}


-- variabili


function scene:createScene(event)
    local group = self.view


    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Riepilogo"

    -- testo in alto
    local options = {
        text = 'Controlla con attenzione!\nQuesti dati NON saranno più modificabili dall\'applicazione.',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor(0,0,0) 

    -- testo in alto
    local optionsDati = {
        text = '',
        x = _W*0.5,
        y = _H*0.58,
        width = _W - 30,
        height = _H * 0.55,
        fontSize = 20,
        align = "lefts"
    }
    local textDati = display.newText(optionsDati)
    textDati:setFillColor(0,0,0) 

    -- Tutti
    textDati.text = 'Username:\t' .. myApp.datiUtente.username .. '\n\n' ..
                 'Nome:\t' .. myApp.datiUtente.nome .. '\n\n' ..
                 'Cognome:\t' .. myApp.datiUtente.cognome .. '\n\n'
    


    -- Residenti
    if myApp.datiUtente.tipo == 'Residente' then
        textDati.text = textDati.text .. 'Codice fiscale:\t' .. myApp.datiUtente.cf .. '\n\n' ..
                         'Numero patente:\t' .. myApp.datiUtente.patente .. '\n\n' ..
                         'Via:\t' .. myApp.datiUtente.via .. '\n\n' ..
                         'Numero civico:\t' .. myApp.datiUtente.civico .. '\n\n' ..
                         'CAP:\t' .. myApp.datiUtente.cap .. '\n\n'
    end
    -- Disabili
    if myApp.datiUtente.tipo == 'Disabile' then
        textDati.text = textDati.text .. 'Pass:\t' .. myApp.datiUtente.pass
    end

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
    group:insert(textDati)
    group:insert(BtAvanti)

end


function avantiButton()
    myApp.story.removeAll()
    myApp.titleBar.indietro.isVisible = false
    storyboard.gotoScene('registrazione_opzionale',  { effect = "slideLeft", time = 500 } )
end



function scene:enterScene( event )
    print("ENTRA SCENA RIEPILOGO")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA RIEPILOGO")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA RIEPILOGO")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )


return scene
