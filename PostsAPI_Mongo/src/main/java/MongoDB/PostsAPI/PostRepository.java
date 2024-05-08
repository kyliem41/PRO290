package MongoDB.PostsAPI;

import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.UUID;
import java.util.Optional;

public interface PostRepository extends MongoRepository<Post, UUID> {

    List<Post> findByUserId(String userId);
    List<Post> findByContent(String content);
    Optional<Post> findById(UUID id);
    List<Post> findByLocation(String location);

}
