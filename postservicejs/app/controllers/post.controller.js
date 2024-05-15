const { v4: uuidv4 } = require('uuid');
const db = require('../models');
const Post = db.post;

exports.testRest = (req, res) => {
  res.status(200).send('Hello, World!');
};

exports.health = (req, res) => {
  res.status(200).send('Healthy');
};

exports.findAllPosts = async (req, res) => {
  try {
    const posts = await Post.find();
    res.status(200).json(posts);
  } catch (error) {
    console.error('Error retrieving posts:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.findPostByUserId = async (req, res) => {
  try {
    const { userId } = req.params;
    const posts = await Post.find({ userId });
    res.status(200).json(posts);
  } catch (error) {
    console.error('Error retrieving posts by user ID:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.createPost = async (req, res) => {
  try {
    const { userId, content, location } = req.body;
    const currentDate = new Date();

    const post = await Post.create({
      id: uuidv4(),
      userId,
      content,
      location,
      time: currentDate.toLocaleTimeString(),
      date: currentDate.toLocaleDateString(),
    });

    res.status(201).json(post);
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.updatePost = async (req, res) => {
  try {
    const { id } = req.params;
    const { content, location } = req.body;
    const currentDate = new Date();

    const updatedPost = await Post.findByIdAndUpdate(
      id,
      {
        content,
        location,
        time: currentDate.toLocaleTimeString(),
        date: currentDate.toLocaleDateString(),
      },
      { new: true }
    );

    if (!updatedPost) {
      return res.status(404).json({ error: 'Post not found' });
    }

    res.status(200).json(updatedPost);
  } catch (error) {
    console.error('Error updating post:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.deletePost = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedPost = await Post.findByIdAndDelete(id);

    if (!deletedPost) {
      return res.status(404).json({ error: 'Post not found' });
    }

    res.status(204).end();
  } catch (error) {
    console.error('Error deleting post:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};