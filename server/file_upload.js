//# ensure that the upload folder exists
//@ Uploading to ../uploads/minutes
var dirPath = `${__dirname}/../uploads/minutes`;
if ( !fs.existsSync(dirPath) ){
    var filebuilder = `${__dirname}/..`;
    dirPath
    .split("..")[1]
    .split("/")
    .filter(p=>p)
    .forEach(filedest => { 
        filebuilder+=`/${filedest}`; 
        if( !fs.existsSync(filebuilder) ){
            fs.mkdirSync(filebuilder);
        }
    });
};

// //@ INSTANTIATE THE FILE UPLODER
const upload = multer({});

var router = new express.Router();

var request = require('request');
 
// Set the headers
var headers = {
    'User-Agent':       'Super Agent/0.0.1',
    'Content-Type':     'application/x-www-form-urlencoded'
}
 
const CREATE_HASH = function( file_buffer ){
    return new Promise(function(resolve,reject){
        resolve( crypt.md5(file_buffer) );
    })
} 
 
router.post("/minutes", upload.fields([{name:"minutes",maxCount:1}]),(req,res,all )=>{
    
    //@ HASH THE MINUTES TO CREATE AN IDENTIFIER AND A UNIQUE MINUTE FILENAME
    CREATE_HASH( req.files.minutes[0].buffer )
    .then((minute_filename_hash)=>{
    
         //@ GET THE FILE'S DEFAULT EXTENSION
         var ext      = req.files.minutes[0].originalname.split(".").pop();
         var filepath = `${dirPath}/${minute_filename_hash}.${ext}`;
         var insert_data =  {
                                minute_id   : `${minute_filename_hash}.${ext}`,
                                token       : { 
                                                user: "userAdmin", 
                                                key: "8f0d2efa64c11c3865827eb6fa96e361" 
                                              }
                            };
                
        //@ COPY THE  INSERT DATA OPTIONS TO THE REQUEST OBJECT
        Object.assign(req.body,insert_data);
                
        
        //@ WRITE THE FILE TO THE SYSTEM
        fs.writeFile(filepath,req.files.minutes[0].buffer,(err) => {
            if(err){
                res.send( make_response(500, err.message ) );
            }else{
                
                // (c_log(2,req.body) );             
                //@ Make an API call to the main cgi file and insert the record to the database
                //@ THE REQUEST OPTIONS
                var options = {
                    url: `http://${myAddr}:${app.port}/php`,
                    method: 'GET',
                    headers: headers,
                    qs: req.body
                };
                
                //@ INITIATE THE REQUEST
                request(options, function (error, response, body) {
                    
                    if (!error && response.statusCode == 200) {
                        res.send(body);                        
                    }else{                        
                        //@ LET THE USER KNOW THAT SOMETHING WENT WRONG                        
                        fs.unlink(filepath,(e)=>{
                            c_log(`\nBody:\n`)
                            c_log(`${body}`)
                            c_log(`\nError:\n`)
                            c_log(`${error}`)
                            c_log(`\nResponse:\n`)
                            c_log(`${response}`)
                            
                            res.send( make_response(500, { error: error,  body: body, response: response }) ); 
                        })  
                                                           
                    }
                    
                });
                
            }
                
        })
        
    })
    .catch(error=>res.send( make_response(500,error.message, "Captured at the hash promise catch block") ))
    
});

console.log( "\n✔".succ + "  I n i t i a l i z e d  t h e  f i l e  u p l o a d  s e r v i c e".info );
module.exports = router;