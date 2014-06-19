--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

--[[

    registrazione2_res.lua

        L'utente residente inserisce il Codice Fiscale,
        il numero della Patente, l'indirizzo di residenza,
        il numero civico, il CAP

]]--

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}


-- variabili
local txtCF
local txtPatente
local txtIndirizzo
local txtCivico
local txtCAP



function scene:createScene(event)

    print("CREA SCENA REGISTRAZIONE RESIDENTI")

    local group = self.view


    -- Background

    library.setBackground(group, _Background )

    -- testo in alto
    local options = {
        text = 'Inserisci i tuoi dati personali. Non saranno più modificabili',
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
    txtCF =library.textArea(group,_W*0.5, _H*0.37, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Codice Fiscale")
    txtPatente =library.textArea(group,_W*0.5, _H*0.47, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Numero di patente")
    txtIndirizzo =library.textArea(group,_W*0.5, _H*0.57, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Via di domicilio")
    txtCivico =library.textArea(group,_W*0.5, _H*0.67, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Numero civico")
    txtCAP =library.textArea(group,_W*0.5, _H*0.77, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "CAP")



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
    group:insert(txtCF)
    group:insert(txtPatente)
    group:insert(txtIndirizzo)
    group:insert(txtCivico)
    group:insert(txtCAP)
    group:insert(BtAvanti)



    -- Recupero dati in memoria
    if myApp.datiUtente.cf ~= '' then

        txtCF.campo.text = myApp.datiUtente.cf
        txtPatente.campo.text = myApp.datiUtente.patente
        txtIndirizzo.campo.text = myApp.datiUtente.via
        txtCivico.campo.text = myApp.datiUtente.civico
        txtCAP.campo.text = myApp.datiUtente.cap

    end


end




function avantiButton()
    local cf = txtCF.campo.text
    local patente = txtPatente.campo.text
    local indirizzo =  txtIndirizzo.campo.text
    local civico =  txtCivico.campo.text
    local cap =  txtCAP.campo.text


    if  cf ~= '' or patente ~= '' or indirizzo ~= '' or civico ~= '' or cap ~= '' then

        myApp.datiUtente.cf = library.trimString( cf )
        myApp.datiUtente.patente = library.trimString( patente )
        myApp.datiUtente.via = library.trimString( indirizzo )
        myApp.datiUtente.civico = library.trimString( civico )
        myApp.datiUtente.cap = library.trimString( cap )

        print("CF: "..txtCF.campo.text)
        print("PATENTE: "..txtPatente.campo.text)
        print("INDIRIZZO: "..txtIndirizzo.campo.text)
        print("CIVICO: "..txtCivico.campo.text) 
        print("CAP: "..txtCAP.campo.text)  

        storyboard.gotoScene('riepilogo', { effect = "slideLeft", time = 500 } )
    end
end


function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE RESIDENTI")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE RESIDENTI")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE RESIDENTI")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
