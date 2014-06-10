local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}



-- variabili
local textError
local txtUser
local txtPass
local txtPassC
myApp.datiUtente = {}



function scene:createScene(event)

    print("CREA SCENA REGISTRAZIONE")

    local group = self.view

    -- Background

    library.setBackground(group, _Background )
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.annulla.isVisible = true

    myApp.datiUtente = {
        username = '',
        password = '',
        nome = '',
        cognome = '',
        tipo = ',',
        targa  = '',
        cellulare = '',
        email = '',
        cf = '',
        patente = '',
        via = '',
        civico = '',
        cap = '',
        pass = '',
    }


	-- testo in alto
    local options = {
        text = 'Inserisci le informazioni:',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )

    -- Text field dati
    txtUser =library.textArea(group,_W*0.5, _H*0.4, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Username")
    print("USERNAME: "..txtUser.campo.text)
    txtPass =library.textArea(group,_W*0.5, _H*0.55, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Password", true)
    print("PASSWORD: "..txtPass.campo.text)
    txtPassC =library.textArea(group,_W*0.5, _H*0.7, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Ripeti Password", true)

    -- Recupero dati in meoria
    if myApp.datiUtente.username ~= '' then
        txtUser.campo.text = myApp.datiUtente.username
    end

    -- Testo di errore
    textError = display.newText('LE PASSWORD NON CORRISPONDONO',_W*0.5,_H*0.8, myApp.font, 13)
    textError:setFillColor( 1, 0, 0 )
    textError.alpha = 0

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
    group:insert(txtPassC)
    group:insert(textError)
    group:insert(BtAvanti)

end


function avantiButton()
    local user = txtUser.campo.text
    local pass = txtPass.campo.text
    local passc = txtPassC.campo.text

	if 	user ~= '' or pass ~= '' or passc ~= '' then
		if pass == passc then

            myApp.datiUtente.username = library.trimString( user )
			myApp.datiUtente.password = library.trimString( pass )

			storyboard.gotoScene('registrazione2', { effect = "slideLeft", time = 500 })
        else
            pass:setTextColor( 1, 0, 0 )
            passc:setTextColor( 1, 0, 0 )

             -- testo di errore
            textError.alpha = 1
		end
	end
end





function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE")
    myApp.story.add(storyboard.getCurrentSceneName())

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
