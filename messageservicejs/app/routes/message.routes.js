const messageController = require("../controllers/message.controller.js");
const authMiddleware = require('../models/auth.js');

module.exports = app => {
  const router = require("express").Router();

  router.get("/test", messageController.testRest);
  router.get("/health", messageController.health);

  // Apply the authMiddleware to routes that require authentication
  router.get("/", authMiddleware, messageController.findAllMessages);
  router.get("/sender/:senderId", authMiddleware, messageController.findMessagesBySenderId);
  router.post("/", authMiddleware, messageController.createMessage);
  router.put("/:messageId", authMiddleware, messageController.updateMessage);
  router.delete("/:messageId", authMiddleware, messageController.deleteMessage);

  app.use('/api/messages', router);
};