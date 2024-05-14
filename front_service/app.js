var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var app = express();

const PORT = 8002;

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public-flutter')));

app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});

module.exports = app;