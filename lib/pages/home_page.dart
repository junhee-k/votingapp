import 'package:flutter/material.dart';
import 'detail_post_page.dart';
import 'create_post_page.dart';
import '../models/question_post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuestionPost> posts = [];
  // Default selected category is "All"
  String selectedCategory = 'All';

  // List of available categories with "All" as an option
  final List<String> categories = [
    'All',
    'General',
    'Science',
    'Technology',
    'Sports',
    'Entertainment'
  ];

  @override
  Widget build(BuildContext context) {
    // Filter posts based on the selected category; if "All", show every post.
    final filteredPosts = selectedCategory == 'All'
        ? posts
        : posts.where((post) => post.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting App'),
      ),
      body: Column(
        children: [
          // Dropdown button to filter posts by category
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          // Expanded ListView to show the filtered posts
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text('${post.category} - ${post.body}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPostPage(post: post),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // FloatingActionButton to create a new post
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
          if (newPost != null && newPost is QuestionPost) {
            setState(() {
              posts.add(newPost);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
