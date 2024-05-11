package pro290.post_service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.CrudRepository;

public interface PostRepository extends MongoRepository<Post, UUID> {

    List<Post> findByUserId(String userId);
    List<Post> findByContent(String content);
    Optional<Post> findById(UUID id);
    List<Post> findByLocation(String location);

}
