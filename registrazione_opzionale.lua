local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)

-- funzioni
local avantiButton = {}
local salvaUtente = {}

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
    areaT:setFillColor(0,0,0) 

    -- Text field dati
    txtTarga=library.textArea(group,_W*0.5, _H*0.4, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa principale")
    txtCell =library.textArea(group,_W*0.5, _H*0.55, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Cellulare")
    txtEmail =library.textArea(group,_W*0.5, _H*0.7, 195, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Email")


    -- Recupero dati in meoria
    if myApp.datiUtente.username ~= '' then
        txtTarga.campo.text = myApp.datiUtente.targa
        txtCell.campo.text = myApp.datiUtente.cellulare
        txtEmail.campo.text = myApp.datiUtente.email
    end


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
    group:insert(textError)


end


function avantiButton()
    local targa = txtTarga.campo.text
    local cell = txtCell.campo.text
    local email = txtEmail.campo.text

    if  targa ~= '' or cell ~= '' or email~='' then
        if #library.trimString( targa ) == 7 and library.trimString( targa ):match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then

            myApp.datiUtente.targa = trimString( txtTarga.campo.text ):upper()
            myApp.datiUtente.cell = trimString( txtCell.campo.text )
            myApp.datiUtente.email = trimString( txtEmail.campo.text )

            print("TARGA: "..txtTarga.campo.text)
            print("CELL: "..txtCell.campo.text)
            print("EMAIL: "..txtEmail.campo.text)

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

    local newUser = myApp:getNumUtenti() + 1
    if myApp.datiUtente.tipo == 'Residente' then
        myApp.datiUtente.accessi = 50
    end
    
    myApp.utenti[newUser] = {}
    myApp.targheUtente[newUser] = { myApp.datiUtente.targa }
    myApp.transiti[newUser] = {}

    library.salvaUtente(myApp.datiUtente, newUser)

    myApp.utenteLoggato = newUser
end




function scene:enterScene( event )
    print("ENTRA SCENA REGISTRAZIONE")

end

function scene:exitScene( event )
    print("ESCI SCENA REGISTRAZIONE")
    myApp.datiUtente = nil
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA REGISTRAZIONE")
end


scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
