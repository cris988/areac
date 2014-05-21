local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local views = {}
local disconnessione = {}


-- variabili
local disconnetti











function scene:createScene(event)
    local group = self.view

    print("CREA SCENA ACQUISTA")

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    disconnetti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Disconnetti utente',
        x = _W*0.5,
        y = _H*0.925,
        labelColor = { default = { 0.8470, 0.13725, 0.13725 }, },
        fontSize = 26,
        onRelease = disconnessione
    })
    group:insert(disconnetti)
    

    -- testo in alto
    local options = {
        text = myApp.utenti[myApp.utenteLoggato].nome ..' '.. myApp.utenti[myApp.utenteLoggato].cognome,
        x = _W*0.5,
        y = _H*0.175,
        font = myApp.font,
        fontSize = 26,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)







end


















-- function goBack()
--     storyboard.removeAll()

--     if storyboard.getPrevious() == 'accedi' or
--     	storyboard.getPrevious() == 'riepilogo' then
--     	storyboard.gotoScene('mappa')
--     else
--     	storyboard.gotoScene(storyboard.getPrevious())
--     end
-- end










function disconnessione()
    myApp.utenteLoggato = 0
    myApp.tabBar:setSelected( 1 )
    storyboard.gotoScene('mappa')
end












function scene:enterScene( event )
    print("ENTRA SCENA PROFILO")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Profilo"
    myApp.titleBar.indietro.isVisible = true
    
	myApp.titleBar.indietro.scene = storyboard.getPrevious()

    if storyboard.getPrevious() == 'acquista2' then
        myApp.titleBar.indietro.optionsBack =  { params = { var = myApp.index, targa = myApp.targaAcquista } }
    elseif storyboard.getPrevious() == 'verificatarga2' then
        myApp.titleBar.indietro.optionsBack = { params = { var = myApp.index, targa = myApp.targaVerifica } }
    elseif storyboard.getPrevious() == 'riepilogo' or
    	storyboard.getPrevious() == 'accedi' then
        myApp.tabBar:setSelected( 1 )
        myApp.titleBar.indietro.scene = 'mappa'
    end

    myApp.tabBar.isVisible = false
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = false
    end

end

function scene:exitScene( event )
    print("ESCI SCENA PROFILO")

    myApp.tabBar.isVisible = true
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA PROFILO")
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
