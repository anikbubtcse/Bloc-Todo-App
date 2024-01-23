import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc/todo_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(TodoEventApiCalling());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bloc Todo App'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<TodoBloc, TodoState>(builder: (context, todoState) {
                if (todoState is TodoInitial || todoState is TodoLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (todoState is TodoError) {
                  Center(child: Text(todoState.message));
                }

                {
                  if (todoState is TodoLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoState.todoModel.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(todoState.todoModel[index].title!),
                          trailing: Text(
                              todoState.todoModel[index].completed.toString()),
                        );
                      },
                    );
                  }

                  return Container();
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
