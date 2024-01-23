part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class TodoEventApiCalling extends TodoEvent {
  const TodoEventApiCalling();

  @override
  List<Object?> get props => [];
}
