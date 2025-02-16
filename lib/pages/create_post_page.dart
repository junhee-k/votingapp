import 'package:flutter/material.dart';
import '../models/question_post.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String body = '';
  // New: category selection with a default value.
  String selectedCategory = 'General';
  final List<String> categories = [
    'General',
    'Science',
    'Technology',
    'Sports',
    'Entertainment'
  ];

  List<TextEditingController> _optionControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize with two options by default.
    _optionControllers.add(TextEditingController());
    _optionControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    // Dispose all controllers to avoid memory leaks.
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int index) {
    if (_optionControllers.length > 1) {
      setState(() {
        _optionControllers[index].dispose();
        _optionControllers.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least one option is required.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title input
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    title = value!;
                  },
                ),
                // Body input
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Body'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the body text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    body = value!;
                  },
                ),
                const SizedBox(height: 20),
                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category'),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Poll Options:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // List of poll option fields
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _optionControllers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Expanded text field for poll option
                        Expanded(
                          child: TextFormField(
                            controller: _optionControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Option ${index + 1}',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter an option';
                              }
                              return null;
                            },
                          ),
                        ),
                        // Delete button to remove an option
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeOption(index),
                        ),
                      ],
                    );
                  },
                ),
                // Button to add a new poll option
                TextButton.icon(
                  onPressed: _addOption,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Option'),
                ),
                const SizedBox(height: 20),
                // Button to submit the new post
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Collect the poll options from the controllers.
                      final pollOptions = _optionControllers
                          .map((controller) => controller.text.trim())
                          .where((text) => text.isNotEmpty)
                          .toList();

                      if (pollOptions.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please add at least one poll option.'),
                          ),
                        );
                        return;
                      }
                      // Create a new post including the selected category.
                      final post = QuestionPost(
                        title: title,
                        body: body,
                        category: selectedCategory,
                        pollOptions: pollOptions,
                      );
                      Navigator.pop(context, post);
                    }
                  },
                  child: const Text('Create Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
