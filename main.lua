
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

-- Instanzio titleBar 
myApp.titleBar = titleBar.new()
titleBar = nil


-- Distrugge le scene all'uscita
storyboard.purgeOnSceneChange = true







-- Database Utenti

myApp.utenti = {}
myApp.utenti[1] = { username = 'nonres', password = 'nonres' , nome = 'Mario', cognome = 'Rossi', tipo = 'Non residente', targa = ' QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', multiplo = 35}
myApp.utenti[2] = { username = 'res', password = 'res' , nome = 'Mario', cognome = 'Rossi', tipo = 'Residente' , targa = 'PP222PP', targaSelezionata = 2, cellulare = '123123456', email = 'mariorossi@gmail.com', cf = 'RSSMT12Q231WE1', patente = '121233', via = 'Via Roma', civico = '3', cap = '12321', accessi = 50, multiplo = 0}
myApp.utenti[3] = { username = 'dis', password = 'dis' , nome = 'Mario', cognome = 'Rossi', tipo = 'Disabile' , targa = 'QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', pass = '123', multiplo = 2}


myApp.utenteLoggato = 0

myApp.transiti ={}
myApp.transiti[1] ={ { "30/04/2014", "QW111QW" , "2€"}, { "22/05/2014", "PP222PP" , "5€"},
{ "01/03/2014", "PP222PP" , "5€"},{ "01/03/2014", "QW111QW" , "5€"},{ "01/03/2014", "KK333KK" , "5€"},
{ "01/03/2014", "PP222PP" , "5€"},{ "01/03/2014", "QW111QW" , "5€"}}




function myApp:getNumUtenti()
    return #myApp.utenti
end




-- Tutte le targhe di ogni utente

myApp.targheUtente_1 = { 'QW111QW' }
myApp.targheUtente_2 = { 'QW111QW', 'PP222PP', 'KK333KK', 'JJ444JJ' }
myApp.targheUtente_3 = { 'QW111QW', 'PP222PP' }

function myApp:getNumTargheUtente(num)
    if num == 1 then
        return #myApp.targheUtente_1
    elseif num == 2 then
        return #myApp.targheUtente_2
    elseif num == 3 then
        return #myApp.targheUtente_3
    elseif num == 4 then
        return #myApp.targheUtente_4
    elseif num == 5 then
        return #myApp.targheUtente_5
    elseif num == 6 then
        return #myApp.targheUtente_6
    elseif num == 7 then
        return #myApp.targheUtente_7
    elseif num == 8 then
        return #myApp.targheUtente_8
    elseif num == 9 then
        return #myApp.targheUtente_9
    elseif num == 10 then
        return #myApp.targheUtente_10
    end
end

function myApp:getTargheUtente(num)
    if num == 1 then
        return myApp.targheUtente_1
    elseif num == 2 then
        return myApp.targheUtente_2
    elseif num == 3 then
        return myApp.targheUtente_3
    elseif num == 4 then
        return myApp.targheUtente_4
    elseif num == 5 then
        return myApp.targheUtente_5
    elseif num == 6 then
        return myApp.targheUtente_6
    elseif num == 7 then
        return myApp.targheUtente_7
    elseif num == 8 then
        return myApp.targheUtente_8
    elseif num == 9 then
        return myApp.targheUtente_9
    elseif num == 10 then
        return myApp.targheUtente_10
    end
end




-- ricorda se una targa può o non può accedere

myApp.targhe = {}
myApp.targhe[1] = { accesso = true, targa = 'SI111SI' }
myApp.targhe[2] = { accesso = false, targa = 'NO111NO' }
myApp.targhe[3] = { accesso = true, targa = 'QW111QW' }
myApp.targhe[4] = { accesso = true, targa = 'PP222PP' }
myApp.targhe[5] = { accesso = true, targa = 'KK333KK' }
myApp.targhe[6] = { accesso = true, targa = 'JJ444JJ' }

function myApp:getNumTarghe()
    return #myApp.targhe
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

-- Attesa splash screen

timer.performWithDelay(1500, myApp.showHome())



