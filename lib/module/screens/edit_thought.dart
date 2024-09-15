// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_event.dart';

class EditThoughtPage extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String category;

  const EditThoughtPage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });

  @override
  _EditThoughtPageState createState() => _EditThoughtPageState();
}

class _EditThoughtPageState extends State<EditThoughtPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
    selectedCategory = widget.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Thought')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              items: ['Akhlaq', 'Life Lesson', 'Study', 'Work', 'Others']
                  .map((String category) {
                return DropdownMenuItem<String>(
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
            ElevatedButton(
              onPressed: () {
                context.read<ThoughtsBloc>().add(
                      EditThought(
                        id: widget.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        category: selectedCategory,
                        dateTime: DateTime.now(),
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
