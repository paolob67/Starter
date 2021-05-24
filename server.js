var express = require('express');
var app = express();

app.use(express.static(__dirname + '/app/www'));


var server = app.listen(8080);