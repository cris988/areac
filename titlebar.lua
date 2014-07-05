--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 

myApp.titleBar = {}
myApp.titleBar.setTitleBar = {}


local transitionScene = {
	accedi = { effect = "fromTop", time = 100 },
	indietro = { effect = "slideRight", time = 500 }, 
	profilo = {effect = "fromTop", time = 100 },
	ricerca = { effect = "fromTop", time = 500 },
	cerca = { effect = "slideUp", time = 500 }
}

local function transitionBack(options)

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


function myApp.titleBar.setTitleBar(nameScene, title, params)

	-- Prototype { button =  { effect = effect, func = func }}
	-- Prototype { button =  on}
	-- Prototype { button =  off}

	myApp.titleBar.titleText.text = title

	for name, param in pairs(params) do
		local button = myApp.titleBar[name]
		-- Pulsante modalità default
		if param == true then
			button.isVisible = true
		-- Pulsante modalità spegnimento
		else
			button.isVisible = false
		end
	end

	if transitionScene[nameScene] ~= nil then
		myApp.titleBar.indietro.effects = transitionBack(transitionScene[nameScene])
	else
		myApp.titleBar.indietro.effects = transitionScene["indietro"]
	end

end



local function execFunc(button)
	if type(button.func) == "function" then
		button.func()
	end
end


local function indietro()
	execFunc(myApp.titleBar.indietro)
    storyboard.gotoScene(myApp.story.back(), myApp.titleBar.indietro.effects )
end

local function profilo()
    storyboard.gotoScene("profilo", myApp.titleBar.profilo.effects)
end

local function accedi()
    storyboard.gotoScene("accedi", myApp.titleBar.accedi.effects )
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


local function createButton(name, id, label, x, y, color, fontSize, onRelease)

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

	-- Inizializzo funzione anonima
	myApp.titleBar[name].func = {}
	myApp.titleBar[name].effects = transitionScene[name]

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
		display.contentCenterX*0.3, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, indietro)

	createButton("accedi", "BtAccedi", "Accedi", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, accedi)

	createButton("profilo", "BtProfilo", "Profilo", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, profilo)

	createButton("annulla", "BtAnnulla", "Annulla", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, annulla)

	createButton("ricerca", "BtRicerca", "Filtra", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, ricerca)

	createButton("cerca", "BtCerca", "Cerca", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, cerca)

	createButton("modifica", "BtModifica", "Modifica", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, modifica)

	createButton("fine", "BtFine", "Fine", 
		display.contentCenterX*1.75, bgTitle.height * 0.5 + 7, { 0.062745,0.50980,0.99607 }, 18, fine)

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
