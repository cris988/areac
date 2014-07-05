--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

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
local cellDatiText
local emailDatiText
local BtFine
local BtModifica




function scene:createScene(event)
    
    local group = self.view

    print("CREA SCENA DATI UTENTE")

    -- Background

    library.setBackground(group, _Background)

    
    -- Preparo titleBar
    myApp.titleBar.setTitleBar("datiUtente", "Dati utente", { 
        indietro = true,
        modifica = true,
        fine = false
    })
    myApp.titleBar.fine.func = fineModifica
    myApp.titleBar.modifica.func = modificaDati

    local posY = _H * 0.2


    -- stato utente
    local optionsStato = {
        text = 'Stato:',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 14,
        width = _W-30,
        align = "left"
    }
    local statoText = display.newText( optionsStato )
    statoText:setFillColor( 0, 0, 0 )

    posY = posY + 20

    local optionsStatoDati = {
        text = '',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 21,
        width = _W-30,
        align = "left"
    }
    local statoDatiText = display.newText( optionsStatoDati )
    statoDatiText:setFillColor( 0, 0, 0 )

    -- Stato dell'utente
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Non residente' then
        statoDatiText.text = 'Residente fuori dall\'area C'
    elseif myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        statoDatiText.text = 'Residente nell\'area C'
    else
        statoDatiText.text = myApp.utenti[myApp.utenteLoggato].tipo
    end

    posY = posY + 50

    -- residenza
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        local optionsResidenza = {
            text = 'Residente a:',
            x = _W*0.5,
            y = posY,
            font = myApp.font,
            fontSize = 14,
            width = _W-30,
            align = "left"
        }
        local residenzaText = display.newText( optionsResidenza )
        residenzaText:setFillColor( 0, 0, 0 )

        posY = posY + 20

        local optionsResidenzaDati = {
            text = '',
            x = _W*0.5,
            y = posY,
            font = myApp.font,
            fontSize = 21,
            width = _W-30,
            align = "left"
        }
        local residenzaDatiText = display.newText( optionsResidenzaDati )
        residenzaDatiText.text = myApp.utenti[myApp.utenteLoggato].via .. ', ' .. myApp.utenti[myApp.utenteLoggato].civico .. ', ' .. myApp.utenti[myApp.utenteLoggato].cap
        residenzaDatiText:setFillColor( 0, 0, 0 )

        
        group:insert(residenzaText)
        group:insert(residenzaDatiText)

        posY = posY + 50
    
    end

    -- email
    local optionsEmail = {
        text = 'Email:',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 14,
        width = _W-30,
        align = "left"
    }
    local emailText = display.newText( optionsEmail )
    emailText:setFillColor( 0, 0, 0 )

    posY = posY + 20

    local optionsEmailDati = {
        text = myApp.utenti[myApp.utenteLoggato].email,
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 21,
        width = _W-30,
        align = "left"
    }
    emailDatiText = display.newText( optionsEmailDati )
    emailDatiText:setFillColor( 0, 0, 0 )

    posY = posY + 50

    -- cellulare
    local optionsCell = {
        text = 'Cellulare:',
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 14,
        width = _W-30,
        align = "left"
    }
    local cellText = display.newText( optionsCell )
    cellText:setFillColor( 0, 0, 0 )

    posY = posY + 20

    local optionsDatiCell = {
        text = myApp.utenti[myApp.utenteLoggato].cellulare,
        x = _W*0.5,
        y = posY,
        font = myApp.font,
        fontSize = 21,
        width = _W-30,
        align = "left"
    }
    cellDatiText = display.newText( optionsDatiCell )
    cellDatiText:setFillColor( 0, 0, 0 )

    -- Text box in cui modificare i dati
    txtEmail =library.textArea(group, emailDatiText.x, emailDatiText.y + 10, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "left", "Email")
    txtCell =library.textArea(group, cellDatiText.x, cellDatiText.y + 10, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "left", "Cellulare")

    -- Inserimento già esistenti
    txtCell.campo.text = myApp.utenti[myApp.utenteLoggato].cellulare
    txtEmail.campo.text = myApp.utenti[myApp.utenteLoggato].email

    txtCell.isVisible = false
    txtEmail.isVisible = false

    txtCell.campo.isVisible = false
    txtEmail.campo.isVisible = false

    txtCell:toFront()
    txtEmail:toFront()

    group:insert(txtEmail)
    group:insert(txtCell)

    group:insert(statoText)
    group:insert(statoDatiText)
    group:insert(emailText)
    group:insert(emailDatiText)
    group:insert(cellText)
    group:insert(cellDatiText)

    return group
end



function modificaDati()

    txtCell.isVisible = true
    txtEmail.isVisible = true

    txtCell.campo.isVisible = true
    txtEmail.campo.isVisible = true

    cellDatiText.isVisible = false
    emailDatiText.isVisible = false

    myApp.titleBar.fine.isVisible = true
    myApp.titleBar.modifica.isVisible = false
end


function fineModifica()
    if txtCell.campo.text ~= '' or txtEmail.campo.text ~= '' then
        
        library.salvaUtente({cellulare = txtCell.campo.text, email=txtEmail.campo.text}, myApp.utenteLoggato)

        txtCell.isVisible = false
        txtEmail.isVisible = false

        txtCell.campo.isVisible = false
        txtEmail.campo.isVisible = false


        cellDatiText.text = myApp.utenti[myApp.utenteLoggato].cellulare
        emailDatiText.text = myApp.utenti[myApp.utenteLoggato].email

        cellDatiText.isVisible = true
        emailDatiText.isVisible = true

    end


    myApp.titleBar.fine.isVisible = false
    myApp.titleBar.modifica.isVisible = true

end



function scene:enterScene( event )
    print("ENTRA SCENA DATI UTENTE")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA DATI UTENTE")
    myApp.titleBar.fine.isVisible = false
    myApp.titleBar.modifica.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA DATI UTENTE")
end



scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
