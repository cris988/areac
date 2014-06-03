local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local newTitle = {}
local makeList = {}
local retrieveData = {}

-- variabili
local param = 0
local targheTable
local importoTable
local periodoTable
local title
local scrollView 
myApp.ricerca = {}
-- local xRadio = 0.1
-- local yRadio = 0.25





function scene:createScene(event)

  print("CREA SCENA RICERCA")

  local group = self.view

  -- Sfondo

  local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
  background:setFillColor( 1 )
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  group:insert(background)

  -- Contenuto

  -- Soluzione con Switch Radio
  -- for i = 1, #targhe do
  -- 	optionsRadio(targhe[i], "prova", group)
  	-- end


  myApp.ricerca = {}

  scrollView = widget.newScrollView
  {
      top = titleBar.height,
      left = 0,
      width =  _W,
      height = _H,
      scrollWidth = _W,
      scrollHeight = _H,
      bottomPadding = 100,
      horizontalScrollDisabled = true,

  }


  local y = 0
  local padding = 20

  -- Primo blocco Targhe

  y = y + padding


  title = newTitle("Targa", 0.1 * _W, y)

  local targhe = retrieveData(2)
  local height = 50 * #targhe
  y = y + padding + 22
  targheTable = makeList("t", targhe, 1, 0, y, _W, height, 50)
  y = y + height

  scrollView:insert(title)
  scrollView:insert(targheTable)
  -- Secondo blocco Periodo

  y = y + padding

  title = newTitle("Periodo", 0.1 * _W, y)

  local periodo = { 10, 20, 30} 
  local height = 50 * #periodo
  y = y + padding  +22
  periodoTable = makeList("p", periodo, 2, 0, y, _W, height, 50)
  y = y + height

  scrollView:insert(title)
  scrollView:insert(periodoTable)

  -- Terzo blocco Importo

  y = y + padding

  title = newTitle("Importo", 0.1 * _W, y)

  local importo = retrieveData(3)
  local height = 50 * #importo
  y = y + padding+22
  importoTable = makeList("i", importo, 3, 0, y, _W, height, 50)

  scrollView:insert(title)
  scrollView:insert(importoTable)

  group:insert(scrollView)


end

function makeList(name, values, id, x, y, width, height, rowHeight) 

	local group = display.newGroup( )

	local tableView = widget.newTableView
	{
	    x = x,
	    y = y,
	    id = id,
	    height = height,
	    width = width,
	    isLocked = true,
	    onRowRender = onRowRender,
	    onRowTouch = onRowTouch,
	    id = name
	}

	for i = 1, #values do
	    -- Insert a row into the listaInfo
	    tableView:insertRow(
	    {
	        isCategory = false,
	        rowHeight = rowHeight,
	        params = {
	        	value = values[i],
	   		}
	    })

	end

	tableView.anchorX = 0
	tableView.anchorY = 0

	group:insert(tableView)

  local lineA = display.newLine( group, x, y, width, y)
  lineA:setStrokeColor( 0.8, 0.8, 0.8 )
  local lineB = display.newLine( group, x, y + tableView.height - 1, width, y + tableView.height - 1)
  lineB:setStrokeColor( 0.8, 0.8, 0.8 )

    return group
end

function onRowRender( event )

    -- Get reference to the row group
    local row = event.row

    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

    local rowTitle = display.newText(row, row.params.value,  0, 0, myApp.font, 18 )
    rowTitle:setFillColor( 0 )

    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 20
    rowTitle.y = rowHeight * 0.5
end

function onRowTouch( event )    
    local row = event.target

    if event.phase == "release" or event.phase == 'tap' then
  		row._cell:setFillColor( 0.062745,0.50980,0.99607 )
      myApp.ricerca[row.parent.parent["id"]] = row.params.value
      for k, _ in pairs(row.parent.parent._view._rows ) do
      	if row.id ~= row.parent.parent._view._rows[k]._view.id then
      		row.parent.parent._view._rows[k]._view._cell:setFillColor( 1,1,1 )
      	end
      end
    end
 end

function newTitle(text, x, y)
	-- Stampo titoli sezioni
	local title = display.newText
	{
        text = text,
        x = x,
        y = y,
        font = myApp.font,
        fontSize = 22,
        align = "left",
        width= 80
    }
    title:setFillColor( 0, 0, 0 )
    title.anchorX = 0
    title.anchorY = 0
    return title

end

-- function optionsRadio(text, id, group)
-- 	local diametro = 20
-- 	radio = widget.newSwitch
--     {
--        width = diametro,
--        height = diametro,
--        x = _W * xRadio,
--        y = _H * yRadio,
--        style = "radio",
--        id = id,
--        initialSwitchState = false,
--     }
--     radio.anchorX = 0
--     radio.anchorY = 0
--     group:insert(radio)

--     local text = display.newText
-- 	{
--         text = text,
--         x = _W * xRadio + diametro,
--         y = _H * yRadio,
--         font = myApp.font,
--         fontSize = 18,
--         align = "left",
--         width= 80,
--         id = id
--     }
--     text:setFillColor( 0, 0, 0 )
--     text.anchorX = 0
--     text.anchorY = 0
--     group:insert(text)

--     xRadio = xRadio + 0.3
-- end

function retrieveData(index)
	-- Recupero valori unici
	local uniqueValues = {}
	local valori = {}
	local utente = myApp.transiti[1]

	--Manca l'utente
	for i = 1, #utente do
		uniqueValues[utente[i][index]] = true
	end

	i = 1
	for k, _  in pairs(uniqueValues) do
		valori[i] = k
		i = i+1
	end
	return valori
end


function scene:enterScene( event )
    print("ENTRA SCENA RICERCA")

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Ricerca"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.profilo.isVisible = false
    myApp.titleBar.ricerca.isVisible = false
    myApp.titleBar.cerca.isVisible = true
    myApp.titleBar.indietro.scene = storyboard.getPrevious()

    myApp.tabBar.isVisible = false
end

function scene:exitScene( event )
    print("ESCI SCENA RICERCA")
    myApp.tabBar.isVisible = true
    myApp.titleBar.cerca.isVisible = false
    myApp.titleBar.cerca.isVisible = false
    targheTable:removeSelf()
    periodoTable:removeSelf()
    importoTable:removeSelf()
    
    if next(myApp.ricerca) == nil then
      myApp.ricerca = nil
    end
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA RICERCA")
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