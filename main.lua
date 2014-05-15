-- barra di stato traslucita
display.setStatusBar( display.TranslucentStatusBar )


--
-- load in storyboard
--
local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 



--
-- turn on debugging
--
local debugMode = true


--
-- this little snippet will make a copy of the print function
-- and now will only print if debugMode is true
-- quick way to clean up your logging for production
--

reallyPrint = print
function print(...)
    if debugMode then
        reallyPrint(unpack(arg))
    end
end

math.randomseed(os.time())








--
-- Load our fonts and define our styles
--

local tabBarBackgroundFile = "img/tabBarBg7.png"
local tabBarLeft = "img/tabBar_tabSelectedLeft7.png"
local tabBarMiddle = "img/tabBar_tabSelectedMiddle7.png"
local tabBarRight = "img/tabBar_tabSelectedRight7.png"

myApp.topBarBg = "img/topBarBg7.png"



local iconInfo = {
    width = 40,
    height = 40,
    numFrames = 20,
    sheetContentWidth = 200,
    sheetContentHeight = 160
}

myApp.icons = graphics.newImageSheet("images/ios7icons.png", iconInfo)

--widget.setTheme( "widget_theme_android" )
myApp.theme = 'widget_theme_ios7'
--local coronaBuild = system.getInfo('builld')
--if tonumber(coronaBuild:sub(6,12)) < 1206 then
--    myApp.theme = "widget_theme_ios"
--end
myApp.font = "HelveticaNeue-Light"
myApp.fontBold = "HelveticaNeue"
myApp.fontItalic = "HelveticaNeue-LightItalic"
myApp.fontBoldItalic = "Helvetica-BoldItalic"


widget.setTheme(myApp.theme)





-- variabili globali
titleBarHeight = 50
_H = display.contentHeight
_W = display.contentWidth



















-- local function handleLeftButton( event )
--    if ( event.phase == "ended" ) then
--       -- do stuff
--    end
--    return true
-- end
-- local function handleRightButton( event )
--    if ( event.phase == "ended" ) then
--       -- do stuff
--    end
--    return true
-- end



-- local leftButton = {
--     onEvent = handleLeftButton,
--     label = "Left",
--     labelColor = { default =  {1, 1, 1}, over = { 0.5, 0.5, 0.5} },
--     font = "HelveticaNeue-Light",
--     isBackButton = true
-- }
-- local rightButton = {
--    onEvent = handleRightButton,
--    label = "Right",
--    labelColor = { default =  {1, 1, 1}, over = { 0.5, 0.5, 0.5} },
--    font = "HelveticaNeue-Light",
--    isBackButton = false
-- }


-- local navBar = widget.newNavigationBar(options)
-- options = {
--    title = "Barra",
--    backgroundColor = { 0.96, 0.62, 0.34 },
--     --background = "images/topBarBgTest.png",
--    titleColor = {1, 1, 1},
--    font = "HelveticaNeue",
--    leftButton = leftButton,
--    rightButton = rightButton,
--    includeStatusBar = true
-- }
























-- instanzio tabBar
myApp.tabBar = {}



-- creo funzioni per la tabBar

function myApp.showScreen1()
    myApp.tabBar:setSelected(1)
    storyboard.removeAll()
    -- storyboard.gotoScene("mappa", {time=250, effect="crossFade"})
    storyboard.gotoScene("mappa")
    return true
end

function myApp.showScreen2()
    myApp.tabBar:setSelected(2)
    storyboard.removeAll()
    -- storyboard.gotoScene("verificatarga", {time=250, effect="crossFade"})
    storyboard.gotoScene("verificatarga")
    return true
end

function myApp.showScreen3()
    myApp.tabBar:setSelected(3)
    storyboard.removeAll()
    -- storyboard.gotoScene("acquista", {time=250, effect="crossFade"})
    storyboard.gotoScene("acquista")
    return true
end

function myApp.showScreen4() 
    myApp.tabBar:setSelected(4)
    storyboard.removeAll()
    -- storyboard.gotoScene("informazioni", {time=250, effect="crossFade"})
    storyboard.gotoScene("informazioni")
    return true
end






-- creo pulsanti per la tabBar

local tabButtons = {
    {
        label = "Mappa",
        defaultFile = "img/mappa_off.png",
        overFile = "img/mappa_on.png",
        labelColor = {
            default = { 0.6,0.6,0.6 },  
            over = { 0.062745,0.50980,0.99607 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen1,
        selected = true
    },
    {
        label = "Verifica targa",
        defaultFile = "img/verifica_off.png",
        overFile = "img/verifica_on.png",
        labelColor = { 
            default = { 0.6,0.6,0.6 }, 
            over = { 0.062745,0.50980,0.99607 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen2,
    },
    {
        label = "Acquista",
        defaultFile = "img/acquista_off.png",
        overFile = "img/acquista_on.png",
        labelColor = { 
            default = { 0.6,0.6,0.6 },  
            over = { 0.062745,0.50980,0.99607 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen3,
    },
    {
        label = "Informazioni",
        defaultFile = "img/info_off.png",
        overFile = "img/info_on.png",
        labelColor = { 
            default = { 0.6,0.6,0.6 }, 
            over = { 0.062745,0.50980,0.99607 }
        },
        width = 32,
        height = 32,
        onPress = myApp.showScreen4,
    }
}







-- creo la tabBar

myApp.tabBar = widget.newTabBar{
    top =  display.contentHeight - 50,
    left = 0,
    width = display.contentWidth,
    backgroundFile = tabBarBackgroundFile,
    tabSelectedLeftFile = tabBarLeft,      -- New
    tabSelectedRightFile = tabBarRight,    -- New
    tabSelectedMiddleFile = tabBarMiddle,      -- New
    tabSelectedFrameWidth = 20,                                         -- New
    tabSelectedFrameHeight = 50,                                        -- New    
    height = 50,                                      -- New    
    top = display.contentHeight - 50,
    buttons = tabButtons
}








-- local background  = display.newRect(0, 0, display.contentWidth, display.contentHeight)
-- background:setFillColor(0.9,0.9,0.9)
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY













local function closeSplash()

    myApp.showScreen1()
end



timer.performWithDelay(1, closeSplash)































