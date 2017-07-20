// var express = require('express');
// var app = express();
var path = require('path');
require('bixbyte-frame');


//** SETUP THE PHP CGI
app.use("/php", php.cgi(`${__dirname}/php`));
app.use("/views", express.static( __dirname+'/views' ));


//!SET THE BASIC DIRECTORY MIDDLEWARE
app.use(express.static( __dirname + '/public'));

app.use( bodyParser.urlencoded({extended:true}) );
app.use( bodyParser.json() );

app.get('/', function(req, res){
    res.sendFile('index.html', {root: path.join(__dirname, '/')});
});

// app.get(/^(.+)$/, function(req, resp){
//      console.log(req.params);
//      resp.sendFile(req.params[0], {root: path.join(__dirname, '')});
// });


app.port = 3000;
//!THE SERVER STARTUP FILE
server.listen(app.port ,function(err){
	if(!err){
		log(`Running server on `.success + `http://${myAddr}:${app.port}`.err);
	}
});
