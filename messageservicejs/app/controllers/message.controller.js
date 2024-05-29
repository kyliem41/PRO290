const { v4: uuidv4 } = require('uuid');
const Message = require('../models/message.model');
const Conversation = require("../models/conversation")

exports.testRest = (req, res) => {
  res.status(200).send('Hello, World!');
};

exports.health = (req, res) => {
  res.status(200).send('Healthy');
};

exports.getConversationId = async (req, res) => {
  try {
    const conversationId = await Conversation.find();
    res.status(200).json(conversationId);
  } catch {
    console.error('Error getting conversationId');
    res.status(500).json({ error: 'getting Internal Server Error '});
  }
};

exports.findAllMessages = async (req, res) => {
  try {
    const messages = await Message.find();
    res.status(200).json(messages);
  } catch (error) {
    console.error('Error retrieving messages:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.findMessagesBySenderId = async (req, res) => {
  try {
    const { senderId } = req.params;
    const messages = await Message.find({ senderId });
    res.status(200).json(messages);
  } catch (error) {
    console.error('Error retrieving messages by sender ID:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.findConversations = async (req, res) => {
  try {
    const userId = req.user.id;
    const conversationId = req.conversation.conversationId;

    const conversations = await Conversation.find({
      $or: [
        { conversationId: conversationId },
        { firstUserId: userId },
        { secondUserId: userId }
      ],
      $and: [
        { $or: [{ conversationId: conversationId }, { firstUserId: userId }, { secondUserId: userId }] },
        { $or: [{ conversationId: { $ne: conversationId } }, { firstUserId: { $ne: userId } }, { secondUserId: { $ne: userId } }] }
      ]
    });

    res.status(200).json(conversations);
  } catch (error) {
    console.error('Error retrieving conversations:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.createMessage = async (req, res) => {
  try {
    const { senderId, recipientIds, content, type, conversationId } = req.body;

    const message = await Message.create({
      messageId: uuidv4(),
      senderId,
      recipientIds,
      content,
      type,
      conversationId,
    });

    res.status(201).json(message);
  } catch (error) {
    console.error('Error creating message:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.createConversation = async (req, res) => {
  try {
    const { senderId } = req.params;
    const { recipientIds } = req.body;

    if (!Array.isArray(recipientIds)) {
      return res.status(400).json({ error: 'recipientIds must be an array' });
    }

    const conversation = await Conversation.create({
      conversationId: uuidv4(),
      senderId,
      recipientIds,
    });

    res.status(200).json(conversation);
  } 
  catch (error) {
    console.error('Error creating conversation:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.updateMessage = async (req, res) => {
  try {
    const { messageId } = req.params;
    const { content, readStatus } = req.body;

    const updatedMessage = await Message.findOneAndUpdate(
      { messageId },
      { content, readStatus },
      { new: true }
    );

    if (!updatedMessage) {
      return res.status(404).json({ error: 'Message not found' });
    }

    res.status(200).json(updatedMessage);
  } catch (error) {
    console.error('Error updating message:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.deleteMessage = async (req, res) => {
  try {
    const { messageId } = req.params;

    const deletedMessage = await Message.findOneAndDelete({ messageId });

    if (!deletedMessage) {
      return res.status(404).json({ error: 'Message not found' });
    }

    res.status(204).end();
  } catch (error) {
    console.error('Error deleting message:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};