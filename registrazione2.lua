local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}
local checkBoxListener = {}

-- variabili
local checkNonRes
local checkRes
local checkDis
local txtNome
local txtCognome


function scene:createScene(event)

    print("CREA SCENA REGISTRAZIONE2")

    local group = self.view

    -- Background

    library.setBackground(group, _Background )

	-- testo in alto
    local options = {
        text = 'Inserisci nome, cognome e selezione la tipologia alla quale appartieni:',
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
    txtNome =library.textArea(group,_W*0.5, _H*0.35, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Nome")
    print("NOME: "..txtNome.campo.text)
    txtCognome =library.textArea(group,_W*0.5, _H*0.45, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Cognome")
    print("COGNOME: "..txtCognome.campo.text)

    -- creazione dei checkBox

    checkNonRes = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.6,
       style = "checkbox",
       id = "Non residente",
       initialSwitchState = true,
       onPress = checkBoxListener
    }
     
    checkRes = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.7,
       style = "checkbox",
       id = "Residente",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    checkDis = widget.newSwitch
    {
       x = _W*0.15,
       y = _H*0.8,
       style = "checkbox",
       id = "Disabile",
       initialSwitchState = false,
       onPress = checkBoxListener
    }

    
    local textNonRes = display.newText('Non residente a Milano', _W*0.25, _H*0.6, myApp.font, 20)
    textNonRes:setFillColor( 0 )
    textNonRes.anchorX = 0
    local textRes = display.newText('Residente a Milano', _W*0.25, _H*0.7, myApp.font, 20)
    textRes:setFillColor( 0 )
    textRes.anchorX = 0
    local textDis = display.newText('Disabile', _W*0.25, _H*0.80, myApp.font, 20)
    textDis:setFillColor( 0 )
    textDis.anchorX = 0

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
    group:insert(txtNome)
    group:insert(txtCognome)
    group:insert(checkNonRes)
    group:insert(checkRes)
    group:insert(checkDis)
    group:insert(textNonRes)
    group:insert(textRes)
    group:insert(textDis)
    group:insert(BtAvanti)


    -- Recupero dati in memoria
    if myApp.datiUtente.nome ~= '' then
        txtNome.campo.text = myApp.datiUtente.nome
        txtCognome.campo.text = myApp.datiUtente.cognome

        if myApp.datiUtente.tipo == 'Non residente' then
            checkNonRes:setState( { isOn = true } )
            checkRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif myApp.datiUtente.tipo == 'Residente' then
            checkRes:setState( { isOn = true } )
            checkNonRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif myApp.datiUtente.tipo == 'Disabile' then
            checkDis:setState( { isOn = true } )
            checkRes:setState( { isOn = false } )
            checkNonRes:setState( { isOn = false } )
        end

    end
end


-- Inibisce la doppia selezione dei checkBox
function checkBoxListener( event )
    if event.target.isOn then
        if event.target.id == 'Residente' then
            checkNonRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        elseif event.target.id == 'Disabile' then
            checkNonRes:setState( { isOn = false } )
            checkRes:setState( { isOn = false } )
        else
            checkRes:setState( { isOn = false } )
            checkDis:setState( { isOn = false } )
        end
    else 
        event.target:setState( { isOn = true } )
    end
end



function avantiButton()
    local nome = txtNome.campo.text
    local cognome = txtCognome.campo.text

    local utente =  myApp.datiUtente

	if 	nome ~= '' or cognome ~= '' then

        utente.nome = library.trimString( nome )
        utente.cognome = library.trimString( cognome )

		if checkNonRes.isOn then
            utente.tipo = 'Non residente'
            storyboard.gotoScene('riepilogo', { effect = "slideLeft", time = 500 } )
        elseif checkRes.isOn then
            utente.tipo = 'Residente'
            storyboard.gotoScene('registrazione_res', { effect = "slideLeft", time = 500 } )
        elseif checkDis.isOn then
            utente.tipo = 'Disabile'
            storyboard.gotoScene('registrazione_dis', { effect = "slideLeft", time = 500 } )
        end

	end
end




function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE2")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE2")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE2")
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
