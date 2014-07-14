--[[
    Project name: AreaC
    Authors: Matteo Lanza, Cristian Speranza
]]--

local myApp = require( "myapp" ) 


-- Database Utenti

myApp.utenti = {}
myApp.utenti[1] = { username = 'nonres', password = 'nonres' , nome = 'Mario', cognome = 'Rossi', tipo = 'Non residente', targa = 'QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', multiplo = 0}
myApp.utenti[2] = { username = 'res', password = 'res' , nome = 'Mario', cognome = 'Rossi', tipo = 'Residente' , targa = 'PP222PP', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', cf = 'RSSMT12Q231WE1', patente = '121233', via = 'Via Roma', civico = '3', cap = '12321', accessi = 40, multiplo = 0}
myApp.utenti[3] = { username = 'dis', password = 'dis' , nome = 'Mario', cognome = 'Rossi', tipo = 'Disabile' , targa = 'QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', pass = '123', multiplo = 2}

myApp.transiti ={}
myApp.transiti[1] ={
{ "01/06/2014", "PP222PP" , "da pagare"}, { "31/05/2014", "KK333KK" , "da pagare"},
{ "30/05/2014", "QW111QW" , "5€"}, { "29/05/2014", "PP222PP" , "5€"},
{ "22/05/2014", "PP222PP" , "5€"}, { "21/05/2014", "QW111QW" , "5€"}, 
{ "30/04/2014", "QW111QW" , "5€"}, { "16/02/2014", "KK333KK" , "5€"},
{ "11/02/2014", "QW111QW" , "5€"}, { "9/02/2014", "PP222PP" , "5€"},}
myApp.transiti[2] ={
{ "01/06/2014", "AA234BB" , "2€"}, { "31/05/2014", "AA234BB" , "da pagare"},
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
myApp.targheUtente[1] = { 'QW111QW', 'BB333BB' }
myApp.targheUtente[2] = { 'PP222PP', 'KK333KK', 'JJ444JJ' }
myApp.targheUtente[3] = { 'QW111QW', 'ZZ345ZZ' }


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