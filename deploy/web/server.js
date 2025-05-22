const express = require('express');
const axios = require('axios');
const app = express();

app.use(express.json());
app.use(express.static('public'));

app.post('/predict', async (req, res) => {
    try {
        const response = await axios.post('http://gr4dp-service/predict', req.body);
        res.json(response.data);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(3000, () => console.log('Web server on port 3000'));
