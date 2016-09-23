// (function() {
//     var childProcess = require("child_process");
//     var oldSpawn = childProcess.spawn;
//     function mySpawn() {
//         console.log('spawn called');
//         console.log(arguments);
//         var result = oldSpawn.apply(this, arguments);
//         return result;
//     }
//     childProcess.spawn = mySpawn;
// })();

require("bixbyte-frame");
app.port  = 3000;

//** SETUP THE PHP CGI
app.use("/php", php.cgi(`${__dirname}/../php`));

//** SETUP THE FILE UPLOADER
app.use("/upload",require(`${__dirname}/file_upload.js`));


//!SET THE BASIC DIRECTORY MIDDLEWARE
app.use(express.static( __dirname + '/../'));
app.use('/minutes', express.static(`${__dirname}/../uploads/minutes/`));

app.use( bodyParser.urlencoded({extended:true}) );
app.use( bodyParser.json() );


//!ROOT ROUTE
app.route("/").all(function(req,res){
	res.sendFile( "index.html");
});



//!THE SERVER STARTUP FILE
server.listen(app.port ,function(err){
	if(!err){
		log(`Running server on `.success + `http://${myAddr}:${app.port}`.err);
	}
});	
