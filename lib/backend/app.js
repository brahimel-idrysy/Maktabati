// Import the required packages
const express = require("express");
const session = require('express-session');
const cors =require('cors');
const dotenv =require('dotenv');
dotenv.config();
const mysql = require('mysql');
const crypto = require('crypto');
const bodyParser = require('body-parser');

const jwt = require('jsonwebtoken');


// Create a new Express app
const app = express();

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

// Parse request bodies as JSON
app.use(bodyParser.json());
// app.use(express.json());

// Registration endpoint
app.post('/register', (req, res) => {
  const { firstName, lastName, primaryId, numInscriptions,feliere } = req.body;

  // Insert the student data into the database
  const query = 'INSERT INTO etudiant (PRENOM, NOM, N_APOGEE , N_inscription, FILERE ) VALUES (?, ?, ?, ?, ?)';
  connection.query(query, [firstName, lastName, primaryId, numInscriptions, feliere], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      // Registration successful
      res.status(200).json({ message: 'Registration successful' });
    }
  });
});



// Login endpoint
app.post('/login', (req, res) => {
  const { login, password } = req.body;

  // Query the database for the user with the provided login and password
  const query = 'SELECT * FROM etudiant WHERE NOM = ? AND N_APOGEE  = ?';
  connection.query(query, [login, password], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      if (results.length === 1) {
        // Login successful
        const user = results[0];
        const payload = { n_apogee: user.N_APOGEE,nom: user.NOM, prenom: user.PRENOM, n_inscriptio: user.N_inscription };
        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '30d' });
        res.status(200).json({ token });
      } else {
        // Login failed
        res.status(401).json({ error: 'Invalid login or password' });
      }
    }
  });
});





// Define an API endpoint that returns data from the database
app.get('/books', (req, res) => {
  const query = 'SELECT * FROM livre';

  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});

app.get('/categories', (req, res) => {
  const query = 'SELECT * FROM categorie';

  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});

app.get('/search', (req, res) => {
  const { query } = req.query;
  const searchQuery = `SELECT * FROM livre WHERE TITRE LIKE '%${query}%' OR AUTHEUR LIKE '%${query}%'`;

  connection.query(searchQuery, (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});
app.get('/books/category/:categoryId', (req, res) => {
  const categoryId = req.params.categoryId;
  const query = `
    SELECT * FROM livre
    WHERE ID_CAT = ${categoryId}
  `;

  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});

// Profile Endpoint
app.get('/profile', (req, res) => {
  
  // Extracting the n_apogee from the headers
  const authorizationHeader = headers['Authorization'];
  const nApogee = authorizationHeader.split(' ')[1];

  // Fetch the user's profile data from the database
  const query = 'SELECT * FROM etudiant WHERE N_APOGEE = ?';
  connection.query(query, [nApogee], (error, results) => {
    if (error) {
      console.error('Error executing MySQL query:', error);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }
    const profileData = {
      nom: results[0].NOM,
      prenom: results[0].PRENOM,
      napogee: results[0].N_APOGEE,
      n_inscription: results[0].N_inscription,
      filiere: results[0].FILERE,
    };
    return res.status(200).json({ success: true, data: profileData });
  });
});

// Update Profile Endpoint
app.put('/editprofile', (req, res) => {
  // Extracting the n_apogee from the headers
const authorizationHeader = headers['Authorization'];
const nApogee = authorizationHeader.split(' ')[1];

  // Extract the updated profile information from the request body
  const { nom,
  prenom,
  n_inscription,
  feliere,} = req.body;

  // Update the user's profile information in the database
  const query = 'UPDATE etudiant SET NOM = ?, PRENOM = ?,, N_inscription  = ?, FILERE  = ? WHERE N_APOGEE = ?';
  connection.query(query, [nom, prenom, n_inscription, feliere, nApogee], (error, results) => {
    if (error) {
      console.error('Error executing MySQL query:', error);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }

    if (results.affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'User not found' });
    }

    return res.status(200).json({ success: true, message: 'Profile updated successfully' });
  });
});



// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
