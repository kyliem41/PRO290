package pro290.post_service;



import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "") // need to have "value" - was giving me trouble not finding path...
public class PostRestController {

    @Autowired
    private PostRepository postRepository;

    @GetMapping(path = "/health")
    @ResponseStatus(code = HttpStatus.OK)
    public void Health() {  }

    @GetMapping(path = "/test")
    @ResponseStatus(code = HttpStatus.OK)
    public String TestRest() {
        return "hello world";
    }

    @GetMapping(path = "")
    @ResponseStatus(code = HttpStatus.OK)
    public Iterable<Post> findAllPosts() {
        return postRepository.findAll();
    }

    @GetMapping(path = "/userId/{uuid}")
    @ResponseStatus(code = HttpStatus.OK)
    public List<Post> findPostByUserId(@PathVariable String uuid) {
        return postRepository.findByUserId(uuid);
    }

    @PostMapping(path = "/post")
    @ResponseStatus(code = HttpStatus.CREATED)
    public void createPost(@RequestBody Post post) {
        post.setId(UUID.randomUUID());
        post.setDate(LocalDate.now().toString());
        post.setTime(LocalTime.now().toString());
        postRepository.save(post);
    }

    @PutMapping(path = "/{id}")
    @ResponseStatus(code = HttpStatus.OK)
    public void updatePost(@PathVariable UUID id, @RequestBody Post updatedPost) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Post not found with id: " + id));

        post.setContent(updatedPost.getContent());
        post.setLocation(updatedPost.getLocation());
        post.setTime(LocalTime.now().toString());
        post.setDate(LocalDate.now().toString());

        postRepository.save(post);
    }

    @DeleteMapping(path = "/{id}")
    @ResponseStatus(code = HttpStatus.NO_CONTENT)
    public void deletePost(@PathVariable UUID id) {
        Post post = postRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Post not found with id: " + id));

        postRepository.delete(post);
    }

}
