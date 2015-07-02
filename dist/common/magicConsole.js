///todo: add IE detection

function createDevConsole() {

    var time;

    window.con = console;
    var addons = {
        ENV: 'development',
        traceStart: function() {
            time = Date.now()
        },

        traceStop: function(taskName){
            con.debug(taskName + ' complete for', Date.now() - time);
            time = 0;
        },

        test: function(someFunc){
            someFunc();
        }
    };


    for(var el in addons) {
        con[el] = addons[el];
    }
}

function createProdConsole() {

    window.con = {
        ENV: 'production',
        log: function(arguments){
            console.log(arguments)
        }
    };

    ['debug', 'error', 'traceStart', 'traceStop', 'test'].forEach(function(prop) {
        con[prop] = function(){}
    })
}

function createConsole(){

    if(window._debug) {

        console.log('env = development');
        createDevConsole();
    }

    else {
        createProdConsole();
    }
}

createConsole();
