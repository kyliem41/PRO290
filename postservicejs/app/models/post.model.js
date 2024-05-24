
module.exports = mongoose => {
    const postSchema = mongoose.Schema(
      {
        id: {
          type: String,
          required: true,
          unique: true
        },
        userId: {
          type: String,
          required: true
        },
        content: {
          type: String,
          required: true
        },
        position: {
          type: Map,
          of: String,
          required: true
        },
        time: {
          type: String,
          required: true
        },
        date: {
          type: String,
          required: true
        }
      },
      { timestamps: true }
    );
  
    const Post = mongoose.model("post", postSchema);
    return Post;
  };