local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local makeList ={}

-- variabili
local titles = {"DATA", "TARGA", "IMPORTO"}


function scene:createScene(event)

    print("CREA SCENA TRANSITI")

    local group = self.view

    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor( 1 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)


    local utente = myApp.transiti[1]


    if myApp.ricerca == nil then
        makeList(group, utente)	
    else
        local transiti = {}
        local date = os.date( "%d%m%y" )

        for i = 1, #utente do
            local transito = utente[i]


            if transito[2] == myApp.ricerca["t"] then
                if transito[3] == myApp.ricerca["i"] then
                    print(transito[3] )
                    if myApp.ricerca["p"]~= nil and transito[1] >= date - myApp.ricerca["p"] then
                        print("t+i+p")
                        table.insert(transiti, transito)
                    else
                        print("t+i")
                        table.insert(transiti, transito)
                    end
                elseif myApp.ricerca["p"]~= nil and transito[1] >= date-myApp.ricerca["p"] then
                        print("t+p")
                        table.insert(transiti, transito)
                elseif myApp.ricerca["i"] == nil and myApp.ricerca["p"] ==nil then
                        print("t")
                        table.insert(transiti, transito)    
                end
            elseif myApp.ricerca["t"] == nil and transito[1] == myApp.ricerca["p"] then
                if myApp.ricerca["p"]~= nil and transito[1] >=  date - myApp.ricerca["p"] then
                    print("p+i")
                    table.insert(transiti, transito)
                else
                    print("p")
                    table.insert(transiti, transito)
                end
            elseif myApp.ricerca["t"] == nil and myApp.ricerca["p"] == nil and transito[3] ==  myApp.ricerca["i"] then
                print("i")
                table.insert(transiti, transito)
            end
        end
        makeList(group, transiti) 
    end
 end
--and utente[i][3] == myApp.ricerca["i"] 

 function makeList(group, transiti)

    local textX = { 0.15, 0.5, 0.8}
    local textY = 0.17 * _H
	local lineV1X = _W * 0.33
	local lineV2X = _W * 0.66
    local padding = 10


    -- Stampa titoli
 	for i = 1, #titles do

	    title = display.newText(group, titles[i], 0, 0, myApp.font, 18 )
	    title:setFillColor( 0 )
	    title.x = _W * textX[i]
	    title.y = textY

	end

	textY = textY + title.height / 2 + padding

	-- Stampa linea di separazione titolo

    local lineH = display.newLine( group, 0, textY, _W, textY)
    lineH:setStrokeColor( 0.8, 0.8, 0.8 )

	-- Stampa transiti

	for i = 1, #transiti do

		textY = textY + padding + 5

		for j = 1, #transiti[i] do
	   		transito = display.newText(group, transiti[i][j], 0, 10, myApp.font, 18 )
		    transito:setFillColor( 0 )
		    transito.x = _W * textX[j]
		    transito.y = textY
		end

		textY = textY + transito.height / 2  + padding

    	local line = display.newLine( group, 0, textY, _W, textY)
    	line:setStrokeColor( 0.8, 0.8, 0.8 )

	end

	-- Stampa linee verticali

 	local lineV1 = display.newLine( group, lineV1X , 0, lineV1X, textY)
    lineV1:setStrokeColor( 0.8, 0.8, 0.8 )

    local lineV2 = display.newLine( group, lineV2X, 0, lineV2X, textY)
    lineV2:setStrokeColor( 0.8, 0.8, 0.8 )


 end


function scene:enterScene( event )
    print("ENTRA SCENA TRANSITI")

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Transiti"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.profilo.isVisible = false
    myApp.titleBar.ricerca.isVisible = true
    myApp.titleBar.indietro.scene = "profilo"

    myApp.tabBar.isVisible = false
end

function scene:exitScene( event )
    print("ESCI SCENA TRANSITI")
    myApp.tabBar.isVisible = true
    myApp.titleBar.ricerca.isVisible = false
    myApp.ricerca = nil
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA TRANSITI")
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
