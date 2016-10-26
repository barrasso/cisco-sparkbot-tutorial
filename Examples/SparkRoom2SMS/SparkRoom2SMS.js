/*
Copyright 2016 Cisco Systems Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

//Import two libraries
//Install request library

var request = require('request'); // request lib sends http requests to whereever you define / send request 
var http = require('http'); // webserver used to receive request/ 

//Declare object variables
//Insert your Tropo application token below for var data={"token": "<insert here>"};
var url = "https://api.tropo.com/1.0/sessions";
var method = "POST";
var headers = {"accept": "application/json", "content-type" : "application/json"};
var data = { "token": "<insert Tropo application token here>"};

//Declare function/Sends POST to Tropo
function sendRequest(myURL, myMethod, myHeaders, myData, callback) { // Sends RESTful requests
  
  var options = {
    url: myURL,
    method: myMethod,
    json: true,               
    headers: myHeaders,
    body: myData
  };
  
  var responseBody = ''; 
  
  request(options, function optionalCallback(error, response, body) {                                     
    if (error) {
      responseBody = "Request Failed: " + error;    
    } else {
      responseBody = body;  
    }
    callback(responseBody) 
  });                       
}
///End function one

          
       

//Call the createServer function / Don't need to write function because it's in the library Get/listen 


var portNumber = 80; // Set listen port number 


http.createServer(function (req, res) {      // Set up web listener to receive Webhook POST / Relaying.  
  if (req.method == 'POST') {              
                                           
    req.on('data', function(chunk) {               
      var resObj = JSON.parse(chunk.toString());   
                                              
         console.log(resObj);    
      
      
      
      //Call first function within the second function- Sends POST to Tropo
        sendRequest(url, method, headers, data, function(response){
        console.log(response);       
        });
           
      
    });
      ///End of calling first function
    
    
    req.on('end', function() {                                        
      res.writeHead(200, "OK", {'Content-Type': 'text/html'});                                                                     
      res.end();                                                    
    });

  } else {
    console.log("[405] " + req.method + " to " + req.url);        
    res.writeHead(405, "Method not supported", {'Content-Type': 'text/html'});   
    res.end('405 - Method not supported');
  }
}).listen(portNumber); // Listen on tcp portNumber value (all interfaces) 

//End of second function
