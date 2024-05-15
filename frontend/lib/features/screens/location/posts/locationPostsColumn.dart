import 'package:flutter/material.dart';
import 'package:frontend/features/screens/location/posts/locationPost.dart';

class LocationPostsColumn extends StatefulWidget {
  @override
  _LocationPostsColumnState createState() => _LocationPostsColumnState();
}

class _LocationPostsColumnState extends State<LocationPostsColumn> {
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Location',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(0, 121, 107, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade100,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              itemBuilder: (_, int index) => LocationPost(),
              itemCount: 10,
              reverse: false,
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                _overlayEntry = AddPostOverlayEntry(removeOverlayEntry).build();
                Overlay.of(context)?.insert(_overlayEntry!);
              },
              child: Icon(Icons.edit_note_rounded),
            ),
          ),
        ],
      ),
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

class AddPost extends StatelessWidget {
  final VoidCallback onRemove;
  AddPost(this.onRemove);

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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
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
                          onPressed: onRemove,
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.arrow_forward_ios_rounded),
                        labelText: 'new post',
                        hintText: "what's on your mind?",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('ADD'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:frontend/features/screens/home/posts/post.dart';

// class LocationPostsColumn extends StatefulWidget {
//   @override
//   _LocationPostsColumnState createState() => _LocationPostsColumnState();
// }

// class _LocationPostsColumnState extends State<LocationPostsColumn> {
//   OverlayEntry? _overlayEntry;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         AppBar(
//           automaticallyImplyLeading: false,
//           title: const Text('Location',
//               style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromRGBO(0, 121, 107, 1))),
//           centerTitle: true,
//           backgroundColor: Colors.teal.shade100,
//         ),
//         SizedBox(height: 20),
//         ListView.builder(
//           padding: EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
//           itemBuilder: (_, int index) => Post(),
//           itemCount: 10,
//           reverse: false,
//         ),
//         Positioned(
//           bottom: 16.0,
//           right: 16.0,
//           child: FloatingActionButton(
//             onPressed: () {
//               _overlayEntry = AddPostOverlayEntry(removeOverlayEntry).build();
//               Overlay.of(context)?.insert(_overlayEntry!);
//             },
//             child: Icon(Icons.edit_note_rounded),
//           ),
//         ),
//       ],
//     );
//   }

//   void removeOverlayEntry() {
//     if (_overlayEntry != null) {
//       _overlayEntry!.remove();
//       _overlayEntry = null;
//     }
//   }
// }

// class AddPostOverlayEntry {
//   final VoidCallback removeOverlayEntry;

//   AddPostOverlayEntry(this.removeOverlayEntry);

//   OverlayEntry build() {
//     return OverlayEntry(
//       builder: (context) => AddPost(removeOverlayEntry),
//     );
//   }
// }

// class AddPost extends StatelessWidget {
//   final VoidCallback onRemove;
//   AddPost(this.onRemove);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: 800,
//           maxHeight: 500,
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: Center(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 3,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             IconButton(
//                               onPressed: onRemove,
//                               icon: Icon(Icons.close),
//                             ),
//                           ],
//                         ),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.arrow_forward_ios_rounded),
//                             labelText: 'new post',
//                             hintText: "what's on your mind?",
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         SizedBox(height: 35),
//                         SizedBox(
//                           width: 200,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             child: Text('ADD'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
