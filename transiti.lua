local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local makeList ={}

-- variabili
local scrollView
local titles = {"DATA", "TARGA", "IMPORTO"}


function scene:createScene(event)

    print("CREA SCENA TRANSITI")

    local group = self.view

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Transiti"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.profilo.isVisible = false
    myApp.titleBar.ricerca.isVisible = true
    myApp.titleBar.indietro.scene = "profilo"
    myApp.tabBar.isVisible = false

    myApp.titleBar.indietro.optionsBack = { effect = "slideRight", time = 500 }
  
    -- Background

    library.setBackground(group, {0.9,0.9,0.9})


    local utente = myApp.transiti[myApp.utenteLoggato]

    if myApp.ricerca == nil then
        makeList(group, utente)	
    else
        local transiti = {}
        local periodo = nil

        if myApp.ricerca["p"] ~= nil then
            periodo = tonumber(string.sub(myApp.ricerca["p"], 8,9))
        end

        for i = 1, #utente do
            local transito = utente[i]

            if periodo ~= nil then
                -- Verifica se è nell'intervallo
                inDate = periodo >= math.ceil(os.difftime(os.time(),parseDate(transito[1])) / 60 / 60 / 24)
            end


            if transito[2] == myApp.ricerca["t"] and transito[3] == myApp.ricerca["i"] and inDate then
                print("t+i+p")
                table.insert(transiti, transito)

            elseif transito[2] == myApp.ricerca["t"] and transito[3] == myApp.ricerca["i"] and periodo == nil  then
                print("t+i")
                table.insert(transiti, transito)

            elseif transito[3] == myApp.ricerca["i"] and inDate and myApp.ricerca["t"] == nil then
                print("i+p")
                table.insert(transiti, transito)

            elseif transito[2] == myApp.ricerca["t"] and inDate and myApp.ricerca["i"] == nil then
                print("t+p")
                table.insert(transiti, transito)

            elseif transito[3] == myApp.ricerca["i"] and periodo == nil and myApp.ricerca["t"] == nil  then
                print("i+p")
                table.insert(transiti, transito)

            elseif transito[2] == myApp.ricerca["t"] and myApp.ricerca["i"] == nil and periodo == nil then
                print("t")
                table.insert(transiti, transito)

            elseif transito[3] == myApp.ricerca["i"] and myApp.ricerca["t"] == nil and periodo == nil then 
                print("i")
                table.insert(transiti, transito)

            elseif inDate and myApp.ricerca["t"] == nil and myApp.ricerca["i"] == nil  then
                print("p")
                table.insert(transiti, transito)
            end
        end

        makeList(group, transiti)
    end
 end


 function parseDate(dateString)
    local pattern = "(%d+)%/(%d+)%/(%d+)"
    local xday, xmonth, xyear = dateString:match(pattern)
    local convertedTimestamp = os.time({year = xyear, month = xmonth, day = xday})
    return convertedTimestamp
end

 function makeList(group, transiti)

    local textX = { 0.17, 0.5, 0.83}
    local textY = 0.17 * _H
	local lineV1X = _W * 0.33
	local lineV2X = _W * 0.66
    local padding = 5


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

		textY = textY + padding + 15

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
end

function scene:exitScene( event )
    print("ESCI SCENA TRANSITI")
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
