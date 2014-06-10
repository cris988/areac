local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}

-- variabili
local txtTarga
local txtCell
local txtEmail
local textError

function scene:createScene(event)
    local group = self.view

    print("ENTRA SCENA REGISTRAZIONE")


    -- Background

    library.setBackground(group, _Background)


    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"


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

    -- Text field dati
    txtTarga=library.textArea(group,_W*0.5, _H*0.4, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa principale")
    print("TARGA: "..txtTarga.campo.text)
    txtCell =library.textArea(group,_W*0.5, _H*0.55, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Cellulare")
    print("CELLULARE: "..txtCell.campo.text)
    txtEmail =library.textArea(group,_W*0.5, _H*0.7, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Email")
    print("EMAIL: "..txtEmail.campo.text)

    -- Testo di errore
    textError = display.newText('FORMATO NON CORRETTO',_W*0.5,_H*0.8, myApp.font, 13)
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
    group:insert(txtTarga)
    group:insert(txtCell)
    group:insert(txtEmail)
    group:insert(BtAvanti)


end


function avantiButton()
    local targa = txtTarga.campo.text
    local cell = txtCell.campo.text
    local email = txtEmail.campo.text

    if  targa ~= '' or cell ~= '' or email~='' then
        if #library.trimString( targa ) == 7 and library.trimString( targa ):match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
            salvaUtente()
            storyboard.gotoScene( 'registrazione_fine', { effect = "slideLeft", time = 500 }  )
        else
           txtTarga.campo:setTextColor(1,0,0)
            -- testo di errore
            textError.alpha = 1
        end    
    end
end




function salvaUtente()

    local targa = txtTarga.campo.text
    local cell = txtCell.campo.text
    local email = txtEmail.campo.text

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
            cellulare = trimString( cell ),
            targa = trimString( targa ):upper(),
            accessi = 50,
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( targa ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( targa ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( targa ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( targa ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( targa ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( targa ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( targa ):upper() }
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
            cellulare = trimString( cell ),
            targa = trimString( targa ):upper(),
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( targa ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( targa ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( targa ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( targa ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( targa ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( targa ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( targa ):upper() }
        end
    else
        myApp.utenti[i+1] = {
            username = myApp.datiUtente.username,
            password = myApp.datiUtente.password,
            nome = myApp.datiUtente.nome,
            cognome = myApp.datiUtente.cognome,
            tipo = myApp.datiUtente.tipo,
            email = trimString( email ),
            cellulare = trimString( cell ),
            targa = trimString( targa ):upper(),
            multiplo = 0,
            targaSelezionata = 1,
        }
        if i+1 == 4 then
            myApp.targheUtente_4 = { trimString( targa ):upper() }
        elseif i+1 == 5 then
            myApp.targheUtente_5 = { trimString( targa ):upper() }
        elseif i+1 == 6 then
            myApp.targheUtente_6 = { trimString( targa ):upper() }
        elseif i+1 == 7 then
            myApp.targheUtente_7 = { trimString( targa ):upper() }
        elseif i+1 == 8 then
            myApp.targheUtente_8 = { trimString( targa ):upper() }
        elseif i+1 == 9 then
            myApp.targheUtente_9 = { trimString( targa ):upper() }
        elseif i+1 == 10 then
            myApp.targheUtente_10 = { trimString( targa ):upper() }
        end
    end

    myApp.utenteLoggato = i+1
end




function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE")

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
