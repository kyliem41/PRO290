module.exports = app => {
    const story = require("../controllers/story.controller.js");

    var router = require("express").Router();

    // Create a new Story
    router.post("/", story.create);

    // Retrieve all Stories
    router.get("/", story.findAll);

    // Retrieve a single Story with id
    router.get("/:id", story.findOne);

    //Retrieve a list of Stories with title
    router.get("/title/:title", story.findByTitle);

    //Retrieve a list of Stories with genre
    router.get("/genre/:genre", story.findByGenre);

    // Update a Story with id
    router.put("/:id", story.update);

    // Delete a Story with id
    router.delete("/:id", story.delete);

    app.use('/api/stories', router)
}