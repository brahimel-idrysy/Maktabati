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
// UUID (Universally Unique Identifier)
const { v4: uuidv4 } = require('uuid');
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

// Configure body-parser middleware
// Parse request bodies as JSON
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

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
        const payload = { n_apogee: user.N_APOGEE,nom: user.NOM, prenom: user.PRENOM, n_inscription: user.N_inscription };
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
app.post('/profile', (req, res) => {
  const {napogee} = req.body;

  // Fetch the user's profile data from the database
  const query = 'SELECT * FROM etudiant WHERE N_APOGEE = ?';
  connection.query(query, [napogee], (error, results) => {
    if (error) {
      console.error('Error executing MySQL query:', error);
      return res.status(500).json({ success: false, message: 'Internal server error' });
    }

    if (results.length === 0) {
      console.log("User not found")
      return res.status(404).json({ success: false, message: 'User not found' });
    }
    const profileData = {
      nom: results[0].NOM,
      prenom: results[0].PRENOM,
      n_inscription: results[0].N_inscription,
      filiere: results[0].FILERE,
    };
    
    return res.status(200).json({ success: true, data: profileData });
  });
});

// Update Profile Endpoint
app.put('/editprofile', (req, res) => {
  // Extract the n_apogee from the Authorization header
  const bearerHeader = req.headers['authorization'];
  if (!bearerHeader) {
    return res.status(401).json({ success: false, message: 'Missing token' });
  }

  const nApogee = bearerHeader.split(' ')[1];

  // Extract the updated profile information from the request body
  const { nom,
  prenom,
  n_inscription,
  feliere,} = req.body;

  // Update the user's profile information in the database
  const query = 'UPDATE etudiant SET NOM = ?, PRENOM = ?, N_inscription  = ?, FILERE  = ? WHERE N_APOGEE = ?';
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
// Define an API endpoint that returns data from the database
app.get('/borrowbooks', (req, res) => {
  const n_inscription = req.query.n_inscription;

  const query = 'SELECT el.DATE_D, el.DATE_F, l.PAGE_DE_GARDE, l.TITRE, l.AUTHEUR FROM emprunt_livre_etudiant el JOIN livre l ON el.IDLE = l.ID_LIVRE WHERE el.N_inscription = ?';

  connection.query(query, [n_inscription], (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      const currentDate = new Date();
      const borrowbooks = results.map((row) => {
        const { DATE_D, DATE_F, PAGE_DE_GARDE, TITRE, AUTHEUR } = row;
        const differenceInMilliseconds = new Date(DATE_F) - currentDate;
        const differenceInSeconds = differenceInMilliseconds / 1000;
        const differenceInMinutes = differenceInSeconds / 60;
        const differenceInHours = differenceInMinutes / 60;
        const differenceInDays = differenceInHours / 24;
        const date_L = Math.floor(differenceInDays);
        
        return {
          DATE_D,
          DATE_F,
          PAGE_DE_GARDE,
          TITRE,
          AUTHEUR,
          date_L,
        };
      });

      res.send(borrowbooks);
    }
  });
});


// Define an API endpoint that returns data from the database
app.get('/Favorite', (req, res) => {
  const nApogee = req.query.nApogee;

  const query = 'SELECT * FROM favorite WHERE ID_E = ?';

  connection.query(query, [nApogee],(error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});


// API endpoint to add a book to favorites
app.post('/addFavorite', (req, res) => {

  const { bookid ,napogee,titre,author,observation,pagedegarde,sommaire,prix,editeur,date_edition,code} = req.body;

  // Insert the book into the favorites table
  const query = 'INSERT INTO favorite (ID_E, 	ID_LIVRE,TITRE,AUTHEUR,OBSERVATIONL,PAGE_DE_GARDE, SOMAIRE, PRIX, EDITEUR, DATE_EDITION, CODE) VALUES (?, ?,?,?,?,?,?,?,?,?,?)';
  connection.query(query, [napogee, bookid,titre,author,observation,pagedegarde,sommaire,prix,editeur,date_edition,code], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json({ message: 'Book added to favorites' });
    }
  });
});


// API endpoint to remove a book from favorites
app.post('/removeFavorite', (req, res) => {

  const { bookid,napogee} = req.body;

  // Delete the book from the favorites table
  const query = 'DELETE FROM favorite WHERE ID_E = ? AND ID_LIVRE = ?';
  connection.query(query, [napogee, bookid], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json({ message: 'Book removed from favorites' });
    }
  });
});

// Define an API endpoint that returns data from the database
app.get('/Card', (req, res) => {
  const query = 'SELECT * FROM card';

  connection.query(query, (error, results) => {
    if (error) {
      console.error(error);
      res.sendStatus(500);
    } else {
      res.send(results);
    }
  });
});
// API endpoint to add a book to Card
app.post('/addCard', (req, res) => {

  const { bookid ,napogee,titre,author,observation,pagedegarde,sommaire,prix,editeur,date_edition,code} = req.body;

  // Insert the book into the Card table
  const query = 'INSERT INTO card (ID_E, 	ID_LIVRE,TITRE,AUTHEUR,OBSERVATIONL,PAGE_DE_GARDE, SOMAIRE, PRIX, EDITEUR, DATE_EDITION, CODE) VALUES (?, ?,?,?,?,?,?,?,?,?,?)';
  connection.query(query, [napogee, bookid,titre,author,observation,pagedegarde,sommaire,prix,editeur,date_edition,code], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json({ message: 'Book added to Card' });
    }
  });
});
// API endpoint to remove a book from Card
app.post('/removeCard', (req, res) => {

  const { bookid,napogee} = req.body;

  // Delete the book from the Card table
  const query = 'DELETE FROM card WHERE ID_E = ? AND ID_LIVRE = ?';
  connection.query(query, [napogee, bookid], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Internal Server Error' });
    } else {
      res.status(200).json({ message: 'Book removed from Card' });
    }
  });
});

function generateRandomCode(length) {
  let code = '';

  const characters = '0123456789';
  const charactersLength = characters.length;

  for (let i = 0; i < length; i++) {
    code += characters.charAt(Math.floor(Math.random() * charactersLength));
  }

  return code;
}

function generateUniqueCode(length) {
  let code = '';
  const usedCodes = new Set();

  while (usedCodes.size < 10 ** length) {
    code = generateRandomCode(length);
    usedCodes.add(code);
  }

  return code;
}

// Handle POST request for reservation
app.post('/reservation', (req, res) => {
  const { recuperationDate, ID_E } = req.body;
  const selectQuery = 'SELECT ID_LIVRE, TITRE FROM card WHERE ID_E = ?';

  connection.query(selectQuery, [ID_E], (err, results) => {
    if (err) {
      console.error('Error selecting data from MySQL:', err);
    } else {
    
      const reservationCode = generateUniqueCode(6);

      const dataToInsert = results.flatMap((row) => {
        const ID_LIVRE = row.ID_LIVRE;
        const TITRE = row.TITRE;
        const RES_CODE = reservationCode;
        const DATE_DE_RECUPERATION = recuperationDate;
        return [[ID_LIVRE, TITRE, RES_CODE, ID_E, DATE_DE_RECUPERATION]];
      });

      const insertQuery =
        'INSERT INTO reservations (ID_LIVRE, TITRE, RES_CODE, ID_E, DATE_DE_RECUPERATION) VALUES ?';

      connection.query(insertQuery, [dataToInsert], (err, result) => {
        if (err) {
          console.error('Error inserting data into MySQL:', err);
        } else {
          res.status(200).json({});
          console.log('Data inserted successfully');
          const query = 'DELETE FROM card WHERE ID_E = ?';
          connection.query(query, [ID_E], (err, result) => {
            if (err) {
              console.error('Error inserting data into MySQL:', err);
            }else{
              console.log('Data deletes successfully');
            }
          });
        }
      });
    }
  });
});

app.get('/reservationdata', (req, res) => {
  
  const nApogee = req.query.nApogee;
  const selectedDate = req.query.selectedDate;
  const query = 'SELECT * FROM reservations WHERE ID_E=? AND DATE_DE_RECUPERATION=?';
  connection.query(query,[nApogee,selectedDate] ,(error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Failed to fetch data from the database' });
    } else {
      res.json(results);
    }
  });
});





// Start the server
const port = 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
