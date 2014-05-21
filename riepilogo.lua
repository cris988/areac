local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local AvantiScene = {}
local salvaUtente = {}


-- variabili
local indietro
local textDati
local avanti


function scene:createScene(event)
    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)


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
    areaT:setFillColor{ 255,0,0 }
    group:insert(areaT)




    local txt = {}
    txt[1] = 'Username:\t' .. myApp.datiUtente.username .. '\n'
    txt[2] = 'Nome:\t' .. myApp.datiUtente.nome .. '\n'
    txt[3] = 'Cognome:\t' .. myApp.datiUtente.cognome .. '\n'
    if storyboard.getPrevious() == 'registrazione3' then
        txt[4] = 'Codice fiscale:\t' .. myApp.datiUtente.cf .. '\n'
        txt[5] = 'Numero patente:\t' .. myApp.datiUtente.patente .. '\n'
        txt[6] = 'Via:\t' .. myApp.datiUtente.via .. '\n'
        txt[7] = 'Numero civico:\t' .. myApp.datiUtente.civico .. '\n'
        txt[8] = 'CAP:\t' .. myApp.datiUtente.cap .. '\n'
    elseif storyboard.getPrevious() == 'registrazione4' then    
        txt[4] = 'Pass:\t' .. myApp.datiUtente.pass .. '\n'
    end





    textDati = native.newTextField(_W*0.5,_H*0.615, _W-30, _H*0.55)

    if storyboard.getPrevious() == 'registrazione2' then
        textDati.text = txt[1]..'\n'..txt[2]..'\n'..txt[3]..'\nTipo:\tNon residente a Milano'
        textDati.size = 17
    elseif storyboard.getPrevious() == 'registrazione3' then
        textDati.text = txt[1]..'\n'..txt[2]..'\n'..txt[3]..'\n'..txt[4]..'\n'..txt[5]..'\n'..txt[6]..'\n'..txt[7]..'\n'..txt[8]
    elseif storyboard.getPrevious() == 'registrazione4' then
        textDati.text = txt[1]..'\n'..txt[2]..'\n'..txt[3]..'\n'..txt[4]
    
    end
    textDati.align = 'left'
    textDati.font = native.newFont( myApp.fontSize, 19 )
    textDati.hasBackground = false
    textDati:setTextColor(0)
    
    group:insert(textDati)

    -- group:insert(textDati)

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = AvantiScene
    })
    group:insert(avanti)



end




function AvantiScene()

    salvaUtente()

    storyboard.gotoScene('mappa')
end





function salvaUtente()
    local i = myApp:getNumUtenti()
    if myApp.datiUtente.tipo == 'Residente' then
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            targa  = myApp.datiUtente.targa,
            cellulare = myApp.datiUtente.cellulare,
            email = myApp.datiUtente.email,
            cf = myApp.datiUtente.cf,
            patente = myApp.datiUtente.patente,
            via = myApp.datiUtente.via,
            civico = myApp.datiUtente.civico,
            cap = myApp.datiUtente.cap,
        }
    elseif myApp.datiUtente.tipo == 'Disabile' then
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            pass = myApp.datiUtente.pass,
        }
    else
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
        }
    end

    myApp.utenteLoggato = i+1
end















function scene:enterScene( event )
    print("ENTRA SCENA RIEPILOGO")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = storyboard.getPrevious()
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false

end

function scene:exitScene( event )
    print("ESCI SCENA RIEPILOGO")
    myApp.tabBar:setSelected( 1 )
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA RIEPILOGO")
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
