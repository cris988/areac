local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local views = {}
local modificaDati = {}
local fineModifica = {}


-- variabili
local modifica
local fine







function scene:createScene(event)
    local group = self.view

    print("CREA SCENA GESTIONE TARGHE")

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    modifica = widget.newButton({
        id  = 'BtModifica',
        label = 'Modifica targhe',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease =  modificaDati
    })
    group:insert(modifica)

   
end








function modificaDati()

end


function fineModifica()
    if campoInserimentoCell.text == '' or campoInserimentoEmail.text == '' then

    else
        salvaUtente()
        storyboard.reloadScene( )
    end
end









function salvaUtente()
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            cf = myApp.utenti[myApp.utenteLoggato].cf,
            patente = myApp.utenti[myApp.utenteLoggato].patente,
            via = myApp.utenti[myApp.utenteLoggato].via,
            civico = myApp.utenti[myApp.utenteLoggato].civico,
            cap = myApp.utenti[myApp.utenteLoggato].cap,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    elseif myApp.utenti[myApp.utenteLoggato].tipo == 'Disabile' then
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            pass = myApp.utenti[myApp.utenteLoggato].pass,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    else
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    end
end









function scene:enterScene( event )
    print("ENTRA SCENA GESTIONE TARGHE")


    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Gestione targhe"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = 'profilo'
    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }

    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

    myApp.titleBar.modifica.isVisible = true

    myApp.tabBar.isVisible = false
end

function scene:exitScene( event )
    print("ESCI SCENA GESTIONE TARGHE")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA GESTIONE TARGHE")
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
