local storyboard = require ( "storyboard" )
local widget = require( "widget" )
local myApp = require( "myapp" ) 

myApp.tabBar = {}

-- Funzioni tabBar
function myApp.showHome()
    myApp.showMappa()
end

function myApp.showMappa()
    myApp.tabBar:setSelected(1)
    storyboard.removeAll()
    storyboard.gotoScene("mappa")
    return true
end

function myApp.showVerifica()
    myApp.tabBar:setSelected(2)
    storyboard.removeAll()
    storyboard.gotoScene("verificatarga")
    return true
end

function myApp.showAcquista()
    myApp.tabBar:setSelected(3)
    storyboard.removeAll()
    storyboard.gotoScene("acquista")
    return true
end

function myApp.showInfo() 
    myApp.tabBar:setSelected(4)
    storyboard.removeAll()
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

