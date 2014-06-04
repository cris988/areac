local myApp = require( "myapp" ) 

-- Database Utenti

myApp.utenti = {}
myApp.utenti[1] = { username = 'nonres', password = 'nonres' , nome = 'Mario', cognome = 'Rossi', tipo = 'Non residente', targa = ' QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', multiplo = 35}
myApp.utenti[2] = { username = 'res', password = 'res' , nome = 'Mario', cognome = 'Rossi', tipo = 'Residente' , targa = 'PP222PP', targaSelezionata = 2, cellulare = '123123456', email = 'mariorossi@gmail.com', cf = 'RSSMT12Q231WE1', patente = '121233', via = 'Via Roma', civico = '3', cap = '12321', accessi = 50, multiplo = 0}
myApp.utenti[3] = { username = 'dis', password = 'dis' , nome = 'Mario', cognome = 'Rossi', tipo = 'Disabile' , targa = 'QW111QW', targaSelezionata = 1, cellulare = '123123456', email = 'mariorossi@gmail.com', pass = '123', multiplo = 2}


myApp.utenteLoggato = 0

myApp.transiti ={}
myApp.transiti[1] ={
{ "01/06/2014", "PP222PP" , "5€"}, { "31/05/2014", "KK333KK" , "5€"},
{ "30/05/2014", "QW111QW" , "5€"}, { "29/05/2014", "PP222PP" , "5€"},
{ "22/05/2014", "PP222PP" , "5€"}, { "21/05/2014", "QW111QW" , "5€"}, 
{ "30/04/2014", "QW111QW" , "5€"}, { "16/02/2014", "KK333KK" , "5€"},
{ "11/02/2014", "QW111QW" , "5€"}, { "9/02/2014", "PP222PP" , "5€"},}
myApp.transiti[2] ={
{ "01/06/2014", "AA234BB" , "2€"}, { "31/05/2014", "AA234BB" , "0€"},
{ "24/05/2014", "AA234BB" , "0€"}, { "22/05/2014", "AA234BB" , "2€"},
{ "21/05/2014", "AA234BB" , "0€"}, { "20/05/2014", "AA234BB" , "0€"}, 
{ "02/05/2014", "AA234BB" , "2€"}, { "16/02/2014", "CC123DD" , "5€"},
{ "11/02/2014", "CC123DD" , "5€"}, { "9/02/2014", "CC123DD" , "5€"},}
myApp.transiti[3] ={
{ "30/05/2014", "ZZ345ZZ" , "5€"}, { "22/05/2014", "ZZ345ZZ" , "5€"}, 
{ "30/04/2014", "ZZ345ZZ" , "0€"}, { "11/02/2014", "ZZ345ZZ" , "5€"}}


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