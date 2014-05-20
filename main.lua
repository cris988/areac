
--
-- load in storyboard
--
local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 
local titleBar = require("titlebar")

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

-- Dimensioni schermo
_H = display.contentHeight
_W = display.contentWidth

titleBarHeight = 50

-- Instanzio titleBar 
myApp.titleBar = titleBar.new()


-- Distrugge le scene all'uscita
storyboard.purgeOnSceneChange = true

-- Database Utenti


require "sqlite3"
local data_path=system.pathForFile("data.db",system.DocumentsDirectory);
db = sqlite3.open(data_path);

local sql = "CREATE TABLE IF NOT EXISTS settings (name,value);"
db:exec(sql);



function setSetting(name,value)   
    sql="DELETE FROM settings WHERE name='"..name.."'";
    db:exec( sql )
    
    sql="INSERT INTO settings (name,value) VALUES ('"..name.."',"..value..");";
    db:exec( sql )    
end

function setSettingString(name,value)
    setSetting(name,"'"..value.."'");
end




function getSetting(name)

    local sql="SELECT * FROM settings WHERE name='"..name.."'";
    local value=-1;

    for row in db:nrows(sql) do
        value=row.value;
    end    

    return value;
end

function getSettingString(name)
    local sql="SELECT * FROM settings WHERE name='"..name.."'";
    local value='';

    for row in db:nrows(sql) do
        value=row.value;
    end    

    return value;
end





myApp.utenti = {}
myApp.utenti['admin'] = { password = 'admin' }




function myApp:getNumUtenti()
    print(#myApp.utenti)
    return #myApp.utenti
end


require "sqlite3"
local data_path=system.pathForFile("data.db",system.DocumentsDirectory);
db = sqlite3.open(data_path);

local sql = "CREATE TABLE IF NOT EXISTS settings (name,value);"
db:exec(sql);


function setSetting(name,value)   
    sql="DELETE FROM settings WHERE name='"..name.."'";
    db:exec( sql )
    
    sql="INSERT INTO settings (name,value) VALUES ('"..name.."',"..value..");";
    db:exec( sql )    
end

function setSettingString(name,value)
    setSetting(name,"'"..value.."'");
end




function getSetting(name)

    local sql="SELECT * FROM settings WHERE name='"..name.."'";
    local value=-1;

    for row in db:nrows(sql) do
        value=row.value;
    end    

    return value;
end

function getSettingString(name)
    local sql="SELECT * FROM settings WHERE name='"..name.."'";
    local value='';

    for row in db:nrows(sql) do
        value=row.value;
    end    

    return value;
end




myApp.utenti = {}
myApp.utenti['admin'] = { password = 'admin' }


function myApp:getNumUtenti()
    print(#myApp.utenti)
    return #myApp.utenti
end

-- Instanzio tabBar
myApp.tabBar = {}


-- Funzioni tabBar


function myApp.showHome()
    myApp.showMappa()
end

function myApp.showMappa()
    myApp.tabBar:setSelected(1)
    storyboard.removeAll()
    -- storyboard.gotoScene("mappa", {time=250, effect="crossFade"})
    storyboard.gotoScene("mappa")
    return true
end

function myApp.showVerifica()
    myApp.tabBar:setSelected(2)
    storyboard.removeAll()
    -- storyboard.gotoScene("verificatarga", {time=250, effect="crossFade"})
    storyboard.gotoScene("verificatarga")
    return true
end

function myApp.showAcquista()
    myApp.tabBar:setSelected(3)
    storyboard.removeAll()
    -- storyboard.gotoScene("acquista", {time=250, effect="crossFade"})
    storyboard.gotoScene("acquista")
    return true
end

function myApp.showInfo() 
    myApp.tabBar:setSelected(4)
    storyboard.removeAll()
    -- storyboard.gotoScene("informazioni", {time=250, effect="crossFade"})
    storyboard.gotoScene("informazioni")
    return true
end


-- Button per tabBar

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
        onPress = myApp.showMappa,
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
        onPress = myApp.showVerifica,
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
        onPress = myApp.showAcquista,
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
        onPress = myApp.showInfo,
    }
}


-- Creazione tabBar

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

-- Sfondo + Logo Splash Screen

local background = display.newRect(0,0, display.contentWidth, display.contentHeight)
background:setFillColor(255/myApp.colorDivisor,255/myApp.colorDivisor,255/myApp.colorDivisor)
background.x = display.contentCenterX
background.y = display.contentCenterY

local logo = display.newImageRect("Splash.png", 320, 480)
logo.x = display.contentCenterX
logo.y = display.contentCenterY


-- Rimuove Splash Screen

local function closeSplash()
    display.remove(logo)
    logo = nil
    display.remove(background)
    background = nil
    myApp.showHome()
end

timer.performWithDelay(1500, closeSplash)



