local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

-- funzioni
local makeList ={}

-- variabili
local titles = {"DATA", "TARGA", "IMPORTO"}
local transitiTable = {}


function scene:createScene(event)

    print("CREA SCENA TRANSITI")

    local group = self.view

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Transiti"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.ricerca.isVisible = true
  
    -- Background

    library.setBackground(group, _Background)


    local utente = myApp.transiti[myApp.utenteLoggato]


    scrollView = widget.newScrollView
    {
      top = myApp.titleBar.height,
      left = 0,
      width =  _W,
      height = _H - myApp.titleBar.height,
      scrollWidth = _W,
      scrollHeight = 0,
      horizontalScrollDisabled = true,
      hideBackground = true
    }

    -- Se non è una ricerca
    if myApp.ricerca == nil then
        transitiTable = makeList(utente)
    else
        -- Se è una ricerca
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

        transitiTable = makeList(transiti)

    end
    
    scrollView:insert(transitiTable)
    
    group:insert(scrollView)
 end


 function parseDate(dateString)
    local pattern = "(%d+)%/(%d+)%/(%d+)"
    local xday, xmonth, xyear = dateString:match(pattern)
    local convertedTimestamp = os.time({year = xyear, month = xmonth, day = xday})
    return convertedTimestamp
end

 function makeList(transiti)

    local textX = { 0.17, 0.5, 0.83}
    local textY = 20
	local lineV1X = _W * 0.33
	local lineV2X = _W * 0.66
    local padding = 5
    local group = display.newGroup( )


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

    return group
 end


function scene:enterScene( event )
    print("ENTRA SCENA TRANSITI")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA TRANSITI")
    myApp.titleBar.ricerca.isVisible = false
    myApp.titleBar.indietro.isVisible = false
    myApp.ricerca = nil
    transitiTable:removeSelf( )
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA TRANSITI")
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
