import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_motivations/module/data_module/database_helper.dart';
import 'thoughts_event.dart';
import 'thoughts_state.dart';

class ThoughtsBloc extends Bloc<ThoughtsEvent, ThoughtsState> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  ThoughtsBloc() : super(ThoughtsLoading()) {
    on<FetchThoughts>(_onFetchThoughts);
    on<AddThought>(_onAddThought);
    on<DeleteThought>(_onDeleteThought);
  }

  Future<void> _onFetchThoughts(FetchThoughts event, Emitter<ThoughtsState> emit) async {
    try {
      final thoughts = await dbHelper.getThoughts();
      emit(ThoughtsLoaded(thoughts));
    } catch (e) {
      emit(ThoughtsError());
    }
  }

  Future<void> _onAddThought(AddThought event, Emitter<ThoughtsState> emit) async {
    try {
      await dbHelper.addThought(event.title, event.description, event.category, event.dateTime);
      add(FetchThoughts());
    } catch (e) {
      emit(ThoughtsError());
    }
  }

  Future<void> _onDeleteThought(DeleteThought event, Emitter<ThoughtsState> emit) async {
    try {
      await dbHelper.deleteThought(event.id);
      add(FetchThoughts());
    } catch (e) {
      emit(ThoughtsError());
    }
  }
}
