local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 


titleBar = {}

function titleBar.new()

	print ("NEW TITLEBAR")
	local bgTitle = display.newImageRect(myApp.topBarBg, display.contentWidth, 72)
	bgTitle.x = display.contentCenterX
	bgTitle.y = display.topStatusBarContentHeight + 14
	myApp.topBarHeight = bgTitle.y*2

	titleBar.titleText = display.newText( '', 0, 0, myApp.fontBold, 20 )
	titleBar.titleText:setFillColor(0,0,0)
	titleBar.titleText.x = display.contentCenterX
	titleBar.titleText.y = bgTitle.height * 0.5 + 7

	titleBar.height = 72


	titleBar.indietro = widget.newButton({
	    id  = 'BtIndietro',
	    label = 'Indietro',
	    x = display.contentCenterX*0.3,
	    y = bgTitle.height * 0.5 + 7,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    scene = '', -- Scena in cui andare
	    optionsBack ={}, -- Parametri aggiuntivi da passare alla scena
	   	onRelease = titleBar.goBack
	})

	titleBar.createButton("accedi", "BtAccedi", "Accedi", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.accedi)

	titleBar.createButton("profilo", "BtProfilo", "Profilo", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.profilo)

	titleBar.createButton("annulla", "BtAnnulla", "Annulla", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.annulla)

	titleBar.createButton("ricerca", "BtRicerca", "Ricerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.ricerca)

	titleBar.createButton("cerca", "BtCerca", "Cerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.cerca)


	titleBar.chiudi = widget.newButton({
	    id  = 'BtChiudi',
	    label = 'Chiudi',
	    x = display.contentCenterX*1.75,
	    y = bgTitle.height * 0.5 + 7,
	    color = { 0.062745,0.50980,0.99607 },
	    fontSize = 18,
	    scene = '', -- Scena in cui andare
	    optionsBack ={}, -- Parametri aggiuntivi da passare alla scena
	   	onRelease = titleBar.goBack
	})

	titleBar.logo = display.newImage( 'img/logo.png', _W*0.1, _H*0.08 )
	titleBar.logo.width = 45
	titleBar.logo.height = 37

	titleBar.accedi.isVisible = true
	titleBar.profilo.isVisible = false
	titleBar.indietro.isVisible = false
	titleBar.chiudi.isVisible = false
	titleBar.logo.isVisible = false


	titleBar.annulla.isVisible = false
	titleBar.ricerca.isVisible = false
	titleBar.cerca.isVisible = false

	return titleBar

end

function titleBar.createButton(name, id, label, x, y, color, fontSize, onRelease)
	titleBar[name] = widget.newButton( {
		id = id,
		label = label,
	    x = x,
	    y = y,
	    color = color,
	    fontSize = fontSize,
	   	onRelease = onRelease
	} )
end

function titleBar.goBack()
	print("GOBACK ")
    storyboard.gotoScene(titleBar.indietro.scene, titleBar.indietro.optionsBack)
end

function titleBar.profilo()
	myApp.ultimaPagina = storyboard.getCurrentSceneName()
    storyboard.gotoScene("profilo", { effect = "slideUp", time = 500 } )
end

function titleBar.accedi()
	myApp.ultimaPagina = storyboard.getCurrentSceneName()
    storyboard.gotoScene("accedi", { effect = "slideUp", time = 500 } )
end

function titleBar.annulla()
    storyboard.gotoScene(myApp.titleBar.back)
end

function titleBar.ricerca()
      local options =
    {
        effect = "fromBottom",
        time = 400
    }

    storyboard.gotoScene( "ricerca", options )
end

function titleBar.cerca()
	storyboard.gotoScene( "transiti" )
end

return titleBar

