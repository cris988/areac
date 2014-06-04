local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local selezionaTarga = {}

-- variabili
local txtTarga

myApp.acquisto = {}

local string = "Da qui puoi acquistare un ticket giornaliero o multiplo per il tuo veicolo"


local function ignoreTouch( event )
	return true
end


function scene:createScene(event)

    print("CREA SCENA ACQUISTA")

	local group = self.view

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Acquista"
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.logo.isVisible = true
    
    myApp.tabBar.isVisible = true

    library.checkLogIn()

    -- Background

    library.setBackground(group, {1,1,1})

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = avantiButton
    })
    group:insert(avanti)

    textError = display.newText('',0,0)
    group:insert(textError)
    

    -- testo in alto
    local options = {
        text = string,
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local text1 = display.newText( options )
    text1:setFillColor( 0, 0, 0 )
    group:insert(text1)

    y = 0.5

    if myApp.utenteLoggato > 0 then
        
        targaReg = widget.newButton({
            id  = 'BtTargaReg',
            label = 'Seleziona targa registrata',
            x = _W*0.5,
            y = _H*0.4,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = selezionaTarga
        })
        group:insert(targaReg)

        -- testo in alto
        local options2 = {
            text = 'Oppure inserisci una nuova targa:',
            x = _W*0.5,
            y = _H*0.555,
            width = _W - 30,
            fontSize = 16,
            align = "center"
        }
        local text2 = display.newText( options2 )
        text2:setFillColor( 0, 0, 0 )
        group:insert(text2)

        y = 0.65
    
    end 

    txtTarga =library.textArea(_W*0.5, _H*y, 160, 28, {0.75,0.75,0.75}, native.newFont( myApp.font, 17 ), "center", "Targa")
    group:insert(txtTarga)

end

-- funzioni per pulsanti

function avantiButton ()
    if txtTarga.campo.text == '' then
    
    -- controllo se il formato della targa è giusto
    elseif #txtTarga.campo.text == 7 and txtTarga.campo.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
        myApp.acquisto.targa = library.trimString( txtTarga.campo.text ):upper()
        storyboard.gotoScene('acquista2', { effect = "slideLeft", time = 500 })
    else
       txtTarga.campo:setTextColor(1,0,0)
        -- testo di errore
        textError.x = _W*0.5
        textError.y = _H*0.555
        textError.fontSize = 12
        textError.text = 'FORMATO NON CORRETTO'
        textError:setFillColor( 1, 0, 0 )

        if myApp.utenteLoggato > 0 then
            textError.y = _H*0.725
        end
    end
end


function selezionaTarga()
    storyboard.gotoScene( 'gestione_targhe' )
end


function scene:enterScene( event )
    print("ENTRA SCENA ACQUISTA")
end

function scene:exitScene( event )
    print("ESCI SCENA ACQUISTA")

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA ACQUISTA")
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
