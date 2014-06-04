local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local step0 = {}
local step1 ={}

-- variabili
local txtTarga
local step
local targa
local group0 
local group1
local textError
local background = {1,1,1}

local string = "Inserisci la targa per controllare se il tuo veicolo è adibito ad accedere all\'area C e con che modalità"


local function ignoreTouch( event )
	return true
end


function scene:createScene(event)

    print("CREA SCENA VERIFICA")
	local group = self.view
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Verifica Targa"
    
    myApp.tabBar.isVisible = true
    
    library.checkLogIn()

    -- Background

    library.setBackground(group, background )

    step = 0

end

-- Gestisce il primo step di Verifica Targa

function step0(group)

    print("Verifica Targa Step 0")

    local verifica = widget.newButton({
        id  = 'BtVerifica',
        label = 'Verifica',
        x = _W*0.5,
        y = _H*0.8,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = verificaButton
    })
    group:insert(verifica)


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


    txtTarga =library.textArea(_W*0.5, _H*0.5, 160, 28, {1,0,0}, native.newFont( myApp.font, 17 ), "center", "Targa")

    group:insert(txtTarga)

    textError = display.newText('',0,0)
    group:insert(textError)

    return group
end

-- Gestisce il secondo step di Verifica Targa

function step1(group)
   
    print("Verifica Targa Step 1")

    local accesso = library.verificaTarga(targa)

    if accesso then
        line1 = display.newText( 'Il veicolo con targa '..targa,  _W*0.5, 100, myApp.font, 20)
        line1:setFillColor(0)
        line2 = display.newText( 'PUO\' ACCEDERE',  _W*0.5, 125, myApp.font, 20)
        line2:setFillColor(0.1333,0.54509,0.13334)
        line3 = display.newText( 'all\'area C',  _W*0.5, 150, myApp.font, 20)
        line3:setFillColor(0)
        line4 = display.newText( 'ACCESSO A PAGAMENTO', _W*0.5, _H*0.5, myApp.font, 24 )
        line4:setFillColor(0.1333,0.54509,0.13334)

        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.8,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaButton
        })

        group:insert(line1)
        group:insert(line2)
        group:insert(line3)
        group:insert(line4)
        group:insert(acquista)

    else

        line1 = display.newText( 'Il veicolo con targa '..targa,  _W*0.5, (_H*0.5)-25, myApp.font, 20)
        line1:setFillColor(0)
        line2 = display.newText( 'NON PUO\' ACCEDERE',  _W*0.5, _H*0.5, myApp.font, 20)
        line2:setFillColor(1,0,0)
        line3 = display.newText( 'all\'area C',  _W*0.5, (_H*0.5)+25, myApp.font, 20)
        line3:setFillColor(0)  

        group:insert(line1)
        group:insert(line2)
        group:insert(line3)
    end
    return group
end



-- Funzioni per pulsanti

function acquistaButton()
    myApp.tabBar:setSelected( 3 )
    storyboard.gotoScene('acquista2', { params = { targa = targa } })
end


function verificaButton()

    if txtTarga.campo.text == '' then
    
    -- controllo se il formato della targa è giusto

    --ESPLODE IN CASO DI VERIFICA TARGA REGISTRATA
    elseif #txtTarga.campo.text == 7 and txtTarga.campo.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
        targa = library.trimString( txtTarga.campo.text ):upper()
        storyboard.reloadScene( )
    else
       txtTarga.campo:setTextColor(1,0,0)
        
        -- testo di errore
        textError.x = _W*0.5
        textError.y = _H*0.555
        textError.fontSize = 12
        textError.text = 'FORMATO NON CORRETTO'
        textError:setFillColor( 1, 0, 0 )
    end
end




function scene:enterScene( event )
    print("ENTRA SCENA VERIFICA")

    local group = self.view


    --[[ Se sono al 1° step creo il group0 locale
        Se sono al 2° step creo il group1 locale
        Alla fine aggancio il group0 o group1 al group della scena
    ]]--

    if step == 0 then

        group0 = display.newGroup()
        group:insert(step0(group0))
        myApp.titleBar.indietro.isVisible = false
        myApp.titleBar.logo.isVisible = true
    else
        group1 = display.newGroup()
        group:insert(step1(group1))
        myApp.titleBar.logo.isVisible = false
        myApp.titleBar.indietro.isVisible = true
        myApp.titleBar.indietro.scene = "verificatarga"

    end

end

function scene:exitScene( event )
    print("ESCI SCENA VERIFICA")

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
    print("DISTRUGGI SCENA VERIFICA")
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
