--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- Scene 
local gestioneVerifica0 = storyboard.newScene("gestioneVerifica0")
local gestioneVerifica1 = storyboard.newScene("gestioneVerifica1")

-- funzioni
local aggiungiButton
local fineButton
notEnter ={}

-- variabili
local txtTarga
local targa
local textError
local aggiungereTarga = false



function gestioneVerifica0:createScene(event)

    print("CREA SCENA GESTIONE TARGHE VERIFICA0")
	local group = self.view
 
    -- Background

    library.setBackground(group, _Background )

    myApp.titleBar.indietro.isVisible = true

    

    local BtAggiungi = widget.newButton({
        id  = 'BtAggiungi',
        label = 'Aggiungi targa',
        x = _W*0.5,
        y = _H*0.7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease =  aggiungiButton
    })


    local options = {
        text = 'Inserisci la targa e procedi con la verifica:',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )


    txtTarga =library.textArea(group,_W*0.5, _H*0.5, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa")


    textError = display.newText('FORMATO NON CORRETTO',_W*0.5,_H*0.555, myApp.font, 13)
    textError:setFillColor( 1, 0, 0 )
    textError.alpha = 0

    group:insert(areaT)
    group:insert(BtAggiungi)
    group:insert(txtTarga)
    group:insert(textError)

end







function gestioneVerifica1:createScene(event)

    print("CREA SCENA GESTIONE TARGHE VERIFICA1")
    local group = self.view

    -- Background

    library.setBackground(group, _Background )


    -- Verifica se la targa è già presente nella lista dell'utente
    local targaTrovata = false
    local numTarghe = myApp:getNumTargheUtente(myApp.utenteLoggato)
    local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)

    i = 0
    repeat
    targaTrovata = (targheUtente[i] == targa)
    i = i +1
    until targaTrovata or i == numTarghe
    
    if targaTrovata then

        local options = {
            text = 'Targa '..targa..' già inserita!',
            x = _W*0.5,
            y = _H*0.45,
            width = _W - 30,
            fontSize = 20,
            align = "center"
        }
        local line1 = display.newText( options )
        line1:setFillColor( 0, 0, 0 )

        group:insert(line1)

    else
        
        require("verifica")
        local accesso = verificaTarga(targa)
        local groupVerifica
        local text

        if  accesso == 'g' then

                groupVerifica = verificaPrint('g', targa)

                text = display.newText( 'TARGA NON INSERITA', _W*0.5, _H*0.8, myApp.font, 24 )
                text:setFillColor(1,0,0)

        elseif accesso == 'p' then


        -- local accesso = library.verificaTarga(targa)

        -- if accesso then

        --     aggiungereTarga = true


        --     -- local line1 = display.newText( 'Il veicolo con targa '..targa,  _W*0.5, 100, myApp.font, 20)
        --     -- line1:setFillColor(0)

        --     -- local line2
        --     if  myApp.utenti[myApp.utenteLoggato].tipo == "Disabile" then

        --         require("verifica")
        --         verificaPrint('g', targa)
        --         -- line2 = display.newText( 'PUO\' ACCEDERE\nGRATUITAMENTE',  _W*0.5, 125, myApp.font, 20)
        --         -- line2:setFillColor(0.1333,0.54509,0.13334)
        --         -- line2.width = _W *0.8
        --         -- line2.height = 300
        --     else 
        --         -- line2 = display.newText( 'PUO\' ACCEDERE',  _W*0.5, 125, myApp.font, 20)
        --         -- line2:setFillColor(0.1333,0.54509,0.13334)
        --     end
        --     -- local line3 = display.newText( 'all\'area C',  _W*0.5, 150, myApp.font, 20)
        --     -- line3:setFillColor(0)
        --     --local line4 = display.newText( 'ACCESSO A PAGAMENTO', _W*0.5, _H*0.5, myApp.font, 24 )
        --     --line4:setFillColor(0.1333,0.54509,0.13334)


                groupVerifica = verificaPrint('p', targa)
                
                text = display.newText( 'TARGA INSERITA', _W*0.5, _H*0.8, myApp.font, 24 )
                text:setFillColor(0.1333,0.54509,0.13334)

        else

            groupVerifica = verificaPrint('v', targa)


            text = display.newText( 'TARGA NON INSERITA', _W*0.5, _H*0.8, myApp.font, 24 )
            text:setFillColor(1,0,0)

        end
                -- group:insert(line1)
                -- group:insert(line2)
                -- group:insert(line3)
                -- group:insert(line4)
                -- group:insert(line5)

        -- else
        --     require("verifica")
        --     notEnter(group, targa)
        -- end

        --transition.to( groupVerifica, {time = 0, y = _H * 0.1} )

        group:insert(groupVerifica)
        group:insert(text)
    end



    local BtFine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine',
        x = _W*0.5,
        y = _H*0.9,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = fineAggiunta
    })
    
    group:insert(BtFine)
end


function fineAggiunta()
    if aggiungereTarga then
        local targheUtente = myApp:getTargheUtente(myApp.utenteLoggato)
        table.insert( targheUtente, targa )
    end
    myApp.story.back()
    myApp.story.back()
    storyboard.gotoScene( "profilo_gestione_targhe", { effect = "slideLeft", time = 500 })
end




function aggiungiButton()
    local text = txtTarga.campo.text
    if text ~= '' and  #text == 7 and text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        targa = trimString( text ):upper()
        storyboard.gotoScene( "gestioneVerifica1", { effect = "slideLeft", time = 500 })
    else
       txtTarga.campo:setTextColor(1,0,0)
        
        -- testo di errore
        textError.alpha = 1
    end
end








function gestioneVerifica0:enterScene( event ) 
    print("ENTRA SCENA VERIFICA0") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function gestioneVerifica0:exitScene( event ) 
    print("ESCI SCENA VERIFICA0") 
end

function gestioneVerifica0:destroyScene( event )
    print("DISTRUGGI SCENA VERIFICA0")
end


function gestioneVerifica1:enterScene( event ) 
    print("ENTRA SCENA VERIFICA1") 
    myApp.story.add(storyboard.getCurrentSceneName())
end

function gestioneVerifica1:exitScene( event ) 
    print("ESCI SCENA VERIFICA1") 
    myApp.titleBar.indietro.isVisible = false
end

function gestioneVerifica1:destroyScene( event )
    print("DISTRUGGI SCENA VERIFICA1")
end


gestioneVerifica0:addEventListener( "createScene", gestioneVerifica0 )
gestioneVerifica0:addEventListener( "enterScene", gestioneVerifica0 )
gestioneVerifica0:addEventListener( "exitScene", gestioneVerifica0 )
gestioneVerifica0:addEventListener( "destroyScene", gestioneVerifica0 )

gestioneVerifica1:addEventListener( "createScene", gestioneVerifica1 )
gestioneVerifica1:addEventListener( "enterScene", gestioneVerifica1 )
gestioneVerifica1:addEventListener( "exitScene", gestioneVerifica1 )
gestioneVerifica1:addEventListener( "destroyScene", gestioneVerifica1 )
