--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

--[[
    Storyboard registrazione:
                          ___________________                                          _________________________________
                         |                   | Residente -> registrazione2_res.lua -> |                                 | 
    registrazione.lua -> |registrazione1.lua | Disabile  -> registrazione2_dis.lua -> |  registrazione3_riepilogo.lua   | -> registrazione4_opzionale.lua -> registrazione5_fine.lua
                         |___________________| Tutti -------------------------------> |_________________________________|

    registrazione.lua

        L'utente sceglie username e password


]]--

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



function scene:createScene(event)

    print("CREA SCENA REGISTRAZIONE")

    local group = self.view

    -- Background

    library.setBackground(group, _Background )

    -- Preparo titleBar
    myApp.titleBar.setTitleBar("registrazione", "Registrazione", { 
        indietro = true,
        annulla = true
    })
    myApp.titleBar.indietro.func = function () myApp.titleBar.annulla.isVisible = false end
    

    myApp.datiUtente = {
        username = '',
        password = '',
        nome = '',
        cognome = '',
        tipo = ',',
        targa  = '',
        targaSelezionata = 1,
        cellulare = '',
        email = '',
        multiplo = 0,
        --Residenti
        accessi = 40,
        patente = '',
        via = '',
        cf = '',
        civico = '',
        cap = '',
        --Disabile
        pass =''
    } 
    
    if debugMode then
        myApp.datiUtente = {
            username = 'Marco',
            password = 'ciao',
            nome = 'Marco',
            cognome = 'Pluto',
            tipo = 'Residente',
            targa  = 'AA123AA',
            targaSelezionata = 1,
            cellulare = '3331234567',
            email = 'marco@marco.it',
            multiplo = 0,
            accessi = 40,
            cf = 'RMNDESH32U84Y235E',
            patente = 'de345ed',
            via = 'Via Monti',
            civico = '3',
            cap = '20100',
        }
    end

	-- testo in alto
    local options = {
        text = 'Inserisci username e password desiderate:',
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
    txtPass =library.textArea(group,_W*0.5, _H*0.55, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Password", true)
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
    group:insert(txtUser)
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
            
            print("USERNAME: "..txtUser.campo.text)
            print("PASSWORD: "..txtPass.campo.text)

            myApp.datiUtente.username = library.trimString( user )
			myApp.datiUtente.password = library.trimString( pass )

			storyboard.gotoScene('registrazione1', { effect = "slideLeft", time = 500 })
        else
            txtPass.campo:setTextColor( 1, 0, 0 )
            txtPassC.campo:setTextColor( 1, 0, 0 )

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
    myApp.titleBar.indietro.func = {}
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
