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

	titleBar.logo = display.newImage( 'img/logo.png', _W*0.1, _H*0.08 )
	titleBar.logo.width = 45
	titleBar.logo.height = 37

	optionsIndietro = {
	    effect ={ effect = "slideRight", time = 500 },
	    func = {} -- Funzione da eseguire al pulsante
	}

	optionsProfilo ={
		effect = { effect = "fromBottom", time = 500 }
	}

	optionsAccedi ={
		effect = { effect = "fromBottom", time = 500 }
	}

	optionsAnnulla ={
	}

	optionsRicerca ={
		effect = { effect = "fromBottom", time = 500 }
	}

	optionsCerca ={
		effect = { effect = "fromTop", time = 500 }
	}


	titleBar.createButton("indietro", "BtIndietro", "< Indietro", 
		display.contentCenterX*0.3, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.goBack, optionsIndietro)

	titleBar.createButton("accedi", "BtAccedi", "Accedi", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.accedi, optionsAccedi)

	titleBar.createButton("profilo", "BtProfilo", "Profilo", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.profilo, optionsProfilo)

	titleBar.createButton("annulla", "BtAnnulla", "Annulla", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.annulla, optionsAnnulla)

	titleBar.createButton("ricerca", "BtRicerca", "Ricerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.ricerca, optionsRicerca)

	titleBar.createButton("cerca", "BtCerca", "Cerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, titleBar.cerca, optionCerca)

	titleBar.accedi.isVisible = true
	titleBar.profilo.isVisible = false
	titleBar.indietro.isVisible = false
	titleBar.logo.isVisible = false
	titleBar.annulla.isVisible = false
	titleBar.ricerca.isVisible = false
	titleBar.cerca.isVisible = false

	return titleBar

end

function titleBar.createButton(name, id, label, x, y, color, fontSize, onRelease, options)
	titleBar[name] = widget.newButton( {
		id = id,
		label = label,
	    x = x,
	    y = y,
	    color = color,
	    fontSize = fontSize,
	   	onRelease = onRelease,
	} )

	if options ~= nil then
	   	for k,v in pairs(options) do
	   		titleBar[name][k] = v
	   	end
	end
end

function titleBar.goBack()
	print("GOBACK ")
	-- Eseguo eventuale funzione passata
	if type(titleBar.indietro.func) == "function" then
		titleBar.indietro.func()
	end
    storyboard.gotoScene(myApp.story.back(),  titleBar.indietro.effect)
end

function titleBar.profilo()
    storyboard.gotoScene("profilo",  titleBar.profilo.effect)
end

function titleBar.accedi()
    storyboard.gotoScene("accedi", titleBar.accedi.effect)
end

function titleBar.annulla()
	myApp.showHome()
end

function titleBar.ricerca()
    storyboard.gotoScene( "ricerca", titleBar.accedi.effect)
end

function titleBar.cerca()
	storyboard.gotoScene( "transiti", titleBar.cerca.effect)
end

return titleBar

