abstract class ThoughtsEvent {}

class AddThought extends ThoughtsEvent {
  final String title;
  final String description;
  final String category;
  final DateTime dateTime;
  AddThought({required this.title, required this.description, required this.category, required this.dateTime});
}

class FetchThoughts extends ThoughtsEvent {}

class DeleteThought extends ThoughtsEvent {
  final int id;
  DeleteThought(this.id);
}

class EditThought extends ThoughtsEvent {
  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime dateTime;

  EditThought({required this.id, required this.title, required this.description, required this.category, required this.dateTime});
}