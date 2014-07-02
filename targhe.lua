--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local myApp = require( "myapp" ) 

-- Targhe valide

myApp.datiTarghe = {}
myApp.datiTarghe.euro = {"0", "1", "2", "3", "4"}
myApp.datiTarghe.tipo = { "Autovettura per trasporto di Persone" }
myApp.datiTarghe.alim = {"Benzina", "Diesel", "Elettrica", "Metano"}

myApp.targhe = {}
myApp.targhe[1] = { accesso = "p", targa = 'SI111SI', euro = myApp.datiTarghe.euro[5], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[2] }
myApp.targhe[2] = { accesso = "v", targa = 'NO111NO', euro = myApp.datiTarghe.euro[1], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[1] }
myApp.targhe[3] = { accesso = "p", targa = 'QW111QW', euro = myApp.datiTarghe.euro[3], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[1] }
myApp.targhe[4] = { accesso = "p", targa = 'PP222PP', euro = myApp.datiTarghe.euro[4], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[4] }
myApp.targhe[5] = { accesso = "p", targa = 'KK333KK', euro = myApp.datiTarghe.euro[4], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[1] }
myApp.targhe[6] = { accesso = "g", targa = 'GG111GG', euro = myApp.datiTarghe.euro[5], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[3] }
myApp.targhe[6] = { accesso = "p", targa = 'AA111AA', euro = myApp.datiTarghe.euro[5], tipo=myApp.datiTarghe.tipo[1], alim=myApp.datiTarghe.alim[1] }

-- Targhe pagate

myApp.targhePagate = {}
myApp.targhePagate[1] = "AA111AA"


function myApp:checkTargaPagata(targa)
    for i = 1, #myApp.targhePagate do
        if myApp.targhePagate[i] == targa then
            return true
        end
    end
end