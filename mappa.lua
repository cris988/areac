local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local views = {}
local accediProfilo = {}


-- variabili
local accedi
local titleBar
local titleText
local locationtxt

local function ignoreTouch( event )
	return true
end


function scene:createScene(event)

    print("CREA SCENA MAPPA")

	local group = self.view

    -- if ( system.getInfo( "environment" ) == "simulator" ) then
    --     local simulatorMessage = "Maps not supported in Corona Simulator.\nYou must build for iOS or Android to test native.newMapView() support."
    --     local allertMap = display.newText( simulatorMessage, _W*0.1, _H*0.40, _W*0.85, _H*0.4, native.systemFont, 16 )
    --     allertMap:setFillColor( 1, 0, 0 )
    --     allertMap.anchorX = 0
    --     allertMap.anchorY = 0
    -- end
    -- group:insert(allertMap)



    local contornoMappa = display.newRect( group, 0, myApp.titleBar.height -1, _W, _H - myApp.titleBar.height - myApp.tabBar.height)
    contornoMappa:setFillColor( 0.5, 0.5, 0.5 )
    contornoMappa.anchorX=0
    contornoMappa.anchorY=0

    if ( system.getInfo( "environment" ) == "simulator" ) then

        local simulatorMessage = "Maps not supported in Corona Simulator.\nYou must build for iOS or Android to test native.newMapView() support."
        local myText = display.newText( simulatorMessage, _W*0.5, _H*0.5, 300, 100, myApp.font, 20 )
        group:insert(myText)
    end

    myMap = native.newMapView( display.contentCenterX, (_H - myApp.titleBar.height - myApp.tabBar.height) /2 + myApp.titleBar.height -1, _W, _H - myApp.titleBar.height - myApp.tabBar.height)

    if ( myMap ) then
        -- Display a normal map with vector drawings of the streets.
        -- Other mapType options are "satellite" and "hybrid".
        myMap.mapType = "normal"

        -- Initialize map to a real location, since default location (0,0) is not very interesting
        myMap:setCenter( 45.4640135,9.190618 )


        -- -- Fetch the user's current location
        local currentLocation = myMap:getUserLocation()
        if currentLocation.errorCode then
            -- Current location is unknown if the "errorCode" property is not nil.
            currentLatitude = 0
            currentLongitude = 0
            native.showAlert( "Error", currentLocation.errorMessage, { "OK" } )
        else

            -- Current location data was received.
            -- Move map so that current location is at the center.
            currentLatitude = currentLocation.latitude
            currentLongitude = currentLocation.longitude
            --myMap:setRegion( currentLatitude, currentLongitude, 0.01, 0.01, true )
        end


        -- This is returned as a mapLocation event
        local function mapLocationListener(event)
            print("map tapped latitude: ", event.latitude)
            print("map tapped longitude: ", event.longitude)
        end
        myMap:addEventListener("mapLocation", mapLocationListener)


    end



    local image = {
        filename = 'img/greenPin.png'
    }
    
    myMap:addMarker( 45.470762350021, 9.2052590724373,
        { title = 'Varco Via Vitali',   imageFile = image })
    myMap:addMarker( 45.469467668438, 9.2053844760239,
        { title = 'Varco Via Rossini',  imageFile = image })
    myMap:addMarker( 45.467770823233, 9.2055853486945,
        { title = 'Varco Corso Monforte',  imageFile = image })
    myMap:addMarker( 45.466502336402, 9.2057016477456,
        { title = 'Varco Via Mascagni',  imageFile = image })
    myMap:addMarker( 45.462294355671, 9.2064345362194,
        { title = 'Varco Corso di Porta Vittoria',  imageFile = image })
    myMap:addMarker( 45.460053887405, 9.206299538093,
        { title = 'Varco Via Besana',  imageFile = image })
    myMap:addMarker( 45.454963182311, 9.202945170458,
        { title = 'Varco Via Curtatone',  imageFile = image })
    myMap:addMarker( 45.452164142047, 9.1987728251439,
        { title = 'Varco Via Madre Cabrini',  imageFile = image })
    myMap:addMarker( 45.452100468425, 9.190991426604,
        { title = 'Varco Via Bianca di Savoia',  imageFile = image })
    myMap:addMarker( 45.452186458216, 9.1886302014116,
        { title = 'Varco Via Melegnano',  imageFile = image })
    myMap:addMarker( 45.452595577819, 9.1844772246887,
        { title = 'Varco Via Aurispa',  imageFile = image })
    myMap:addMarker( 45.45300514369, 9.1784431957937,
        { title = 'Varco Via Panzeri',  imageFile = image })
    myMap:addMarker( 45.454163977524, 9.1760072040726,
        { title = 'Varco Via Ronzoni',  imageFile = image })
    myMap:addMarker( 45.455885890942, 9.1735764649915,
        { title = 'Varco Corso Genova',  imageFile = image })
    myMap:addMarker( 45.457465766008, 9.1710738204626,
        { title = 'Varco Via Ausonio',  imageFile = image })
    myMap:addMarker( 45.458414292469, 9.1696888929621,
        { title = 'Varco Piazza Sant\'Agostino',  imageFile = image })
    myMap:addMarker( 45.459161300118, 9.1683519183047,
        { title = 'Varco Via Servio Tullio',  imageFile = image })
    myMap:addMarker( 45.462760682413, 9.1649587966396,
        { title = 'Varco Via Bandello',  imageFile = image })
    myMap:addMarker( 45.464781923554, 9.1655922102716,
        { title = 'Varco Via San Vittore',  imageFile = image })
    myMap:addMarker( 45.467486607165, 9.1667431765796,
        { title = 'Varco Via Boccaccio',  imageFile = image })
    myMap:addMarker( 45.467729305936, 9.1667569415324,
        { title = 'Varco Via 20 Settembre',  imageFile = image })
    myMap:addMarker( 45.467808575017, 9.1664036001621,
        { title = 'Varco Via Bazzoni',  imageFile = image })
    myMap:addMarker( 45.46961802861, 9.1658946362098,
        { title = 'Varco Via Mascheroni',  imageFile = image })
    myMap:addMarker( 45.470996341241, 9.1690864918395,
        { title = 'Varcov Via Monti' , imageFile = image })
    myMap:addMarker( 45.474006604365, 9.1698436170708,
        { title = 'Varcov Viale Milton' , imageFile = image })
    myMap:addMarker( 45.477476327452, 9.180947,
        { title = 'Varco Via Legnano', imageFile = image })
    myMap:addMarker( 45.477606546647, 9.181296,
        { title = 'Varco Via di Porta Tenaglia', imageFile = image })
    myMap:addMarker( 45.478302456892, 9.181657,
        { title = 'Varco Via Moscova', imageFile = image })
    myMap:addMarker( 45.480894867198, 9.182773,
        { title = 'Varco Via Volta', imageFile = image })
    myMap:addMarker( 45.480344433861, 9.186689,
        { title = 'Varco Corso Garibaldi', imageFile = image })
    myMap:addMarker( 45.480064776045, 9.187966,
        { title = 'Varco Via Milazzo', imageFile = image })
    myMap:addMarker( 45.479783888516, 9.1917439986987,
        { title = 'Varco Via Castelfidardo', imageFile = image })  
    myMap:addMarker( 45.477933113034, 9.1965981440337,
        { title = 'Varco Via Turati', imageFile = image })
    myMap:addMarker( 45.474208935545, 9.204687,
        { title = 'Varco Corso Venezia', imageFile = image })
    myMap:addMarker( 45.471642286247, 9.205188,
        { title = 'Varco Via Baretti', imageFile = image })

    myMap.isLocationVisible = true
    myMap.isZoomEnabled = true
    group:insert(myMap)
end


function scene:enterScene( event )
    print("ENTRA SCENA MAPPA")

    -- Preparo titleBar
    myApp.titleBar.titleText.text = "Mappa"
    myApp.titleBar.indietro.isVisible = false
    myApp.titleBar.logo.isVisible = true
    if myApp.utenteLoggato == 0 then
        myApp.titleBar.accedi.isVisible = true
    else
        myApp.titleBar.profilo.isVisible = true
    end
    myApp.tabBar.isVisible = true
end

function scene:exitScene( event )
    print("ESCI SCENA MAPPA")
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA MAPPA")
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
