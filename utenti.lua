--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local myApp = require( "myapp" ) 


-- Database Utenti

myApp.utenti = {}
myApp.utenti[1] = { username = 'nonres', password = 'nonres' , nome = 'Mario', cognome = 'Rossi', tipo = 'Non residente', targa = ' QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', multiplo = 0}
myApp.utenti[2] = { username = 'res', password = 'res' , nome = 'Mario', cognome = 'Rossi', tipo = 'Residente' , targa = 'PP222PP', targaSelezionata = 2, cellulare = '123123456', email = 'mariorossi@gmail.com', cf = 'RSSMT12Q231WE1', patente = '121233', via = 'Via Roma', civico = '3', cap = '12321', accessi = 40, multiplo = 0}
myApp.utenti[3] = { username = 'dis', password = 'dis' , nome = 'Mario', cognome = 'Rossi', tipo = 'Disabile' , targa = 'QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', pass = '123', multiplo = 2}

myApp.transiti ={}
myApp.transiti[1] ={
{ "01/06/2014", "PP222PP" , "DA PAGARE"}, { "31/05/2014", "KK333KK" , "DA PAGARE"},
{ "30/05/2014", "QW111QW" , "5€"}, { "29/05/2014", "PP222PP" , "5€"},
{ "22/05/2014", "PP222PP" , "5€"}, { "21/05/2014", "QW111QW" , "5€"}, 
{ "30/04/2014", "QW111QW" , "5€"}, { "16/02/2014", "KK333KK" , "5€"},
{ "11/02/2014", "QW111QW" , "5€"}, { "9/02/2014", "PP222PP" , "5€"},}
myApp.transiti[2] ={
{ "01/06/2014", "AA234BB" , "2€"}, { "31/05/2014", "AA234BB" , "0€"},
{ "24/05/2014", "AA234BB" , "0€"}, { "22/05/2014", "AA234BB" , "2€"},
{ "21/05/2014", "AA234BB" , "0€"}, { "20/05/2014", "AA234BB" , "0€"}, 
{ "02/05/2014", "AA234BB" , "0€"}, { "16/02/2014", "CC123DD" , "5€"},
{ "31/03/2014", "AA234BB" , "0€"}, { "22/03/2014", "CC123DD" , "5€"},
{ "20/03/2014", "AA234BB" , "0€"}, { "16/03/2014", "CC123DD" , "5€"},
{ "11/02/2014", "CC123DD" , "5€"}, { "09/02/2014", "CC123DD" , "5€"},}
myApp.transiti[3] ={
{ "30/05/2014", "ZZ345ZZ" , "5€"}, { "22/05/2014", "ZZ345ZZ" , "5€"}, 
{ "30/04/2014", "ZZ345ZZ" , "5€"}, { "11/02/2014", "ZZ345ZZ" , "5€"}}

-- Tutte le targhe di ogni utente

myApp.targheUtente = {}
myApp.targheUtente[1] = { 'QW111QW', 'PP222PP', 'KK333KK' }
myApp.targheUtente[2] = { 'QW111QW', 'PP222PP', 'KK333KK', 'JJ444JJ' }
myApp.targheUtente[3] = { 'QW111QW', 'ZZ345ZZ' }

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


function myApp:getNumTargheUtente(num)
    return #myApp.targheUtente[num]
end

function myApp:getTargheUtente(num)
    return myApp.targheUtente[num]
end

function myApp:getNumUtenti()
    return #myApp.utenti
end

function myApp:getNumTarghe()
    return #myApp.targhe
end