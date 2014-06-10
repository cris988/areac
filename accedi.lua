local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local registrazioneScene = {}
local accediScene = {}

-- variabili
local txtUser
local txtPass
local textError



function scene:createScene(event)

    print("CREA SCENA ACCEDI")

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Profilo utente"
    myApp.titleBar.indietro.isVisible = true
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false
    myApp.titleBar.profilo.isVisible = false

	local group = self.view

    -- Background

    library.setBackground(group, _Background)

    -- Imposto effetti indietro
    indietroEffect = myApp.titleBar.indietro.effect.effect
    myApp.titleBar.indietro.func = function () 
        myApp.titleBar.indietro.effect.effect = "fromTop"
        myApp.tabBar.isVisible = true
    end

    -- Contenuto

    local profiloImg = display.newImage('img/profilo.png', _W*0.5, _H*0.25)
	group:insert(profiloImg)

	local optionsReg = {
		text = 'Se non hai mai effettuato la registrazione su quest\'applicazione o sul sito \"areaC.it\":',
		x = _W*0.5,
		y = _H*0.4,
		width = _W-30,
		fontSize = 16,
        align = "center",
        font = myApp.font
	}
	
	local regText = display.newText( optionsReg )
    regText:setFillColor(0) 

    local BtRegistrati = widget.newButton({
        id  = 'BtRegistrati',
        label = 'Registrati',
        x = _W*0.5,
        y = _H*0.5,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 22,
        onRelease = registrazioneScene
    })

    local optionsAccedi = {
		text = 'altrimenti accedi con le tue credenziali',
		x = _W*0.5,
		y = _H*0.6,
		width = _W-30,
		fontSize = 16,
        align = "center",
        font = myApp.font
	}
	
	local accediText = display.newText( optionsAccedi )
    accediText:setFillColor(0) 

    -- Text field dati
    txtUser =library.textArea(group,_W*0.5, _H*0.675, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Username")
    txtPass =library.textArea(group,_W*0.5, _H*0.775, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Password", true)

    -- Testo di errore
    textError = display.newText('DATI NON CORRETTI',_W*0.5,_H*0.835, myApp.font, 13)
    textError:setFillColor( 1, 0, 0 )
    textError.alpha = 0


    local BtAccedi = widget.newButton({
        id  = 'BtAccedi',
        label = 'Accedi',
        x = _W*0.5,
        y = _H*0.9,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 22,
        onRelease = accediScene
    })


    -- Inserimento nel gruppo
    group:insert(regText)
    group:insert(BtRegistrati)
    group:insert(accediText)
    group:insert(txtUser)
    group:insert(txtPass)
    group:insert(textError)
    group:insert(BtAccedi)
    
end

function registrazioneScene()
    storyboard.gotoScene('registrazione', { effect = "slideLeft", time = 500 } )
end




function accediScene()
    if txtUser.campo.text ~= '' or txtPass.campo.text ~= '' then
        local indice = myApp:getNumUtenti()
        local loggato = false

        for i = 1, indice, 1 do
            if myApp.utenti[i].username == library.trimString( txtUser.campo.text ) and
                myApp.utenti[i].password == library.trimString( txtPass.campo.text ) then

                myApp.utenteLoggato = i
                loggato = true
                myApp.story.back() -- Rimuovo accedi dalla storia
                storyboard.gotoScene('profilo')
            end
        end

        if loggato == false then
            txtUser.campo:setTextColor( 1, 0, 0 )
            txtPass.campo:setTextColor( 1, 0, 0 )
             -- testo di errore
            textError.alpha = 1
        end

    end 
end



function scene:enterScene( event )
    print("ENTRA SCENA ACCEDI")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA ACCEDI")

    -- Ripristino effetti indietro
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.indietro.func = nil
    myApp.titleBar.indietro.effect.effect = indietroEffect
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA ACCEDI")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
