
--
-- load in storyboard
--
local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 
local titleBar = require("titlebar")
local library = require("library")
local tabBar = require("tabbar")
local utenti = require("utenti")

print ("MAIN")

-- barra di stato traslucita
display.setStatusBar( display.TranslucentStatusBar )


--
-- Handle Graphics 2.0 changes
myApp.colorDivisor = 255
myApp.isGraphics2 = true
if tonumber( system.getInfo("build") ) < 2013.2000 then
    -- we are a Graphics 1.0 build
    myApp.colorDivisor = 1
    myApp.isGraphics2 = false
end

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

myApp.icons = graphics.newImageSheet("img/ios7icons.png", iconInfo)

myApp.theme = 'widget_theme_ios7'
myApp.font = "HelveticaNeue-Light"
myApp.fontBold = "HelveticaNeue"
myApp.fontItalic = "HelveticaNeue-LightItalic"
myApp.fontBoldItalic = "Helvetica-BoldItalic"

widget.setTheme(myApp.theme)

-- Dimensioni schermo
_H = display.contentHeight
_W = display.contentWidth

-- Instanzio titleBar 
myApp.titleBar = titleBar.new()

-- Distrugge le scene all'uscita
storyboard.purgeOnSceneChange = true

-- Storyboard
myApp.story = {}
myApp.story.index = 0

function myApp.story.add(scene)
    table.insert(myApp.story, scene)
end

function myApp.story.back()
    if myApp.story.index > 1 then
        myApp.story[myApp.story.index] = nil
        myApp.story.index = myApp.story.index - 1
        return myApp.story[myApp.story.index]
    else
        return myApp.story[myApp.story.index]
    end
end




function myApp.story.removeAll()
    myApp.story = {}
end


-- Attesa splash screen

timer.performWithDelay(1500, myApp.showHome())

