--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local widget = require( "widget" )
local myApp = require( "myapp" ) 

library = {}

local function setBackground(group, color)
    local background = display.newRect(0,0,display.contentWidth, display.contentHeight+225)
    background:setFillColor(color[1], color[2], color[3])
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    group:insert(background)

    -- local function listener( event )
    --     native.setKeyboardFocus( nil )
    --     print("toccato bg")
    -- end
    -- background:addEventListener( "touch", listener )


end

local function checkLogIn(state)
	if myApp.utenteLoggato > 0 then
        if state == "accedi" then
            return false
        else
            return true
        end
    else
        if state == "accedi" then
            return true
        else
            return false
        end
    end
end

local function setNameLogin()

    local nome = myApp.utenti[myApp.utenteLoggato].nome
    if #myApp.utenti[myApp.utenteLoggato].nome > 8 then
        nome = myApp.utenti[myApp.utenteLoggato].nome:sub(1, 7) .. '...'
        myApp.titleBar.profilo.anchorX = 1
        myApp.titleBar.profilo.x = _W*0.98
    end
    myApp.titleBar.profilo:setLabel( nome )

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

    if row.params.arrow ~= nil and row.params.arrow == true then

	    local rowArrow = display.newImage( row, "img/rowArrow.png", false )
	    rowArrow.x = row.contentWidth - 20
	    rowArrow.anchorX = 1
	    rowArrow.y = row.contentHeight * 0.5

	end

    if row.params.x ~= nil then
        rowTitle.x = row.params.x
    end
end


local function makeList(id, values, x, y, width, rowHeight, paramsRow, eventRowRender, eventRowTouch, scrollView) 

	local group = display.newGroup( )
    local listener = {}

    x = math.ceil(x)
    y = math.ceil(y)

    if eventRowRender == nil then eventRowRender = onRowRender end
	if eventRowTouch == nil then eventRowTouch = onRowTouch end
    if scrollView ~= nil then listener = function (event) scrollView:takeFocus(event) end end

	local tableView = widget.newTableView
	{
	    x = 0,
	    y = 0,
	    id = id,
	    height = rowHeight * #values,
	    width = width,
	    isLocked = true,
	    onRowRender = eventRowRender,
	    onRowTouch = eventRowTouch,
        listener = listener
	}

	for i = 1, #values do


        local rowColor = { default={ 1, 1, 1 }, }
        local lineColor

        if i < #values then lineColor = { 0.8, 0.8, 0.8 }  else lineColor = { 1, 1, 1 } end


        local options = {
            isCategory = false,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor,
            params = {
                value = values[i],
            }
        }

        if paramsRow ~= nil then
            for k,v in pairs(paramsRow) do
                options.params[k] = v
            end
        end


	    -- Insert a row into the listaInfo
	    tableView:insertRow(options)

	end

	tableView.anchorX = 0
	tableView.anchorY = 0

	group:insert(tableView)

	local lineA = display.newLine( group, 0, 0, width, 0)
	lineA:setStrokeColor( 0.8, 0.8, 0.8 )
	local lineB = display.newLine( group, 0, tableView.height - 1, width, tableView.height - 1)
	lineB:setStrokeColor( 0.8, 0.8, 0.8 )

    group.deleteRow = function(index, time, delay) 
                        tableView:deleteRow( index )
                        transition.to(lineB, { time = time, delay = delay, y = lineB.y - rowHeight} )
                    end

    group.x = x
    group.y = y

	return group

end

local function trimString( s )
   return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
end

local function matchTarga( t )

    local targa = string.match( t,'^[A-Za-z][A-Za-z]%s?[0-9][0-9][0-9]%s?[A-Za-z][A-Za-z]' )

    if targa ~= nil then
        return string.gsub(targa,'%s', "" )
    end
     
end

local function clearListener( campoInserimento ) 
   return function (event)

	    if(event.phase == "began") or (event.phase == "moved") then
	        event.target.alpha = 0.8
	    elseif(event.phase == "cancelled") then
	        event.target.alpha = 0.5
	    elseif(event.phase == "ended") then
	        campoInserimento.text = ''
	        native.setKeyboardFocus( campoInserimento )
	        event.target.alpha = 0
	    end
	end
end

local function textListener(group, campoInserimento, btClear, funcBegan, funcEnd, funcSub ) 

	return function(event)
	    if event.phase == "began" then
            if funcBegan ~= nil then
                funcBegan()
            end
            if campoInserimento.parent.y > _H * 0.5 then
                transition.to( group, {time=120, y=-campoInserimento.parent.y+_H*0.5} )
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
            if funcEnd ~= nil then
                funcEnd()
            end
    	elseif event.phase == "submitted" then
            if funcSub ~= nil then
                funcSub()
            end
            native.setKeyboardFocus( nil )
            transition.to( group, {time=100, y=0} )
        end
     end

end

local function textArea(group, x, y, width, height, color, font, align, text, secure, funcBegan, funcEnd, funcSub)

    local gruppoInserimento = display.newGroup()

    local sfondoInserimento = display.newImageRect('img/textArea.png', math.ceil(width * 1.4), math.ceil(height * 1.3))

    local campoInserimento = native.newTextField( sfondoInserimento.x, sfondoInserimento.y, width, height) 
    campoInserimento:setTextColor( color[1], color[2], color[3] )
    campoInserimento.font = font
    campoInserimento.align = align
    campoInserimento.hasBackground = false
    campoInserimento.placeholder = text
    if secure ~= nil then campoInserimento.isSecure = secure end
    if system.getInfo("model") ~= "iPhone" and system.getInfo("model") ~= 'iPhone Simulator' then
        campoInserimento.height = campoInserimento.height*2
    end

    local btClear = display.newImage('img/delete.png', 10,10)
    btClear.x = campoInserimento.x + campoInserimento.width * 0.6
    btClear.y = 0
    btClear.alpha = 0


    if campoInserimento.text ~= "" then
        btClear.alpha = 0.2
    end

    gruppoInserimento:insert(sfondoInserimento)
    gruppoInserimento:insert(campoInserimento)
    gruppoInserimento:insert(btClear)

    gruppoInserimento.anchorX = 0
    gruppoInserimento.anchorY = 0

    gruppoInserimento.x = math.ceil(x - gruppoInserimento.width * 0.5)
    gruppoInserimento.y = math.ceil(y - gruppoInserimento.height * 0.5)

    gruppoInserimento.anchorChildren = true

    btClear:addEventListener( "touch", clearListener(campoInserimento) )
    campoInserimento:addEventListener( "userInput", textListener(group, campoInserimento, btClear, funcBegan, funcEnd, funcSub))

    gruppoInserimento.campo = campoInserimento
    gruppoInserimento.bg = sfondoInserimento

    return gruppoInserimento

end

local function salvaUtente(utente, id)
    for k,v in pairs(utente) do
        myApp.utenti[id][k] = v
    end
end




library.makeList = makeList
library.setBackground = setBackground
library.trimString = trimString
library.matchTarga = matchTarga
library.textArea = textArea
library.checkLogIn = checkLogIn
library.salvaUtente = salvaUtente
library.setNameLogin = setNameLogin

return library