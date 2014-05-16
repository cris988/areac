local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local goBack = {}
local accediProfilo = {}
local inputTarga = {}
local AvantiScene = {}
local textListener = {}
local clearListener = {}
local trimString = {}

-- variabili
local accedi
local avanti
local titleBar
local titleText
local campoInserimento
local sfondoInserimento
local btClear

local string = "Inserisci la targa per controllare se il tuo veicolo è adibito ad accedere all\'area C e con che modalità"



local function ignoreTouch( event )
	return true
end














function scene:createScene(event)
	local group = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    ------ instanzio nav bar e bottoni
    titleBar = display.newImageRect(myApp.topBarBg, display.contentWidth, 50)
    titleBar.x = display.contentCenterX
    titleBar.y = 25 + display.topStatusBarContentHeight

    titleText = display.newText( 'Verifica targa', 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor(0,0,0)
    titleText.x = display.contentCenterX
    titleText.y = titleBarHeight * 0.5 + display.topStatusBarContentHeight

	accedi = widget.newButton({
        id  = 'BtAccedi',
        label = 'Accedi',
        x = display.contentCenterX*1.75,
        y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 18,
        onRelease = AccediProfilo
    })
    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.7,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        onRelease = AvantiScene
    })
    group:insert(titleBar)
    group:insert(titleText)
    group:insert(accedi)
    group:insert(avanti)

    -- local statusBarBackground = display.newImageRect(myApp.topBarBg, display.contentWidth, display.topStatusBarContentHeight)
    -- statusBarBackground.x = display.contentCenterX
    -- statusBarBackground.y = display.topStatusBarContentHeight * 0.5
    -- group:insert(statusBarBackground)









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









    -- creazione textArea per targa

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', 564*0.45, 62*0.6)
    sfondoInserimento.x = _W*0.5
    sfondoInserimento.y = _H*0.45

    campoInserimento = native.newTextField( 40, 85, 195, 28)
    campoInserimento.x = _W/2
    campoInserimento.y = _H*0.45
    campoInserimento:setTextColor( 204,204,204 )
    campoInserimento.size = 17
    campoInserimento.font = native.newFont( myApp.font, 17 )
    campoInserimento.align = "center"
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = 'Targa'

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = _W*0.85
    btClear.y = _H*0.45
    btClear.alpha = 0

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    group:insert(gruppoInserimento)


    if myApp.targaVerifica == nil then
    else 
        campoInserimento.text = myApp.targaVerifica
    end

    campoInserimento:addEventListener( "userInput", textListener)



end











-- fa il trim della stringa inserita dall'utente
function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end

--gestisce le fasi dell'inserimento della targa
function textListener( event )
    if event.phase == "began" then
        if event.target.text == '' then
        else
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListener )
        end
        campoInserimento:setTextColor( 0 )
    elseif event.phase == "editing" then
        
        if(#event.target.text > 0) then
            btClear.alpha = 0.2
            btClear:addEventListener( "touch", clearListener )
        else
            btClear.alpha = 0
            btClear:removeEventListener( "touch", clearListener )
        end
    elseif event.phase == "ended" then
        if event.target.text == '' then
            btClear.alpha = 0
            campoInserimento:setTextColor( 204,204,204)

        end
    end
end

-- gestisce la comparsa del pulsate clear
function clearListener( event ) 
    if(event.phase == "began") then
        event.target.alpha = 0.8
    elseif(event.phase == "cancelled") then
        event.target.alpha = 0.2
    elseif(event.phase == "ended") then
        campoInserimento.text = ''
        native.setKeyboardFocus( campoInserimento )
        btClear.alpha = 0
        btClear:removeEventListener( "touch", clearListener )
    end
end












-- funzioni per pulsanti

function AvantiScene ()
    if campoInserimento.text == '' then
    
    -- controllo se il formato della targa è giusto
    elseif #campoInserimento.text == 7 and campoInserimento.text:match( '[A-Za-z][A-Za-z][0-9][0-9][0-9][A-Za-z][A-Za-z]' ) then
        -- passo la targa come parametro facendogli il trim e l'upperCase
        storyboard.gotoScene('verificatarga2', { params = { targa = trimString( campoInserimento.text ):upper() } })
    end
end

function AccediProfilo()
    storyboard.removeAll()
    storyboard.gotoScene("accedi")
end

function goBack()
    storyboard.removeAll()
    storyboard.gotoScene(storyboard.getPrevious())
end

















function scene:enterScene( event )
	local group = self.view

end

function scene:exitScene( event )
	local group = self.view
    campoInserimento:removeSelf()
    myApp.targaVerifica = nil


	--
	-- Clean up native objects
	--

end

function scene:destroyScene( event )
	local group = self.view
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
