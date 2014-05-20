local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')



-- funzioni
local AvantiScene = {}



-- variabili
local indietro
local utente
local avanti
local text1


function scene:createScene(event)
    local group = self.view

	local background = display.newRect(0,0,display.contentWidth, display.contentHeight)
	background:setFillColor(0.9, 0.9, 0.9)
    background.x = display.contentCenterX
    background.y = display.contentCenterY
	group:insert(background)


	-- testo in alto
    local options = {
        text = 'Controlla con attenzione i tuoi dati, non saranno facilmente modificabii:',
        x = _W*0.5,
        y = _H*0.425,
        width = _W - 30,
        height = 300,
        fontSize = 16,
        align = "center"
    }
    local areaT = display.newText( options )
    areaT:setFillColor( 0, 0, 0 )
    group:insert(areaT)




    local txt = {}
    txt[1] = 'Username:\n\t' ..myApp.datiUtente.username
    txt[2] = 'Nome:\n\t' ..myApp.datiUtente.nome
    txt[3] = 'Cognome:\n\t' ..myApp.datiUtente.cognome
    txt[4] = 'Email:\n\t' ..myApp.datiUtente.email
    txt[5] = 'Cellulare:\n\t' ..myApp.datiUtente.cellulare
    txt[6] = 'Targa principale:\n\t'..myApp.datiUtente.targa


    text1 = native.newTextField(_W*0.5,_H*0.5, _W-30, _H*0.5)
    text1.text = txt[1]..'\n'..txt[2]..'\n'..txt[3]..'\n'..txt[4]..'\n'..txt[5]..'\n'..txt[6]
    text1.align = 'left'
    text1.font = native.newFont( myApp.fontSize, 19 )
    text1.hasBackground = false
    text1:setTextColor(0)
    

    group:insert(text1)

    avanti = widget.newButton({
        id  = 'BtAvanti',
        label = 'Avanti',
        x = _W*0.5,
        y = _H*0.925,
        color = { 0.062745,0.50980,0.99607 },
        fontSize = 26,
        font = myApp.font,
        onRelease = AvantiScene
    })
    group:insert(avanti)



end


function AvantiScene()
  --       myApp.datiUtente = {
		-- 	username = myApp.datiUtente.username,
		-- 	password = myApp.datiUtente.password,
  --           nome = myApp.datiUtente.nome,
  --           cognome = myApp.datiUtente.cognome,
  --           email = myApp.datiUtente.email,
  --           cellulare = myApp.datiUtente.cellulare,
  --           targa = myApp.datiUtente.targa
		-- }
		-- storyboard.gotoScene('registrazione4')


        utente = myApp.datiUtente
    
        myApp.datiUtente = {
            username = '',
            password = '',
            nome = '',
            cognome = '',
            email = '',
            cellulare = '',
            targa = '',
        }
end



function scene:enterScene( event )
    print("ENTRA SCENA RIEPILOGO")
    
    -- Preparo titleBar

    myApp.titleBar.titleText.text = "Registrazione"
    myApp.titleBar.indietro.isVisible = true
    myApp.titleBar.indietro.scene = "registrazione3"
    myApp.tabBar.isVisible = false
    myApp.titleBar.accedi.isVisible = false

end

function scene:exitScene( event )
    print("ESCI SCENA RIEPILOGO")

end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA RIEPILOGO")
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
