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

		titleBar.accedi = widget.newButton({
		    id  = 'BtAccedi',
		    label = 'Accedi',
		    x = display.contentCenterX*1.75,
		    y = bgTitle.height * 0.5 + 7,
		    color = { 0.062745,0.50980,0.99607 },
		    fontSize = 18,
		    onRelease = titleBar.accedi
		})


		titleBar.profilo = widget.newButton({
		    id  = 'BtProfilo',
		    label = 'Profilo',
		    x = display.contentCenterX*1.75,
		    y = bgTitle.height * 0.5 + 7,
		    color = { 0.062745,0.50980,0.99607 },
		    fontSize = 18,
		    onRelease = titleBar.profilo
		})

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

		titleBar.chiudi = widget.newButton({
		    id  = 'BtChiudi',
		    label = 'Chiudi',
		    x = display.contentCenterX*0.3,
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

		return titleBar

	end

	function titleBar.goBack()
		print("GOBACK "..titleBar.indietro.scene)
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

	return titleBar

