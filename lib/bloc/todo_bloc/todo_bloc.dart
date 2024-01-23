import 'dart:async';
import 'dart:convert';

import 'package:bloc_todo_app/services/todo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';
import 'package:http/http.dart' as http;

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService myTodoService;

  TodoBloc(this.myTodoService) : super(TodoInitial()) {
    on<TodoEventApiCalling>(_onTodoEventApiCalling);
  }

  _onTodoEventApiCalling(
      TodoEventApiCalling event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    http.Response data = await myTodoService.todoService();
    try {
      if (data.statusCode == 200) {
        final todoModel = List<TodoModel>.from(
            json.decode(data.body).map((x) => TodoModel.fromJson(x)));

        emit(TodoLoaded(todoModel: todoModel));
      } else {
        emit(const TodoError("Something went wrong"));
      }
    } catch (e) {
      emit(const TodoError("Something went wrong"));
    }
  }
}
