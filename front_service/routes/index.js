const express = require('express')
const router = express.Router()
const fs = require('fs')
const path = require('path')

const home_page = (req, res) => {
    // Read the content of the main.dart file
    const filePath = path.join(__dirname, '..', 'public',  'index.html')
    fs.readFile(filePath, 'utf8', (err, data) => {
        if (err) {
            console.error('Error reading file:', err)
            res.status(500).send('Error reading file')
            return
        }
        // Send the content of main.dart as HTML
        res.send(data)  
    })
}

const health = (req, res) => {
    res.sendStatus(200)
}

router.get('/home', home_page)
router.get('/health', health)
module.exports = router