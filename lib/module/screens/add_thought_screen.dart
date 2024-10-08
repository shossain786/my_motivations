// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_event.dart';

class AddThoughtPage extends StatefulWidget {
  const AddThoughtPage({super.key});

  @override
  _AddThoughtPageState createState() => _AddThoughtPageState();
}

class _AddThoughtPageState extends State<AddThoughtPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = 'Akhlaq';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Thought')),
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
                context.read<ThoughtsBloc>().add(AddThought(
                      title: titleController.text,
                      description: descriptionController.text,
                      category: selectedCategory,
                      dateTime: DateTime.now(),
                    ));
                Navigator.pop(context);
              },
              child: const Text('Add Thought'),
            ),
          ],
        ),
      ),
    );
  }
}
