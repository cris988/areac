local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local goBack = {}
local accediProfilo = {}
local acquistaTicket = {}



-- variabili
local indietro
local accedi
local titleBar
local titleText
local targa
local accesso
local acquista




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

    titleText = display.newText( 'Profilo', 0, 0, myApp.fontBold, 20 )
    titleText:setFillColor(0,0,0)
    titleText.x = display.contentCenterX
    titleText.y = titleBarHeight * 0.5 + display.topStatusBarContentHeight

	indietro = widget.newButton({
	    id  = 'BtIndietro',
	    label = 'Indietro',
	    x = display.contentCenterX*0.3,
	    y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    onRelease = goBack
	})
	accedi = widget.newButton({
        id  = 'BtAccedi',
        label = 'Accedi',
        x = display.contentCenterX*1.75,
        y = titleBarHeight * 0.5 + display.topStatusBarContentHeight,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 18,
        onRelease = AccediProfilo
    })
	group:insert(titleBar)
    group:insert(titleText)
    group:insert(indietro)
    group:insert(accedi)

    myApp.targaVerifica = event.params.targa





    accesso = math.random(4)


    -- l'auto può transitare
    if accesso < 4 then
        local myText1 = display.newText( 'Il veicolo con targa '..myApp.targaVerifica,  _W*0.5, 100, myApp.font, 20)
        myText1:setFillColor(0)
        local myText2 = display.newText( '\nPUO\' ACCEDERE',  _W*0.5, 125, myApp.font, 20)
        myText2:setFillColor(0.1333,0.54509,0.13334)
        local myText3 = display.newText( '\n\nall\'area C',  _W*0.5, 150, myApp.font, 20)
        myText3:setFillColor(0)
        group:insert(myText1)
        group:insert(myText2)
        group:insert(myText3)



        local myText4 = display.newText( 'ACCESSO A PAGAMENTO', _W*0.5, _H*0.5, myApp.font, 24 )
        myText4:setFillColor(0.1333,0.54509,0.13334)
        group:insert(myText4)



        acquista = widget.newButton({
            id  = 'BtAcquista',
            label = 'Acquista ticket',
            x = _W*0.5,
            y = _H*0.7,
            color = { 0.062745,0.50980,0.99607 },
            fontSize = 26,
            onRelease = acquistaTicket
        })
        group:insert(acquista)


    -- l'auto può transitare
    else
        local myText1 = display.newText( 'Il veicolo con targa '..myApp.targaVerifica,  _W*0.5, (_H*0.5)-25, myApp.font, 20)
        myText1:setFillColor(0)
        local myText2 = display.newText( '\nNON PUO\' ACCEDERE',  _W*0.5, _H*0.5, myApp.font, 20)
        myText2:setFillColor(1,0,0)
        local myText3 = display.newText( '\n\nall\'area C',  _W*0.5, (_H*0.5)+25, myApp.font, 20)
        myText3:setFillColor(0)
        group:insert(myText1)
        group:insert(myText2)
        group:insert(myText3)
    end








end






function acquistaTicket()

end

function AccediProfilo()
    storyboard.removeAll()
    storyboard.gotoScene("accedi")
end
function goBack()
    storyboard.removeAll()
    local sceneName = storyboard.getCurrentSceneName()
    storyboard.removeScene( sceneName )
    storyboard.gotoScene('verificatarga')
end











function scene:enterScene( event )
    local group = self.view
end

function scene:exitScene( event )
    local group = self.view
 
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