import 'package:flutter/material.dart';
import '../models/question_post.dart';
import '../models/comment.dart';

class DetailPostPage extends StatefulWidget {
  final QuestionPost post;
  DetailPostPage({required this.post});

  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  int? _selectedOption;
  final _commentController = TextEditingController();
  bool hasVoted = false;

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    int totalVotes = post.votes.fold(0, (prev, element) => prev + element);

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.body, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text(
                'Poll:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // If the user hasn't voted yet, show the voting form.
              if (!hasVoted)
                Column(
                  children: [
                    ...List.generate(post.pollOptions.length, (index) {
                      return RadioListTile<int>(
                        title: Text(post.pollOptions[index]),
                        value: index,
                        groupValue: _selectedOption,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      );
                    }),
                    ElevatedButton(
                      onPressed: _selectedOption == null
                          ? null
                          : () {
                              setState(() {
                                // Record the vote and update the UI.
                                post.vote(_selectedOption!);
                                hasVoted = true;
                                _selectedOption = null;
                              });
                            },
                      child: const Text('Vote'),
                    ),
                  ],
                )
              // Once the vote is cast, show the poll results.
              else
                Column(
                  children: List.generate(post.pollOptions.length, (index) {
                    int optionVotes = post.votes[index];
                    double percentage =
                        totalVotes > 0 ? (optionVotes / totalVotes) * 100 : 0;
                    String percentageStr = percentage.toStringAsFixed(1);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${post.pollOptions[index]} - $optionVotes vote(s) - $percentageStr%',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                ),
              const SizedBox(height: 20),
              const Divider(),
              const Text(
                'Comments:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...post.comments.map(
                (comment) => ListTile(
                  title: Text(comment.content),
                  subtitle: Text(comment.timestamp.toString()),
                ),
              ),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Add a comment',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    setState(() {
                      post.addComment(
                          Comment(content: _commentController.text));
                      _commentController.clear();
                    });
                  }
                },
                child: const Text('Post Comment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
