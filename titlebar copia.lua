--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 

myApp.titleBar = {}
myApp.titleBar.setTitleBar = {}


local optionsIndietro = {
	effects = { effect = "slideRight", time = 500 }, 
	func = {}
}

local optionsProfilo ={
	effects = {effect = "fromTop", time = 100},
	func = {}
}

local optionsAccedi ={
	effects = { effect = "fromTop", time = 100, params = {effect = "fromTop", time = 100}},
	func = {}
}

local optionsAnnulla ={
	func = {}
}

local optionsRicerca ={
	effects = { effect = "fromTop", time = 500},
	func = {}
}

local optionsCerca ={
	effects = { effect = "slideUp", time = 500},
	func = {}
}

local optionsModifica ={
	func = {}
}

local optionsFine ={
	func = {}
}



local function initButton(button)

	for k,v in pairs(button.default) do
		if next(v) ~= nil then
			-- Copia il default in valori singoli in button
			button[k] = {}
			for i, j in pairs(v) do
				button[k][i] = j
			end
		else
			button[k] = {}
		end
	end


end

function myApp.titleBar.transitionBack(options)

	local effect = options.effect
	local time = options.time


	if effect ~= nil then
		if     effect == "zoomOutIn" 			then effect = "zoomInOut"
	    elseif effect == "zoomOutInFade" 		then effect = "zoomInOutFade"
	    elseif effect == "flip"					then effect = "flipFadeOutIn"
	    elseif effect == "zoomOutInRotate"		then effect = "zoomInOutRotate"
	    elseif effect == "zoomOutInFadeRotate"	then effect = "zoomInOutFadeRotate"
	    elseif effect == "fromRight"			then effect = "slideLeft"
	    elseif effect == "fromLeft"				then effect = "slideRight"
	    elseif effect == "fromTop"				then effect = "slideUp"
	    elseif effect == "fromBottom"			then effect = "slideDown"
	    elseif effect == "fade"					then effect = "crossFade"
		end
	end

	return {effect = effect, time = time}

end


function myApp.titleBar.setTitleBar(title, buttons)

	-- Prototype { button =  { effect = effect, func = func }}
	-- Prototype { button =  on}
	-- Prototype { button =  off}

	myApp.titleBar.titleText.text = title

	for name, options in pairs(buttons) do
		local button = myApp.titleBar[name]
		initButton(button)
		-- Pulsante modalità default
		if options == true then
			button.isVisible = true
		-- Pulsante modalità spegnimento
		elseif options == false then
			button.isVisible = false
		else
			button.isVisible = true
			-- Pulsante overrided
			for attr, value in pairs(options) do
				if type(value) == "table" then
					for i, j in pairs(value) do
						button[attr][i] = j
					end
				else
					button[attr] = value
				end
			end
		end
	end
end

local function execFunc(button)
	if type(button.func) == "function" then
		button.func()
	end
end


local function createButton(name, id, label, x, y, color, fontSize, onRelease, options)

	myApp.titleBar[name] = widget.newButton( {
		id = id,
		label = label,
	    x = x,
	    y = y,
	    width = 90,
	    color = color,
	    fontSize = fontSize,
	   	onRelease = onRelease,
	} )

	-- Imposta i valori di default del button
	myApp.titleBar[name].default = options

	-- Inizializza il button ai valori di default
	initButton(myApp.titleBar[name])

end

local function indietro()
	execFunc(myApp.titleBar.indietro)
    storyboard.gotoScene(myApp.story.back(), myApp.titleBar.indietro.effects )
end

local function profilo()
    storyboard.gotoScene("profilo", myApp.titleBar.profilo.effects)
end

local function accedi()
    storyboard.gotoScene("accedi", myApp.titleBar.accedi.effects)
end

local function annulla()
	myApp.titleBar.annulla.isVisible = false
    myApp.titleBar.indietro.isVisible = false
    myApp.story.removeAll()
	myApp.showHome()
end

local function ricerca()
	storyboard.gotoScene( "profilo_ricerca", myApp.titleBar.ricerca.effects)
end

local function modifica()
	execFunc(myApp.titleBar.modifica)
end

local function fine()
	execFunc(myApp.titleBar.fine)
end

local function cerca()
	execFunc(myApp.titleBar.cerca)
	storyboard.gotoScene( "profilo_transiti", myApp.titleBar.cerca.effects)
end



function newTitleBar()

	print ("NEW TITLEBAR")
	local bgTitle = display.newImageRect(myApp.topBarBg, display.contentWidth, 72)
	bgTitle.x = display.contentCenterX
	bgTitle.y = display.topStatusBarContentHeight + 14
	myApp.topBarHeight = bgTitle.y*2

	myApp.titleBar.titleText = display.newText( '', 0, 0, myApp.fontBold, 20 )
	myApp.titleBar.titleText:setFillColor(0,0,0)
	myApp.titleBar.titleText.x = display.contentCenterX
	myApp.titleBar.titleText.y = bgTitle.height * 0.5 + 7

	myApp.titleBar.height = 72

	myApp.titleBar.logo = display.newImage( 'img/logo.png', _W*0.1, _H*0.08 )
	myApp.titleBar.logo.width = 45
	myApp.titleBar.logo.height = 37

	createButton("indietro", "BtIndietro", "❮ Indietro", 
		display.contentCenterX*0.3, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, indietro, optionsIndietro)

	createButton("accedi", "BtAccedi", "Accedi", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, accedi, optionsAccedi)

	createButton("profilo", "BtProfilo", "Profilo", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, profilo, optionsProfilo)

	createButton("annulla", "BtAnnulla", "Annulla", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, annulla, optionsAnnulla)

	createButton("ricerca", "BtRicerca", "Ricerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, ricerca, optionsRicerca)

	createButton("cerca", "BtCerca", "Cerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, cerca, optionsCerca)

	createButton("modifica", "BtModifica", "Modifica", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, modifica, optionsModifica)

	createButton("fine", "BtFine", "Fine", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, fine, optionsFine)

	myApp.titleBar.accedi.isVisible = true
	myApp.titleBar.profilo.isVisible = false
	myApp.titleBar.indietro.isVisible = false
	myApp.titleBar.logo.isVisible = false
	myApp.titleBar.annulla.isVisible = false
	myApp.titleBar.ricerca.isVisible = false
	myApp.titleBar.cerca.isVisible = false
	myApp.titleBar.modifica.isVisible = false
	myApp.titleBar.fine.isVisible = false

end
