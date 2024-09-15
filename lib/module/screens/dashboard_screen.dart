import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_event.dart';
import 'package:my_motivations/module/bloc/thoughts_state.dart';
import 'package:my_motivations/module/screens/add_thought_screen.dart';
import 'package:my_motivations/module/screens/edit_thought.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thoughts Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddThoughtPage(),
                )),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<ThoughtsBloc, ThoughtsState>(
        builder: (context, state) {
          if (state is ThoughtsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ThoughtsLoaded) {
            final thoughts = state.thoughts;

            if (thoughts.isEmpty) {
              return const Center(child: Text('No thoughts added yet.'));
            }

            return ListView.builder(
              itemCount: thoughts.length,
              itemBuilder: (context, index) {
                final thought = thoughts[index];

                return ListTile(
                  title: Text(thought['title']),
                  subtitle: Text(thought['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditThoughtPage(
                                id: thought['id'],
                                title: thought['title'],
                                description: thought['description'],
                                category: thought['category'],
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<ThoughtsBloc>()
                              .add(DeleteThought(thought['id']));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ThoughtsError) {
            return const Center(child: Text('Failed to load thoughts.'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
