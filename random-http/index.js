// random-http/index.js
const express = require('express');
const app = express();
const port = 80;

app.get('/thiio', (req, res) => {
    res.send('Hello from Random HTTP Service!');
});

app.listen(port, () => {
    console.log(`Random HTTP Service running on port ${port}`);
});

