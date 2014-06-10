
-- Dimensioni schermo
_H = display.contentHeight
_W = display.contentWidth

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
debugMode = true
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
myApp.topBarBg = "img/topBarBg7.png"


-- barra di stato traslucita
display.setStatusBar(display.DarkStatusBar)


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


_Background = {1,1,1}

-- Instanzio titleBar 
myApp.titleBar = titleBar.new()

-- Distrugge le scene all'uscita
storyboard.purgeOnSceneChange = true

-- Storyboard
myApp.story = {}
myApp.story.__scenes = {}

function myApp.story.add(scene)
    if scene ~= myApp.story.__scenes[#myApp.story.__scenes] then
        table.insert(myApp.story.__scenes, scene)
        for i=1, #myApp.story.__scenes do
            print(myApp.story.__scenes[i])
        end
    end
end

function myApp.story.back()
    if #myApp.story.__scenes > 1 then
        table.remove(myApp.story.__scenes, #myApp.story.__scenes)
        for i=1, #myApp.story.__scenes do
            print("STORIA: "..i.." "..myApp.story.__scenes[i])
        end
        return myApp.story.__scenes[#myApp.story.__scenes]
    else
        return myApp.story.__scenes[#myApp.story.__scenes]
    end
end

function myApp.story.removeAll()
    myApp.story.__scenes = {}
end

myApp.showHome()
