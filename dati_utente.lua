local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local modificaDati = {}
local fineModifica = {}
local salvaUtente = {}


-- variabili
local txtCell
local txtEmail
local group0
local group1
local group




function scene:createScene(event)
    
    group = self.view

    print("CREA SCENA DATI UTENTE")

    -- Background

    library.setBackground(group, _Background)

    
    myApp.titleBar.indietro.isVisible = true

    step = 0

    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Dati utente"

    group0 = step0()
    group:insert(group0)

end


-- Gestisce il primo step di Dati utente

function step0()

    local group = display.newGroup( )

    print("Visualizzazione dati Step 0")

    local BtModifica = widget.newButton({
        id  = 'BtModifica',
        label = 'Modifica dati',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = modificaDati
    })
     

    -- stato utente
    local optionsStato = {
        text = 'Stato:',
        x = _W*0.5,
        y = _H*0.2,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local statoText = display.newText( optionsStato )
    statoText:setFillColor( 0, 0, 0 )

    local optionsStatoDati = {
        text = '',
        x = _W*0.5,
        y = _H*0.24,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local statoDatiText = display.newText( optionsStatoDati )
    statoDatiText:setFillColor( 0, 0, 0 )
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Non residente' then
        statoDatiText.text = 'Residente fuori dall\'area C'
    elseif myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        statoDatiText.text = 'Residente nell\'area C'
    else
        statoDatiText.text = myApp.utenti[myApp.utenteLoggato].tipo
    end

    -- email
    local optionsEmail = {
        text = 'Email:',
        x = _W*0.5,
        y = _H*0.4,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local emailText = display.newText( optionsEmail )
    emailText:setFillColor( 0, 0, 0 )

    local optionsEmailDati = {
        text = myApp.utenti[myApp.utenteLoggato].email,
        x = _W*0.5,
        y = _H*0.44,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local emailDatiText = display.newText( optionsEmailDati )
    emailDatiText:setFillColor( 0, 0, 0 )
 

    -- cellulare
    local optionsCell = {
        text = 'Cellulare:',
        x = _W*0.5,
        y = _H*0.5,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local cellText = display.newText( optionsCell )
    cellText:setFillColor( 0, 0, 0 )

    local optionsDatiCell = {
        text = myApp.utenti[myApp.utenteLoggato].cellulare,
        x = _W*0.5,
        y = _H*0.54,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local cellDatiText = display.newText( optionsDatiCell )
    cellDatiText:setFillColor( 0, 0, 0 )


    -- residenza
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        local optionsResidenza = {
            text = 'Residente a:',
            x = _W*0.5,
            y = _H*0.3,
            font = myApp.font,
            fontSize = 13,
            width = _W-30,
            align = "left"
        }
        local residenzaText = display.newText( optionsResidenza )
        residenzaText:setFillColor( 0, 0, 0 )

        local optionsResidenzaDati = {
            text = '',
            x = _W*0.5,
            y = _H*0.34,
            font = myApp.font,
            fontSize = 20,
            width = _W-30,
            align = "left"
        }
        local residenzaDatiText = display.newText( optionsResidenzaDati )
        residenzaDatiText.text = myApp.utenti[myApp.utenteLoggato].via .. ', ' .. myApp.utenti[myApp.utenteLoggato].civico
        residenzaDatiText:setFillColor( 0, 0, 0 )

        
        group:insert(residenzaText)
        group:insert(residenzaDatiText)
    end

    group:insert(statoText)
    group:insert(statoDatiText)
    group:insert(emailText)
    group:insert(emailDatiText)
    group:insert(cellText)
    group:insert(cellDatiText)
    group:insert(BtModifica)

    return group
end


-- Gestisce la modifica dei dati

function step1(group)
   
    local group = display.newGroup( )

    print("Visualizzazione dati Step 0")

    local BtFine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine modifiche',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = fineModifica
    })

    -- Text box in cui modificare i dati
    txtCell =library.textArea(group,_W*0.5, _H*0.45, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Cellulare")
    txtEmail =library.textArea(group,_W*0.5, _H*0.3, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Email")

    -- Inserimento già esistenti
    txtCell.campo.text = myApp.utenti[myApp.utenteLoggato].cellulare
    txtEmail.campo.text = myApp.utenti[myApp.utenteLoggato].email


    group:insert(txtEmail)
    group:insert(txtCell)
    group:insert(BtFine)


    return group
end


function modificaDati()
    group1 = step1()
    group:remove(group0)
    group:insert(group1)
    storyboard.reloadScene( )
end


function fineModifica()
    if txtCell.campo.text ~= '' or txtEmail.campo.text ~= '' then
        
        library.salvaUtente({cellulare = txtCell.campo.text, email=txtEmail.campo.text}, myApp.utenteLoggato)

        storyboard.reloadScene( )
    end
    group0 = step0()
    group:remove(group1)
    group:insert(group0)

end



function scene:enterScene( event )
    print("ENTRA SCENA DATI UTENTE")
    
    myApp.titleBar.indietro.isVisible = true
    myApp.story.add(storyboard.getCurrentSceneName())

end

function scene:exitScene( event )
    print("ESCI SCENA DATI UTENTE")

    myApp.titleBar.indietro.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA DATI UTENTE")
    group0 = nil
    group1 = nil
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
