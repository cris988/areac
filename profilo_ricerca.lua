--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local newTitle = {}
local retrieveData = {}
local onRowRender = {}
local onRowTouch = {}
local order = {}

-- variabili
local targheTable
local importoTable
local periodoTable
local scrollView 


myApp.ricerca = {}


function scene:createScene(event)

  print("CREA SCENA RICERCA")

  local group = self.view


  -- Background

  library.setBackground(group, _Background )
  
  -- Preparo titleBar

  myApp.titleBar.titleText.text = "Ricerca"
  myApp.titleBar.indietro.isVisible = true
  myApp.titleBar.cerca.isVisible = true

  -- Contenuto

  myApp.ricerca = {}

  local options = {
        text = "Seleziona i criteri per la ricerca",
        x = _W*0.5,
        y = _H*0.175,
        font = myApp.font,
        fontSize = 20,
        align = "center",
        width = _W
    }
  local areaT = display.newText( options )
  areaT:setFillColor( 0, 0, 0 )
  group:insert(areaT)


  scrollView = widget.newScrollView
  {
      top = (areaT.height + areaT.y),
      left = 0,
      width =  _W,
      height = _H - (areaT.height + areaT.y),
      scrollWidth = _W,
      scrollHeight = 0,
      bottomPadding = 100,
      horizontalScrollDisabled = true,
      hideBackground = true
  }

  local y = 0
  local x = 0.05 * _W
  local padding = 20

  -- Primo blocco Targhe


  title = newTitle("Targa", x, y, _W, 40)


  local targhe = retrieveData(2)
  order(targhe)
  local height = 40 * #targhe
  y = y + 40
  targheTable = library.makeList("t", targhe, 0, y, _W, height, 40, false, onRowRender, onRowTouch)
  y = y + height

  scrollView:insert(title)
  scrollView:insert(targheTable)
  
  --Secondo blocco Periodo

  y = y + padding

  title = newTitle("Periodo", x, y, _W, 40)

  local periodo = { "Ultimi 10 giorni", "Ultimi 20 giorni", "Ultimi 30 giorni"} 
  local height = 40 * #periodo
  y = y + 40
  periodoTable = library.makeList("p", periodo, 0, y, _W, height, 40, false, onRowRender, onRowTouch)
  y = y + height

  scrollView:insert(title)
  scrollView:insert(periodoTable)

  -- Terzo blocco Importo

  y = y + padding

  title = newTitle("Importo", x, y, _W, 40)

  local importo = retrieveData(3)
  order(importo)
  local height = 40 * #importo
  y = y + 40
  importoTable = library.makeList("i", importo, 0, y, _W, height, 40, false, onRowRender, onRowTouch)
  y = y + height

  scrollView:insert(title)
  scrollView:insert(importoTable)

  scrollView:setScrollHeight( y )

  group:insert(scrollView)


end

function onRowTouch( event )    
    local row = event.target

    -- Disabilita le altre righe

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

function onRowRender( event )

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

function newTitle(text, x, y, width, height)

  local group = display.newGroup( )

  bg = display.newRect( 0, y, width, height)
  bg.anchorX =0
  bg.anchorY = 0
  bg:setFillColor( 0.95,0.95,0.95 )

	-- Stampo titoli sezioni
	local title = display.newText
	{
        text = text,
        x = 20,
        y = y + 5,
        font = myApp.font,
        fontSize = 22,
        align = "left",
        width = 80,
        height = 0
    }
    title:setFillColor( 0, 0, 0 )
    title.anchorX = 0
    title.anchorY = 0

    group:insert(bg)
    group:insert(title)

    return group
end

function retrieveData(index)
	-- Recupero valori unici
	local uniqueValues = {}
	local valori = {}
	local utente = myApp.transiti[myApp.utenteLoggato]

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

function order(values)
    table.sort(values)
end


function scene:enterScene( event )
    print("ENTRA SCENA RICERCA")
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA RICERCA")
    myApp.titleBar.indietro.isVisible = false
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

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene