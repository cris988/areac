local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local modificaDati = {}
local fineModifica = {}
local textListenerCell = {}
local clearListenerCell = {}
local textListenerEmail = {}
local clearListenerEmail = {}
local salvaUtente = {}


-- variabili
local modifica
local fine
local campoInserimentoCell
local sfondoInserimentoCell
local btClearCell
local campoInserimentoEmail
local sfondoInserimentoEmail
local btClearEmail






function scene:createScene(event)
    local group = self.view

    print("CREA SCENA DATI UTENTE")

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    step = 0
end


-- Gestisce il primo step di Dati utente

function step0(group)

print("Visualizzazione dati Step 0")

    modifica = widget.newButton({
        id  = 'BtModifica',
        label = 'Modifica dati',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = modificaDati
    })
    group:insert(modifica)

     

    -- stato utente
    local options1 = {
        text = 'Stato:',
        x = _W*0.5,
        y = _H*0.2,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local text1 = display.newText( options1 )
    text1:setFillColor( 0, 0, 0 )
    group:insert(text1)

    local options2 = {
        text = '',
        x = _W*0.5,
        y = _H*0.24,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local text2 = display.newText( options2 )
    text2:setFillColor( 0, 0, 0 )
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Non residente' then
        text2.text = 'Residente fuori dall\'area C'
    elseif myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        text2.text = 'Residente nell\'area C'
    else
        text2.text = myApp.utenti[myApp.utenteLoggato].tipo
    end
    group:insert(text2)



    -- residenza
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        local options3 = {
            text = 'Residente a:',
            x = _W*0.5,
            y = _H*0.3,
            font = myApp.font,
            fontSize = 13,
            width = _W-30,
            align = "left"
        }
        local text3 = display.newText( options3 )
        text3:setFillColor( 0, 0, 0 )
        group:insert(text3)

        local options4 = {
            text = '',
            x = _W*0.5,
            y = _H*0.34,
            font = myApp.font,
            fontSize = 20,
            width = _W-30,
            align = "left"
        }
        local text4 = display.newText( options4 )
        text4.text = myApp.utenti[myApp.utenteLoggato].via .. ', ' .. myApp.utenti[myApp.utenteLoggato].civico
        text4:setFillColor( 0, 0, 0 )
        group:insert(text4)
    end




    -- email
    local options5 = {
        text = 'Email:',
        x = _W*0.5,
        y = _H*0.4,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local text5 = display.newText( options5 )
    text5:setFillColor( 0, 0, 0 )
    group:insert(text5)

    local options6 = {
        text = myApp.utenti[myApp.utenteLoggato].email,
        x = _W*0.5,
        y = _H*0.44,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local text6 = display.newText( options6 )
    text6:setFillColor( 0, 0, 0 )
    group:insert(text6)
 



    -- cellulare
    local options7 = {
        text = 'Cellulare:',
        x = _W*0.5,
        y = _H*0.5,
        font = myApp.font,
        fontSize = 13,
        width = _W-30,
        align = "left"
    }
    local text7 = display.newText( options7 )
    text7:setFillColor( 0, 0, 0 )
    group:insert(text7)

    local options8 = {
        text = myApp.utenti[myApp.utenteLoggato].cellulare,
        x = _W*0.5,
        y = _H*0.54,
        font = myApp.font,
        fontSize = 20,
        width = _W-30,
        align = "left"
    }
    local text8 = display.newText( options8 )
    text8:setFillColor( 0, 0, 0 )
    group:insert(text8)

    return group
end


-- Gestisce la modifica dei dati

function step1(group)
   
    print("Visualizzazione dati Step 0")

    fine = widget.newButton({
        id  = 'BtFine',
        label = 'Fine modifiche',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = fineModifica
    })
    group:insert(fine)


    -- creazione textArea per cellulare

    local gruppoInserimentoCell = display.newGroup()

    sfondoInserimentoCell = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCell.x = _W*0.5
    sfondoInserimentoCell.y = _H*0.3

    campoInserimentoCell = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCell.x = _W/2
    campoInserimentoCell.y = _H*0.3
    campoInserimentoCell:setTextColor( 0 )
    campoInserimentoCell.font = native.newFont( myApp.font, 17 )
    campoInserimentoCell.align = "center"
    campoInserimentoCell.hasBackground = false
    campoInserimentoCell.placeholder = 'Cellulare'

    btClearCell = display.newImage('img/delete.png', 10,10)
    btClearCell.x = _W*0.85
    btClearCell.y = _H*0.3
    btClearCell.alpha = 0

    gruppoInserimentoCell:insert(sfondoInserimentoCell)
    gruppoInserimentoCell:insert(campoInserimentoCell)
    gruppoInserimentoCell:insert(btClearCell)

    campoInserimentoCell:addEventListener( "userInput", textListenerCell)



    -- creazione textArea per Email

    local gruppoInserimentoEmail = display.newGroup()

    sfondoInserimentoEmail = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoEmail.x = _W*0.5
    sfondoInserimentoEmail.y = _H*0.45

    campoInserimentoEmail = native.newTextField( 40, 85, 195, 28)
    campoInserimentoEmail.x = _W/2
    campoInserimentoEmail.y = _H*0.45
    campoInserimentoEmail:setTextColor( 0 )
    campoInserimentoEmail.font = native.newFont( myApp.font, 17 )
    campoInserimentoEmail.align = "center"
    campoInserimentoEmail.hasBackground = false
    campoInserimentoEmail.placeholder = 'Email'

    btClearEmail = display.newImage('img/delete.png', 10,10)
    btClearEmail.x = _W*0.85
    btClearEmail.y = _H*0.45
    btClearEmail.alpha = 0


    gruppoInserimentoEmail:insert(sfondoInserimentoEmail)
    gruppoInserimentoEmail:insert(campoInserimentoEmail)
    gruppoInserimentoEmail:insert(btClearEmail)

    campoInserimentoEmail:addEventListener( "userInput", textListenerEmail)


    campoInserimentoCell.text = myApp.utenti[myApp.utenteLoggato].cellulare
    campoInserimentoEmail.text = myApp.utenti[myApp.utenteLoggato].email


    group:insert(gruppoInserimentoCell)
    group:insert(gruppoInserimentoEmail)


    return group
end






function modificaDati()
    storyboard.reloadScene( )
end


function fineModifica()
    if campoInserimentoCell.text == '' or campoInserimentoEmail.text == '' then

    else
        salvaUtente()
        storyboard.reloadScene( )
        -- storyboard.goToScene('dati_utente')
    end
end







--gestisce le fasi dell'inserimento della indirizzo
function textListenerCell( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearCell.alpha = 0.2
            btClearCell:addEventListener( "touch", clearListenerCell )
        end
        campoInserimentoCell:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearCell.alpha = 0.2
            btClearCell:addEventListener( "touch", clearListenerCell )
        else
            btClearCell.alpha = 0
            btClearCell:removeEventListener( "touch", clearListenerCell )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearCell.alpha = 0
            campoInserimentoCell:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerCell( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoCell.text = ''
        native.setKeyboardFocus( campoInserimentoCell )
        btClearCell.alpha = 0
        btClearCell:removeEventListener( "touch", clearListenerCell )
    end
end




--gestisce le fasi dell'inserimento della numero civico
function textListenerEmail( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearEmail.alpha = 0.2
            btClearEmail:addEventListener( "touch", clearListenerEmail )
        end
        campoInserimentoEmail:setTextColor( 0 )
    elseif event.phase == "editing" then
        if(#event.target.text > 0) then
            btClearEmail.alpha = 0.2
            btClearEmail:addEventListener( "touch", clearListenerEmail )
        else
            btClearEmail.alpha = 0
            btClearEmail:removeEventListener( "touch", clearListenerEmail )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearEmail.alpha = 0
            campoInserimentoEmail:setTextColor( 0.75,0.75,0.75 )
        end
    end
end



-- gestisce la comparsa del pulsate clear
function clearListenerEmail( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoEmail.text = ''
        native.setKeyboardFocus( campoInserimentoEmail )
        btClearEmail.alpha = 0
        btClearEmail:removeEventListener( "touch", clearListenerEmail )
    end
end









function salvaUtente()
    if myApp.utenti[myApp.utenteLoggato].tipo == 'Residente' then
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            cf = myApp.utenti[myApp.utenteLoggato].cf,
            patente = myApp.utenti[myApp.utenteLoggato].patente,
            via = myApp.utenti[myApp.utenteLoggato].via,
            civico = myApp.utenti[myApp.utenteLoggato].civico,
            cap = myApp.utenti[myApp.utenteLoggato].cap,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    elseif myApp.utenti[myApp.utenteLoggato].tipo == 'Disabile' then
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            pass = myApp.utenti[myApp.utenteLoggato].pass,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    else
        myApp.utenti[myApp.utenteLoggato] = {
            username = myApp.utenti[myApp.utenteLoggato].username,
            password = myApp.utenti[myApp.utenteLoggato].password,
            nome = myApp.utenti[myApp.utenteLoggato].nome,
            cognome = myApp.utenti[myApp.utenteLoggato].cognome,
            tipo = myApp.utenti[myApp.utenteLoggato].tipo,
            email = campoInserimentoEmail.text,
            cellulare = campoInserimentoCell.text,
            targa = myApp.utenti[myApp.utenteLoggato].targa,
            accessi = myApp.utenti[myApp.utenteLoggato].accessi,
            multiplo = myApp.utenti[myApp.utenteLoggato].multiplo,
        }
    end
end









function scene:enterScene( event )
    print("ENTRA SCENA DATI UTENTE")

    local group = self.view
    

    -- Se sono al 1° step creo il group0 locale
    -- Se sono al 2° step creo il group1 locale
    -- Alla fine aggancio il group0 o group1 al group della scena


    if step == 0 then
        group0 = display.newGroup()
        group:insert(step0(group0))

        -- Preparo titleBar
        myApp.titleBar.titleText.text = "Dati utente"
        myApp.titleBar.indietro.isVisible = true
        myApp.titleBar.indietro.scene = 'profilo'

        if myApp.utenteLoggato == 0 then
            myApp.titleBar.accedi.isVisible = false
        else
            myApp.titleBar.profilo.isVisible = false
        end

        myApp.tabBar.isVisible = false
    else
        group1 = display.newGroup()
        group:insert(step1(group1))

        myApp.titleBar.indietro.isVisible = false

        if myApp.utenteLoggato == 0 then
            myApp.titleBar.accedi.isVisible = false
        else
            myApp.titleBar.profilo.isVisible = false
        end

        myApp.titleBar.indietro.isVisible = false
    end
end

function scene:exitScene( event )
    print("ESCI SCENA DATI UTENTE")

    local group = self.view

    -- Se sono al 1° step distruggo il group0 e passo allo step1
    -- Se sono al 2° step distruggo il group1 e passo allo step0 (con il tasto indietro)

    if step == 0 then
        step = 1
        group:remove(group0)
    else
        step = 0
        group:remove(group1)
    end
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA DATI UTENTE")
    group0 = nil
    group1 = nil
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
