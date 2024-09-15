abstract class ThoughtsState {}

class ThoughtsLoading extends ThoughtsState {}

class ThoughtsLoaded extends ThoughtsState {
  final List<Map<String, dynamic>> thoughts;
  ThoughtsLoaded(this.thoughts);
}

class ThoughtsError extends ThoughtsState {}
