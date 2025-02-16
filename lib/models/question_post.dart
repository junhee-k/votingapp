import 'comment.dart';

class QuestionPost {
  String title;
  String body;
  String category; // New field for category
  List<String> pollOptions;
  List<int> votes;
  List<Comment> comments;

  QuestionPost({
    required this.title,
    required this.body,
    required this.category, // Require category when creating a post
    required this.pollOptions,
  })  : votes = List.filled(pollOptions.length, 0),
        comments = [];

  void vote(int optionIndex) {
    votes[optionIndex]++;
  }

  void addComment(Comment comment) {
    comments.add(comment);
  }
}
