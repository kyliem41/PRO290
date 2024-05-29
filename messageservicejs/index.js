const express = require('express');
const path = require('path');
const cors = require('cors');
const app = express();

var corsOptions = {
  //origin: 'http://localhost:3000',
  // origin: 'http://localhost:3000',
};

app.use(cors());

// MongoDB connection
const db = require("./app/models");
require("./app/models/consul.js");
db.mongoose
  .connect(db.url)
  .then(() => {
    console.log("Connected to the database!");
  })
  .catch(err => {
    console.log("Cannot connect to the database!", err);
    process.exit();
  });

// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

// routes
require("./app/routes/message.routes.js")(app);

// set port, listen for requests
const port = process.env.PORT || 6002;
app.listen(port, () => {
  console.log(`Server is running on port ${port}.`);
  console.log(`http://localhost:${port}`);
});