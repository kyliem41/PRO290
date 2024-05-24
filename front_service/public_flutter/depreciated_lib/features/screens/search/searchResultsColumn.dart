import 'package:flutter/material.dart';
import 'customAppBar.dart';
import '../../../models/resultMessageModel.dart';

class SearchResultsColumn extends StatefulWidget {
  @override
  _SearchResultsColumnState createState() => _SearchResultsColumnState();
}

class _SearchResultsColumnState extends State<SearchResultsColumn> {
  List<ResultMessage> results = [
    ResultMessage(resultContent: "Hello, Will"),
    ResultMessage(resultContent: "How have you been?"),
    ResultMessage(resultContent: "Hey Kriss, I am doing fine dude. wbu?"),
    ResultMessage(resultContent: "ehhhh, doing OK."),
    ResultMessage(resultContent: "Is there any thing wrong?"),
    ResultMessage(resultContent: "Hello, Will"),
    ResultMessage(resultContent: "How have you been?"),
    ResultMessage(resultContent: "Hey Kriss, I am doing fine dude. wbu?"),
    ResultMessage(resultContent: "ehhhh, doing OK."),
    ResultMessage(resultContent: "Is there any thing wrong?"),
    ResultMessage(resultContent: "Hello, Will"),
    ResultMessage(resultContent: "How have you been?"),
    ResultMessage(resultContent: "Hey Kriss, I am doing fine dude. wbu?"),
    ResultMessage(resultContent: "ehhhh, doing OK."),
    ResultMessage(resultContent: "Is there any thing wrong?"),
  ];

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
            SearchBar(),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: results.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ResultCard(result: results[index]);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: TextField(
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
                borderSide: BorderSide(color: Colors.grey.shade100)),
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final ResultMessage result;
  ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          result.resultContent,
          style: TextStyle(fontSize: 15, color: Colors.black),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
