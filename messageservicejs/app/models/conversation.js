const mongoose = require('mongoose');

const conversationSchema = new mongoose.Schema({
    conversationId: {
        type: String,
        required: true,
    },
    firstUserId: { 
        type: String,
        required: true,
    },
    secondUserId: {
        type: String,
        required: true,
    }
}, { 
    versionKey: false,
});

const Conversation = mongoose.model('Conversation', conversationSchema);

module.exports = Conversation;
