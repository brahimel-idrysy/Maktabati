// Import the required packages
const express = require("express");
// Create a new Express app
const app = express();
const cors =require('cors');
const dotenv =require('dotenv');
dotenv.config();
const mysql = require('mysql');
// Create a connection to the MySQL database
const connection = mysql.createConnection({
    host: process.env.host,
    user: process.env.user,
    password: process.env.password,
    database: process.env.database
});
 




// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to database:', err);
    return;
  }

  console.log('Connected to database');
});




// Define an API endpoint that returns data from the database
app.get('/data', (req, res) => {
  const query = 'SELECT * FROM utilisateur';

  // Execute the query and return the results as a JSON object
  connection.query(query, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.json(results);
  });
});

// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
