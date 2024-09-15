import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/global/cubit/theme_cubit.dart';
import 'package:my_motivations/module/bloc/thoughts_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_event.dart';
import 'package:my_motivations/module/bloc/thoughts_state.dart';
import 'package:my_motivations/module/screens/add_thought_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thoughts Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          )
        ],
      ),
      body: BlocBuilder<ThoughtsBloc, ThoughtsState>(
        builder: (context, state) {
          if (state is ThoughtsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ThoughtsLoaded) {
            if (state.thoughts.isEmpty) {
              return const Center(child: Text('No thoughts added yet.'));
            }
            return ListView.builder(
              itemCount: state.thoughts.length,
              itemBuilder: (context, index) {
                final thought = state.thoughts[index];
                return ListTile(
                  title: Text(thought['title']),
                  subtitle: Text(thought['description']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<ThoughtsBloc>()
                          .add(DeleteThought(thought['id']));
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Error loading thoughts.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddThoughtPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
