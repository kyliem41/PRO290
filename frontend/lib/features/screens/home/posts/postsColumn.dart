import 'package:flutter/material.dart';
import 'package:frontend/features/screens/home/posts/post.dart';
import 'package:frontend/features/scripts/post_service_call.dart';
import 'package:geolocator/geolocator.dart';
import 'package:frontend/models/postModel.dart' as PostModel;
import 'package:frontend/features/scripts/post_service_call.dart' as postService;

class PostsColumn extends StatefulWidget {
  @override
  _PostsColumnState createState() => _PostsColumnState();
}

class _PostsColumnState extends State<PostsColumn> {
  // final PostService _postService = PostService();

  OverlayEntry? _overlayEntry;
  List<PostModel.Post> _posts = [];

  @override
void initState() {
  super.initState();
  _fetchPosts();
}

Future<void> _fetchPosts() async {
  try {
    List<PostModel.Post> posts = await postService.PostService.getAllPosts();
    setState(() {
      _posts = posts;
    });
  } catch (error) {
    // Handle error
    print('Error fetching posts: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Following',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 121, 107, 1))),
          centerTitle: true,
          backgroundColor: Colors.teal.shade100,
        ),
        SizedBox(height: 20),
        ListView.builder(
          padding: EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
          itemBuilder: (_, int index) => Post(post: _posts[index],), // Post is being called here ajfkjdsafkdsaj
          itemCount: _posts.length,
          //reverse: true,
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () {
              _overlayEntry = AddPostOverlayEntry(removeOverlayEntry).build(); // here is where post.dart is being called
              Overlay.of(context)?.insert(_overlayEntry!); 
            },
            child: Icon(Icons.edit_note_rounded),
          ),
        ),
      ],
    );
  }

  void removeOverlayEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}

class AddPostOverlayEntry {
  final VoidCallback removeOverlayEntry;

  AddPostOverlayEntry(this.removeOverlayEntry);

  OverlayEntry build() {
    return OverlayEntry(
      builder: (context) => AddPost(removeOverlayEntry),
    );
  }
}

class AddPost extends StatefulWidget {
  final VoidCallback onRemove;
  final PostService _postService = PostService();
  final TextEditingController _bodyController = TextEditingController();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  AddPost(this.onRemove);

  @override
  _AddPostState createState() => _AddPostState();
}

// Creates a new post
class _AddPostState extends State<AddPost> {
  // final PostService _postService = PostService();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _postService = PostService();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: 500,
        ),
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(238, 136, 207, 182),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: widget.onRemove,
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _bodyController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.arrow_forward_ios_rounded),
                              labelText: 'new post',
                              hintText: "what's on your mind?",
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _bodyController.text = value;
                              });
                            },
                          ),
                          SizedBox(height: 35),
                          SizedBox(
                            width: 170,
                            child: ElevatedButton(
                              onPressed: () async {
                                final body = _bodyController.text;
                                print(body);
                                // if (body.isEmpty) {
                                //   return;
                                // }
                                await PostService.createPost(body);
                                widget.onRemove();
                              },
                              child: Text('ADD'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
