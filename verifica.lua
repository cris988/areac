--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- Scene 
local verifica0 = storyboard.newScene("verifica0")
local verifica1 = storyboard.newScene("verifica1")

-- funzioni
local acquistaButton
local verificaButton
verificaPrint = {}
verificaTarga = {}

-- variabili
local txtTarga
local targa
local textError

local string = "Inserisci la targa per controllare se il tuo veicolo è adibito ad accedere all\'area C e con che modalità"



function verifica0:createScene(event)

    print("CREA SCENA VERIFICA0")
	local group = self.view
    
    -- Preparo titleBar
    myApp.titleBar.setTitleBar("verifica", "Verifica Targa", { 
        indietro = false,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = true
    })

    -- Background

    library.setBackground(group, _Background )

    

    local BtVerifica = widget.newButton({
        id  = 'BtVerifica',
        label = 'Verifica',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = verificaButton
    })
    group:insert(BtVerifica)


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

    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)


    txtTarga =library.textArea(group,_W*0.5, _H*0.5, 160, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa")
    group:insert(txtTarga)

    textError = display.newText('FORMATO NON CORRETTO',_W*0.5,_H*0.555, myApp.font, 13)
    textError:setFillColor( 1, 0, 0 )
    textError.alpha = 0
    group:insert(textError)

end







function verifica1:createScene(event)

    print("CREA SCENA VERIFICA1")
    local group = self.view

    -- Preparo titleBar

    myApp.titleBar.setTitleBar("verifica", "Verifica Targa", { 
        indietro = true,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = false
    })

    -- Background

    library.setBackground(group, _Background )

    local accesso = verificaTarga(targa)

    local groupVerifica = verificaPrint(accesso, targa)

    group:insert(groupVerifica)

    if accesso == 'p' then

        local acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.8,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaButton
        })

        group:insert(acquista)

    end
end


function verificaPrint(accesso, targa)

    local group = display.newGroup()

    local line1 = display.newText( 'Il veicolo con targa '..targa, _W * 0.5, 100, myApp.font, 20)
    line1:setFillColor(0)

    local line2 = display.newText( 'PUO\' ACCEDERE',  _W * 0.5, 125, myApp.font, 20)
    line2:setFillColor(0)

    local line3 = display.newText( 'all\'area C',  _W * 0.5, 150, myApp.font, 20)
    line3:setFillColor(0)

    local line4 = display.newText( '', _W*0.5, 220, native.systemFontBold, 24 )

    if accesso == 'g' then

        line4.text = 'ACCESSO GRATUITO'
        line4:setFillColor(0.14,0.5,0.15)

    elseif accesso == 'p' then

        line4.text = 'ACCESSO A PAGAMENTO'
        line4:setFillColor(0.95,0.85,0.2)

    else

        line2.text = 'NON PUO\' ACCEDERE'
        line4.text = 'ACCESSO VIETATO'
        line4:setFillColor(1,0,0)

    end 

    local bordoDati = display.newImageRect( "img/bordo_verifica.png", _W * 0.9, 160)
    bordoDati.x = _W * 0.5
    bordoDati.y = 340

    local textDatiTitle = display.newText( "Dati del veicolo \n", _W * 0.3, 280, native.systemFontBold, 17) 
    textDatiTitle:setFillColor(0)

    local options ={

        text = '',
        x = _W * 0.49,
        y = 380,
        width = _W * 0.8,
        height = 150,
        font = myApp.font,
        fontSize = 17,
        align = 'left'
    }


    local textDati = display.newText(options)
    textDati:setFillColor(0)

    if accesso == 'g' then
        textDati.text = "- EURO"..myApp.datiTarghe.euro[math.random(5,#myApp.datiTarghe.euro)]:upper().. "\n"..
                "- "..myApp.datiTarghe.tipo[math.random(1,#myApp.datiTarghe.tipo)].. "\n"..
                "- "..myApp.datiTarghe.alim[math.random(3,#myApp.datiTarghe.alim)]
    else
        textDati.text = "- EURO"..myApp.datiTarghe.euro[math.random(1,#myApp.datiTarghe.euro)]:upper().. "\n"..
                "- "..myApp.datiTarghe.tipo[math.random(1,#myApp.datiTarghe.tipo)].. "\n"..
                "- "..myApp.datiTarghe.alim[math.random(1,2)]
    end

    group:insert(line1)
    group:insert(line2)
    group:insert(line3)
    group:insert(line4)
    group:insert(bordoDati)
    group:insert(textDatiTitle)
    group:insert(textDati)

    return group

end

function verificaTarga(targa)

    local accesso = "v"

    local targaTrovata = false

    local numTarghe = myApp:getNumTarghe()

    for i = 1, numTarghe, 1 do
        if targa == myApp.targhe[i].targa and targaTrovata == false then
            -- targa presente nel database
            accesso = myApp.targhe[i].accesso
            targaTrovata = true
        end
    end

    num = math.random()
    print(num)

    if targaTrovata == false then

        local euro
        local tipo
        local alim

        if num <= 0.90 then
            if num <= 0.80 then
                accesso = "p"
                euro = myApp.datiTarghe.euro[math.random(1,#myApp.datiTarghe.euro)]:upper()
                tipo = myApp.datiTarghe.tipo[math.random(1,#myApp.datiTarghe.tipo)]
                alim = myApp.datiTarghe.alim[math.random(1,2)]
            else
                accesso = "g"
                euro = myApp.datiTarghe.euro[math.random(5,#myApp.datiTarghe.euro)]:upper()
                tipo = myApp.datiTarghe.tipo[math.random(1,#myApp.datiTarghe.tipo)]
                alim = myApp.datiTarghe.alim[math.random(3,#myApp.datiTarghe.alim)]
            end

        end
        
        -- Aggiunta nuova targa nel database
        myApp.targhe[numTarghe+1] = { targa = targa , accesso = accesso, euro = euro, tipo = tipo, alim = alim }

    end

    return accesso
end


-- Funzioni per pulsanti

function acquistaButton()
    require("acquista")
    storyboard.gotoScene('acquista1', { effect = "slideLeft", time = 500, params = { targa = targa } })
    myApp.story.removeAll()
    myApp.story.add("acquista0")
    myApp.tabBar:setSelected(3)
end


function verificaButton()

    local input = library.matchTarga( txtTarga.campo.text)

    if input then

        targa = input:upper()

        storyboard.gotoScene( "verifica1", { effect = "slideLeft", time = 500 })

    else
       txtTarga.campo:setTextColor(1,0,0)
        
        -- testo di errore
        textError.alpha = 1
    end

end



function verifica0:enterScene( event ) 
    print("ENTRA SCENA VERIFICA0") 
    myApp.story.removeAll()
    myApp.story.add(storyboard.getCurrentSceneName())
end

function verifica0:exitScene( event ) 
    print("ESCI SCENA VERIFICA0") 
end

function verifica0:destroyScene( event ) print("DISTRUGGI SCENA VERIFICA0") end


function verifica1:enterScene( event ) 
    print("ENTRA SCENA VERIFICA1") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function verifica1:exitScene( event ) 
    print("ESCI SCENA VERIFICA1") 
end

function verifica1:destroyScene( event ) print("DISTRUGGI SCENA VERIFICA1") end


verifica0:addEventListener( "createScene", verifica0 )
verifica0:addEventListener( "enterScene", verifica0 )
verifica0:addEventListener( "exitScene", verifica0 )
verifica0:addEventListener( "destroyScene", verifica0 )

verifica1:addEventListener( "createScene", verifica1 )
verifica1:addEventListener( "enterScene", verifica1 )
verifica1:addEventListener( "exitScene", verifica1 )
verifica1:addEventListener( "destroyScene", verifica1 )
