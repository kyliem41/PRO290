const jwt = require('jsonwebtoken');
const dbConfig = require("../config/db.config.js");

const authMiddleware = (req, res, next) => {
  // Get the JWT token from the request headers
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(401).json({ error: 'No token provided' });
  }

  try {
    // Verify the token
    const decoded = jwt.verify(token, dbConfig.secrettoken);

    // Attach the decoded token to the request object
    req.user = decoded;

    // Proceed to the next middleware or route handler
    next();
  } catch (error) {
    return res.status(401).json({ error: 'Invalid token' });
  }
};

module.exports = authMiddleware;