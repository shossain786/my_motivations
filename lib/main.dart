import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/global/cubit/theme_cubit.dart';
import 'package:my_motivations/module/bloc/thoughts_bloc.dart';
import 'package:my_motivations/module/bloc/thoughts_event.dart';
import 'package:my_motivations/module/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThoughtsBloc>(
            create: (_) => ThoughtsBloc()..add(FetchThoughts())),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: const DashboardPage(),
          );
        },
      ),
    );
  }
}
