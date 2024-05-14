const postController = require("../controllers/post.controller.js");

const authMiddleware = require('../models/auth.js');

module.exports = app => {
  const router = require("express").Router();

  router.get("/test", postController.testRest);
  router.get("/health", postController.health);

  // Apply the authMiddleware to routes that require authentication
  router.get("/", authMiddleware, postController.findAllPosts);
  router.get("/userId/:userId", authMiddleware, postController.findPostByUserId);
  router.post("/", authMiddleware, postController.createPost);
  router.put("/:id", authMiddleware, postController.updatePost);
  router.delete("/:id", authMiddleware, postController.deletePost);

  app.use('/api/posts', router);
};