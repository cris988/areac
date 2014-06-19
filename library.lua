--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local widget = require( "widget" )
local myApp = require( "myapp" ) 

library = {}

local function setBackground(group, color)
    local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
    background:setFillColor(color[1], color[2], color[3])
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)
end

local function checkLogIn()
	if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
        myApp.titleBar.profilo.isVisible = false
    else
        myApp.titleBar.profilo.isVisible = true
        myApp.titleBar.accedi.isVisible = false
    end
end


local function onRowRender( event )

    -- Get reference to the row group
    local row = event.row

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    local rowTitle = display.newText( row, row.params.value, 0, 0, myApp.font, 18 )
    rowTitle:setFillColor( 0 )

    rowTitle.anchorX = 0
    rowTitle.x = 20
    rowTitle.y = rowHeight * 0.5

    if row.params.arrow == true then

	    local rowArrow = display.newImage( row, "img/rowArrow.png", false )
	    rowArrow.x = row.contentWidth - 20
	    rowArrow.anchorX = 1
	    rowArrow.y = row.contentHeight * 0.5

	end
end


local function makeList(id, values, x, y, width, height, rowHeight, arrow, eventRowRender, eventRowTouch) 

	local group = display.newGroup( )

    x = math.ceil(x)
    y = math.ceil(y)

	if eventRowRender == nil then eventRowRender = onRowRender end

	local tableView = widget.newTableView
	{
	    x = x,
	    y = y,
	    id = id,
	    height = height,
	    width = width,
	    isLocked = true,
	    onRowRender = eventRowRender,
	    onRowTouch = eventRowTouch,
	}

	for i = 1, #values do


        local rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } }
        local lineColor

        if i < #values then lineColor = { 0.8, 0.8, 0.8 }  else lineColor = { 1, 1, 1 } end

	    -- Insert a row into the listaInfo
	    tableView:insertRow(
	    {
	        isCategory = false,
	        rowHeight = rowHeight,
	        rowColor = rowColor,
            lineColor = lineColor,
	        params = {
	        	value = values[i],
	        	arrow = arrow
	   		}
	    })

	end

	tableView.anchorX = 0
	tableView.anchorY = 0

	group:insert(tableView)

	local lineA = display.newLine( group, x, y, width, y)
	lineA:setStrokeColor( 0.8, 0.8, 0.8 )
	local lineB = display.newLine( group, x, tableView.y + tableView.height - 1, width, tableView.y + tableView.height - 1)
	lineB:setStrokeColor( 0.8, 0.8, 0.8 )


	return group

end

function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end

local function clearListener( campoInserimento, btClear ) 
   return function (event)

	    if(event.phase == "began") then
	        btClear.alpha = 0.8
	    elseif(event.phase == "cancelled") then
	        btClear.alpha = 0.5
	    elseif(event.phase == "ended") then
	        campoInserimento.text = ''
	        native.setKeyboardFocus( campoInserimento )
	        btClear.alpha = 0
	    end
	end
end

local function textListener(group, campoInserimento, btClear ) 

	return function(event)
	    if event.phase == "began" then
            if campoInserimento.y > _H * 0.5 then
                transition.to( group, {time=120, y=-campoInserimento.y+_H*0.5} )
            end
	        if campoInserimento.text ~= '' then
	            btClear.alpha = 0.2
	        end
	        campoInserimento:setTextColor( 0 )
	    elseif event.phase == "editing" then
	        if(#campoInserimento.text > 0) then
	            btClear.alpha = 0.2
	        else
	            btClear.alpha = 0
	        end

	    elseif event.phase == "ended" then
	        if campoInserimento.text == '' then
	            btClear.alpha = 0
	        end
            --native.setKeyboardFocus( nil )
            --transition.to( group, {time=100, y=0} )
    	elseif event.phase == "submitted" then
            native.setKeyboardFocus( nil )
            transition.to( group, {time=100, y=0} )
        end
     end
end

local function textArea(group, x, y, width, height, color, font, align, text, secure)

    local gruppoInserimento = display.newGroup()

    sfondoInserimento = display.newImageRect('img/textArea.png', width * 1.4, height * 1.3)
    sfondoInserimento.x = x
    sfondoInserimento.y = y

    campoInserimento = native.newTextField( x, y, width, height) 
    campoInserimento:setTextColor( color[1], color[2], color[3] )
    campoInserimento.font = font
    campoInserimento.align = align
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = text
    if secure ~= nil then campoInserimento.isSecure = secure end

    btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = campoInserimento.x + campoInserimento.width * 0.6
    btClear.y = campoInserimento.y
    btClear.alpha = 0


    if campoInserimento.text ~= "" then
        btClear.alpha = 0.2
    end

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    btClear:addEventListener( "touch", clearListener(campoInserimento, btClear) )
    campoInserimento:addEventListener( "userInput", textListener(group, campoInserimento, btClear))

    gruppoInserimento.campo = campoInserimento
    gruppoInserimento.bg = sfondoInserimento

    return gruppoInserimento

end

-- local function verificaTarga(targa)

--     local accesso = false

--     local targaTrovata = false

--     local numTarghe = myApp:getNumTarghe()

--     for i = 1, numTarghe, 1 do
--         if targa == myApp.targhe[i].targa and targaTrovata == false then
--             -- targa presente nel database
--             accesso = myApp.targhe[i].accesso
--             targaTrovata = true
--         end
--     end

--     num = math.random()
--     print(num)
--     -- Aggiunta nuova targa nel database
--     if targaTrovata == false then
--         if num <= 0.80 then
--             myApp.targhe[numTarghe+1] = { targa = targa , accesso = true }
--             accesso = true
--         elseif num <= 0.90 then
--             -- myApp.targhe[numTarghe+1] = { targa = targa , accesso = true }
--             -- accesso = true
--         else
--             myApp.targhe[numTarghe+1] = { targa = targa , accesso = false }
--         end
--     end

--     return accesso
-- end


local function salvaUtente(utente, id)
    for k,v in pairs(utente) do
        myApp.utenti[id][k] = v
    end
end




library.makeList = makeList
library.setBackground = setBackground
library.trimString = trimString
library.textArea = textArea
library.checkLogIn = checkLogIn
--library.verificaTarga = verificaTarga
library.salvaUtente = salvaUtente

return library