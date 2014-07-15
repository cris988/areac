--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--


local storyboard = require ('storyboard')
local scene = storyboard.newScene()
local widget = require('widget')
local myApp = require('myapp')

widget.setTheme(myApp.theme)


-- funzioni
local searchFocus
local annullaButton
local setMyPosition
local addVarco
local mapLocationHandler

-- variabili
local background = {1,1,1}
local myMap
local BtAnnulla
local BtMyPos
local groupTxtSearch
local txtSearch
local keyboardFocus = false
local myAddress
local mappa
local titleText
local locationtxt

local posizioneVarchi = {}
posizioneVarchi[1] = { lat = 45.470762350021, long = 9.2052590724373, title = 'Varco Via Vitali' }
posizioneVarchi[2] = { lat = 45.469467668438, long = 9.2053844760239, title = 'Varco Via Rossini' }
posizioneVarchi[3] = { lat = 45.467770823233, long = 9.2055853486945, title = 'Varco Corso Monforte' }
posizioneVarchi[4] = { lat = 45.466502336402, long = 9.2057016477456, title = 'Varco Via Mascagni' }
posizioneVarchi[5] = { lat = 45.462294355671, long = 9.2064345362194, title = 'Varco Corso di Porta Vittoria' }
posizioneVarchi[6] = { lat = 45.460053887405, long = 9.206299538093, title = 'Varco Via Besana' }
posizioneVarchi[7] = { lat = 45.454963182311, long = 9.202945170458, title = 'Varco Via Curtatone' }
posizioneVarchi[8] = { lat = 45.454963182311, long = 9.202945170458, title = 'Varco Via Madre Cabrini'}
posizioneVarchi[9] = { lat = 45.452164142047, long = 9.1987728251439, title = 'Varco Via Bianca di Savoia' }
posizioneVarchi[10] = { lat = 45.452100468425, long = 9.190991426604, title = 'Varco Via Melegnano' }
posizioneVarchi[11] = { lat = 45.452595577819, long = 9.1844772246887, title = 'Varco Via Aurispa' }
posizioneVarchi[12] = { lat = 45.45300514369, long = 9.1784431957937, title = 'Varco Via Panzeri' }
posizioneVarchi[13] = { lat = 45.454163977524, long = 9.1760072040726, title = 'Varco Via Ronzoni' }
posizioneVarchi[14] = { lat = 45.455885890942, long = 9.1735764649915, title = 'Varco Corso Genova' }
posizioneVarchi[15] = { lat = 45.457465766008, long = 9.1710738204626, title = 'Varco Via Ausonio' }
posizioneVarchi[16] = { lat = 45.458414292469, long = 9.1696888929621, title = 'Varco Piazza Sant\'Agostino' }
posizioneVarchi[17] = { lat = 45.459161300118, long = 9.1683519183047, title = 'Varco Via Servio Tullio' }
posizioneVarchi[18] = { lat = 45.462760682413, long = 9.1649587966396, title = 'Varco Via Bandello' }
posizioneVarchi[19] = { lat = 45.464781923554, long = 9.1655922102716, title = 'Varco Via San Vittore' }
posizioneVarchi[20] = { lat = 45.467486607165, long = 9.1667431765796, title = 'Varco Via Boccaccio' }
posizioneVarchi[21] = { lat = 45.467729305936, long = 9.1667569415324, title = 'Varco Via 20 Settembre' }
posizioneVarchi[22] = { lat = 45.467808575017, long = 9.1664036001621, title = 'Varco Via Bazzoni' }
posizioneVarchi[23] = { lat = 45.46961802861, long = 9.1658946362098, title = 'Varco Via Mascheroni' }
posizioneVarchi[24] = { lat = 45.470996341241, long = 9.1690864918395, title = 'Varcov Via Monti' }
posizioneVarchi[25] = { lat = 45.474006604365, long = 9.1698436170708, title = 'Varcov Viale Milton' }
posizioneVarchi[26] = { lat = 45.477476327452, long = 9.180947, title = 'Varco Via Legnano' }
posizioneVarchi[27] = { lat = 45.477606546647, long = 9.181296, title = 'Varco Via di Porta Tenaglia' }
posizioneVarchi[28] = { lat = 45.478302456892, long = 9.181657, title = 'Varco Via Moscova' }
posizioneVarchi[29] = { lat = 45.480894867198, long = 9.182773, title = 'Varco Via Volta' }
posizioneVarchi[30] = { lat = 45.480344433861, long = 9.186689, title = 'Varco Corso Garibaldi' }
posizioneVarchi[31] = { lat = 45.480064776045, long = 9.187966, title = 'Varco Via Milazzo' }
posizioneVarchi[32] = { lat = 45.479783888516, long = 9.1917439986987, title = 'Varco Via Castelfidardo' }
posizioneVarchi[33] = { lat = 45.477933113034, long = 9.1965981440337, title = 'Varco Via Turati' }
posizioneVarchi[34] = { lat = 45.474208935545, long = 9.204687, title = 'Varco Corso Venezia' }
posizioneVarchi[35] = { lat = 45.471642286247, long = 9.205188, title = 'Varco Via Baretti' }



function addVarco( id )
    local options = { 
        title=posizioneVarchi[id].title, 
        -- subtitle= , 
        imageFile = {
            filename = 'img/greenPin.png',
            -- baseDir = system.ResourcesDirectory
        },
        -- listener=markerListener 
    }
    result, errorMessage = myMap:addMarker(posizioneVarchi[id].lat, posizioneVarchi[id].long, options)
    if result then
        print("everything went well")
    else
        print(errorMessage)
    end
end





function lostFocus()
    -- Disabilita il pulsante annulla e mostra quello della posizione
    keyboardFocus = false
    native.setKeyboardFocus( nil )
    BtAnnulla.alpha = 0
    BtMyPos.alpha = 1
    transition.scaleTo(txtSearch, {xScale = 1})
end

function searchFocus()
    -- Abilita il pulsante annulla e nasconde quello della posizione
    if not(keyboardFocus) then
        BtMyPos.alpha = 0
        BtAnnulla.alpha = 1
        transition.scaleTo(txtSearch, {xScale = 0.90})
        keyboardFocus = true
    end
end

function setMyPosition()

    --Fetch the user's current location
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

        print("map position latitude: ", currentLatitude)
        print("map position longitude: ", currentLongitude)
        myMap:setRegion( currentLatitude, currentLongitude, 0.01, 0.01, true )
    end

end 

local function mapLocationHandler( event )
    -- handle mapLocation event here
    if event.isError then
        print( "Error: " .. event.errorMessage )
    else
        -- Imposta la mappa sullla posizione e aggiunge un marker
        --myMap:setCenter( event.latitude, event.longitude)
        myMap:setRegion( event.latitude, event.longitude, 0.01, 0.01, true )
        if myAddress ~= nil then
            myMap:removeMarker(myAddress)
        end
        myAddress = myMap:addMarker( event.latitude, event.longitude )
        print( "The specified string is at: " .. event.latitude .. ", " .. event.longitude )
    end
end

function mapLocation()
    -- Ricerca la posizione selezionata
    myMap:requestLocation( txtSearch.campo.text .. ", Milano, MI, Italy", mapLocationHandler )
    lostFocus()
end











function scene:createScene(event)

    print("CREA SCENA MAPPA")

    local group = self.view

    -- Preparo titleBar

    myApp.titleBar.setTitleBar("mappa", "Mappa", { 
        indietro = false,
        accedi =  library.checkLogIn("accedi"),
        profilo = library.checkLogIn("profilo"),
        logo = true
    })

    -- Background

    library.setBackground(group, _Background )


    -- Group di ricerca
    local groupSearch = display.newGroup( )
    groupSearch.y = myApp.titleBar.height - 1
    if system.getInfo("model") ~= "iPhone" and system.getInfo("model") ~= 'iPhone Simulator' then
        groupSearch.y = myApp.titleBar.height + 4
    end

    local bgSearch = display.newRect( group, 0, 0, _W, 48)
    bgSearch:setFillColor( 0.95,0.95,0.95  )
    bgSearch.anchorX = 0
    bgSearch.anchorY = 0

    BtAnnulla = widget.newButton( {
        id = 'BtAnnulla',
        label = 'Annulla',
        x = _W * 0.9,
        y =  bgSearch.height / 2,
        color = color,
        fontSize = 17,
        onRelease = lostFocus,
    } )
    BtAnnulla.alpha = 0

    BtMyPos = widget.newButton({
        defaultFile = "img/position.png",
        x =  _W * 0.93,
        y = bgSearch.height / 2,
        width = 25,
        height = 25,
        onRelease = setMyPosition
    } )


    -- Casella di testo per ricerca via

    txtSearch = library.textArea(group, _W*0.45, bgSearch.height / 2, 190, 28, {0,0,0}, native.newFont( myApp.font, 17 ), "center", "Inserisci la via", nil, searchFocus, nil, mapLocation)


    local imgLente = display.newImage( group, "img/lente.png", _W * 0.09, bgSearch.height / 2)
    imgLente.width = 25
    imgLente.height = 25

    groupSearch:insert(bgSearch)
    groupSearch:insert(BtMyPos)
    groupSearch:insert(BtAnnulla)
    groupSearch:insert(txtSearch)
    groupSearch:insert(imgLente)

    group:insert(groupSearch)


    mappa = display.newRect( group, 0, groupSearch.y + groupSearch.height - 2, _W, _H - myApp.tabBar.height - (groupSearch.y + groupSearch.height) + 1)
    mappa:setFillColor( 0.5, 0.5, 0.5 )
    mappa.anchorX=0
    mappa.anchorY=0
    if system.getInfo("model") ~= "iPhone" and system.getInfo("model") ~= 'iPhone Simulator' then
        mappa.y = mappa.y - 6
        mappa.height = mappa.height + 7
    end

    local simulatorMessage = "Maps not supported in Corona Simulator.\nYou must build for iOS or Android to test native.newMapView() support."
    local myText = display.newText( simulatorMessage, _W*0.5, _H*0.5, 300, 100, myApp.font, 20 )
    group:insert(myText)
    
end






function scene:enterScene( event ) 
    print("ENTRA SCENA MAPPA")
    myApp.story.removeAll()
    myApp.story.add(storyboard.getCurrentSceneName())


    local group = self.view

    myMap = native.newMapView( 0, 0, _W , mappa.height )
    myMap.mapType = 'standard'

    myMap.x = display.contentCenterX
    myMap.y = mappa.y + mappa.height*0.5

    for i = 1, #posizioneVarchi do
        addVarco(i)
    end


    myMap:setCenter( 45.464996, 9.186785, true )
    myMap:setRegion( 45.464996, 9.186785, 0.04, 0.04, true)

    myMap.isLocationVisible = true
    myMap.isZoomEnabled = true

    group:insert(myMap)

end

function scene:exitScene( event ) 
    print("ESCI SCENA MAPPA") 
    myApp.titleBar.logo.isVisible = false
end

function scene:destroyScene( event )
    print("DISTRUGGI SCENA MAPPA") 
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene
