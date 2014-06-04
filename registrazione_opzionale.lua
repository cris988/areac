local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local views = {}
local textListenerTarga = {}
local clearListenerTarga = {}
local textListenerCell = {}
local clearListenerCell = {}
local textListenerEmail = {}
local clearListenerEmail = {}
local trimString = {}
local AvantiScene = {}
local salvaUtente = {}
local completa = {}




-- variabili
local campoInserimentoTarga
local sfondoInserimentoTarga
local btClearTarga
local campoInserimentoCell
local sfondoInserimentoCell
local btClearCell
local campoInserimentoEmail
local sfondoInserimentoEmail
local btClearEmail
local avanti
local vaiAProfilo
local myTextInfo
local textError
local background = {1,1,1}









function scene:createScene(event)
    print("CREA SCENA VERIFICA")
    local group = self.view


    -- Background

    library.setBackground(group, background )

    step = 0
end


-- Gestisce il primo step di riepilogo

function step0(group)

    print("Verifica Targa Step 0")

    textError = display.newText('',0,0)
    group:insert(textError)

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Completa registrazione',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = AvantiScene
    })
    group:insert(avanti)


	-- testo in alto
    local options = {
        text = 'Inserisci i dati. Potranno anche essere modificati in seguito dall\'applicazione',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor{ 255,0,0 }
    group:insert(areaT)



    

    -- creazione textArea per targa


    local gruppoInserimentoTarga = display.newGroup()

    sfondoInserimentoTarga = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoTarga.x = _W*0.5
    sfondoInserimentoTarga.y = _H*0.4

    campoInserimentoTarga = native.newTextField( 40, 85, 195, 28)
    campoInserimentoTarga.x = _W/2
    campoInserimentoTarga.y = _H*0.4
    campoInserimentoTarga:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoTarga.font = native.newFont( myApp.font, 17 )
    campoInserimentoTarga.align = "center"
    campoInserimentoTarga.hasBackground = false
    campoInserimentoTarga.placeholder = 'Targa principale'

    btClearTarga = display.newImage('img/delete.png', 10,10)
    btClearTarga.x = _W*0.85
    btClearTarga.y = _H*0.4
    btClearTarga.alpha = 0

    gruppoInserimentoTarga:insert(sfondoInserimentoTarga)
    gruppoInserimentoTarga:insert(campoInserimentoTarga)
    gruppoInserimentoTarga:insert(btClearTarga)

    campoInserimentoTarga:addEventListener( "userInput", textListenerTarga)




    -- creazione textArea per cellulare

    local gruppoInserimentoCell = display.newGroup()

    sfondoInserimentoCell = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoCell.x = _W*0.5
    sfondoInserimentoCell.y = _H*0.55

    campoInserimentoCell = native.newTextField( 40, 85, 195, 28)
    campoInserimentoCell.x = _W/2
    campoInserimentoCell.y = _H*0.55
    campoInserimentoCell:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoCell.font = native.newFont( myApp.font, 17 )
    campoInserimentoCell.align = "center"
    campoInserimentoCell.hasBackground = false
    campoInserimentoCell.placeholder = 'Cellulare'

    btClearCell = display.newImage('img/delete.png', 10,10)
    btClearCell.x = _W*0.85
    btClearCell.y = _H*0.55
    btClearCell.alpha = 0

    gruppoInserimentoCell:insert(sfondoInserimentoCell)
    gruppoInserimentoCell:insert(campoInserimentoCell)
    gruppoInserimentoCell:insert(btClearCell)

    campoInserimentoCell:addEventListener( "userInput", textListenerCell)



    -- creazione textArea per Email

    local gruppoInserimentoEmail = display.newGroup()

    sfondoInserimentoEmail = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimentoEmail.x = _W*0.5
    sfondoInserimentoEmail.y = _H*0.7

    campoInserimentoEmail = native.newTextField( 40, 85, 195, 28)
    campoInserimentoEmail.x = _W/2
    campoInserimentoEmail.y = _H*0.7
    campoInserimentoEmail:setTextColor( 0.75,0.75,0.75 )
    campoInserimentoEmail.font = native.newFont( myApp.font, 17 )
    campoInserimentoEmail.align = "center"
    campoInserimentoEmail.hasBackground = false
    campoInserimentoEmail.placeholder = 'Email'

    btClearEmail = display.newImage('img/delete.png', 10,10)
    btClearEmail.x = _W*0.85
    btClearEmail.y = _H*0.7
    btClearEmail.alpha = 0


    gruppoInserimentoEmail:insert(sfondoInserimentoEmail)
    gruppoInserimentoEmail:insert(campoInserimentoEmail)
    gruppoInserimentoEmail:insert(btClearEmail)

    campoInserimentoEmail:addEventListener( "userInput", textListenerEmail)




    group:insert(gruppoInserimentoEmail)
    group:insert(gruppoInserimentoTarga)
    group:insert(gruppoInserimentoCell)

    return group
end




-- Gestisce il secondo step di Verifica Targa

function step1(group)
   
    print("Verifica Targa Step 1")

    local options = {
        text = 'Registrazione completata con successo!',
        x = _W*0.5,
        y = _H*0.5,
        width = _W - 30,
        fontSize = 20,
        align = "center"
    }
    myTextInfo = display.newText(options)
    myTextInfo:setFillColor(0)
    group:insert(myTextInfo)


    vaiAProfilo = widget.newButton({
        id  = 'BtVaiAProfilo',
        label = 'Vai al tuo profilo',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = completa
    })
    group:insert(vaiAProfilo)

    return group
end



function completa()
    storyboard.gotoScene('profilo')
end









-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end












--gestisce le fasi dell'inserimento del numero patente
function textListenerTarga( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClearTarga.alpha = 0.2
            btClearTarga:addEventListener( "touch", clearListenerTarga )
        end
        campoInserimentoTarga:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClearTarga.alpha = 0.2
            btClearTarga:addEventListener( "touch", clearListenerTarga )
        else
            btClearTarga.alpha = 0
            btClearTarga:removeEventListener( "touch", clearListenerTarga )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClearTarga.alpha = 0
            campoInserimentoTarga:setTextColor( 0.75,0.75,0.75 )

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListenerTarga( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimentoTarga.text = ''
        native.setKeyboardFocus( campoInserimentoTarga )
        btClearTarga.alpha = 0
        btClearTarga:removeEventListener( "touch", clearListenerTarga )
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













function AvantiScene()
    if  campoInserimentoEmail.text == '' or 
        campoInserimentoTarga.text == '' or 
        campoInserimentoCell.text == '' then

    else
        if #trimString( campoInserimentoTarga.text ) == 7 and trimString( campoInserimentoTarga.text ):match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
            salvaUtente()
            storyboard.reloadScene( )
        else

           campoInserimentoTarga:setTextColor(1,0,0)

            -- testo di errore
            textError.x = _W*0.5
            textError.y = _H*0.465
            textError.fontSize = 12
            textError.text = 'FORMATO NON CORRETTO'
            textError:setFillColor( 1, 0, 0 )
        end    
    end
end




function salvaUtente()
    local i = myApp:getNumUtenti()
    if myApp.datiUtente.tipo == 'Residente' then
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            cf = myApp.datiUtente.cf,
            patente = myApp.datiUtente.patente,
            via = myApp.datiUtente.via,
            civico = myApp.datiUtente.civico,
            cap = myApp.datiUtente.cap,
            email = trimString( campoInserimentoEmail.text ),
            cellulare = trimString( campoInserimentoCell.text ),
            targa = trimString( campoInserimentoTarga.text ):upper(),
            accessi = 50,
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( campoInserimentoTarga.text ):upper() }
        end
    elseif myApp.datiUtente.tipo == 'Disabile' then
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            pass = myApp.datiUtente.pass,
            email = trimString( campoInserimentoEmail.text ),
            cellulare = trimString( campoInserimentoCell.text ),
            targa = trimString( campoInserimentoTarga.text ):upper(),
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( campoInserimentoTarga.text ):upper() }
        end
    else
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            email = trimString( campoInserimentoEmail.text ),
            cellulare = trimString( campoInserimentoCell.text ),
            targa = trimString( campoInserimentoTarga.text ):upper(),
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( campoInserimentoTarga.text ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( campoInserimentoTarga.text ):upper() }
        end
    end

    myApp.utenteLoggato = i+1
end











function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE_OPZIONALI")

    local group = self.view
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = false

    --[[ Se sono al 1° step creo il group0 locale
        Se sono al 2° step creo il group1 locale
        Alla fine aggancio il group0 o group1 al group della scena
    ]]--

    if step == 0 then

        group0 = display.newGroup()
        group:insert(step0(group0))
        myApp.titleBar.indietro.isVisible = false
    else
        group1 = display.newGroup()
        group:insert(step1(group1))
        myApp.titleBar.indietro.isVisible = false
        myApp.titleBar.logo.isVisible = false
        if myApp.utenteLoggato == 0 then
            myApp.titleBar.accedi.isVisible = false
        else
            myApp.titleBar.profilo.isVisible = false
        end
    end
end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE_OPZIONALI")

    local group = self.view

    --[[ Se sono al 1° step distruggo il group0 e passo allo step1
        Se sono al 2° step distruggo il group1 e passo allo step0 (con il tasto indietro)
    ]]--

    if step == 0 then
        step = 1
        group:remove(group0)
    else
        step = 0
        group:remove(group1)
    end
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE_OPZIONALI")
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
