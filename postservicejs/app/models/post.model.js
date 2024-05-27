
module.exports = mongoose => {
    const postSchema = mongoose.Schema(
      {
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
      { timestamps: true, toJSON: { virtuals: true } }
    );
  
      postSchema.virtual('id').get(function() {
        return this._id.toString();
      });
  
    const Post = mongoose.model("post", postSchema);
    return Post;
  };