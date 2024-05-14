const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
  messageId: {
    type: String,
    unique: true,
    required: true,
  },
  senderId: {
    type: String,
    required: true,
  },
  recipientIds: {
    type: [String],
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  timestamp: {
    type: Date,
    default: Date.now,
  },
  type: {
    type: String,
    enum: ['text', 'image', 'video', 'file'],
    default: 'text',
  },
  conversationId: {
    type: String,
    required: true,
  },
  readStatus: {
    type: Boolean,
    default: false,
  },
});

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;