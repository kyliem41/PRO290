import 'package:flutter/material.dart';
import 'package:frontend/features/screens/search/customAppBar.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/features/scripts/search.dart';
import 'package:frontend/features/scripts/get_user.dart';

class SearchResultsColumn extends StatefulWidget {
  @override
  _SearchResultsColumnState createState() => _SearchResultsColumnState();
}

class _SearchResultsColumnState extends State<SearchResultsColumn> {
  List<Users> results = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: customAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchBar(
              onSearch: _performSearch,
            ),
            SizedBox(height: 15),
            Expanded(
              child: isSearching
                  ? Center(child: CircularProgressIndicator())
                  : results.isNotEmpty
                      ? ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            return ResultCard(user: results[index]);
                          },
                        )
                      : Center(
                          child: Text('No results found'),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      isSearching = true;
    });
    Users? user = await getUser();
    if (user != null) {
        List<Users> searchResults = await search(query, user.username);
        setState(() {
          results = searchResults;
          isSearching = false;
        });
    }
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBar({required this.onSearch});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "search",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                widget.onSearch(_controller.text);
              },
              child: Text('Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final Users user;
  ResultCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Username: ${user.username}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Bio: ${user.bio}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Followers: ${user.followers.length}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Following: ${user.following.length}',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}