const express = require('express');
const { Pool } = require('pg'); 
const app = express();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL 
});

app.get('/api/db-test', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({ success: true, time: result.rows[0].now });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
});

app.listen(5000, () => console.log('Backend listening on 5000'));
