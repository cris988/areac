local storyboard = require ('storyboard')
local widget = require('widget')
local myApp = require('myapp')
local library = require('library')

widget.setTheme(myApp.theme)

local scene = storyboard.newScene()


-- titolo dei menù delle informazioni
local strings = {}
strings[1] = 'Cos\'è l\'area C'
strings[2] = 'Varchi e orari'
strings[3] = 'Veicoli autorizzati all\'acceso'
strings[4] = 'Titoli di ingresso'
strings[5] = 'Modalità di pagamento'
-- strings[6] = 'Come cambiare targa'
-- strings[7] = 'Come modificare i dati personali'


-- funzioni
local onRowTouch = {}

-- variabili
local locationtxt
local lineA

local function ignoreTouch( event )
	return true
end

function scene:createScene(event)

    print("CREA SCENA INFORMAZIONI")
    
	local group = self.view

    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Informazioni"
    myApp.titleBar.logo.isVisible = true
    
    library.checkLogIn()
    
    myApp.tabBar.isVisible = true

    -- Background

    library.setBackground(group, {1, 1, 1})

    group:insert(library.makeList("info", strings, 0, 69, _W, 50 * #strings, 50, true,nil, onRowTouch))

end


-- gestisce le azioni dell'utente sulle righe della lista
function onRowTouch( event )
    local row = event.target
    if event.phase == "release" or event.phase == 'tap' then
        storyboard.gotoScene('info_details', { effect = "slideLeft", time = 500, params = { var = event.target.index } })
    end
                
end


function scene:enterScene( event )
    print("ENTRA SCENA INFORMAZIONI")
    myApp.story.removeAll()
    myApp.story.add(storyboard.getCurrentSceneName())
end

function scene:exitScene( event )
    print("ESCI SCENA INFORMAZIONI")
    myApp.titleBar.logo.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA INFORMAZIONI")
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
