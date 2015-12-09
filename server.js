'use strict';

var http = require('http');
var PORT = 3000;
var fail = false;

var server = http.createServer(function(req, res) {
	if (req.url === '/fail') {
		fail = true;
	} else if (req.url === '/restore') {
		fail = false;
	} else if (req.url === '/healthcheck') {
		if (fail) {
			res.statusCode = 503;
			return res.end('Something is failing');
		} else {
			return res.end('Test server is working');
		}
	}

	var envList = Object.keys(process.env).reduce(function(memo, key) {
		return memo += key + ': ' + process.env[key] + '\n';
	}, '');
	res.end('It works! Environment:\n========================\n' + envList);
});

function terminationHandler() {
	fail = true;
}

process.on('SIGTERM', terminationHandler);

server.listen(PORT, function() {
	console.log('Server listening on ' + PORT);
});
