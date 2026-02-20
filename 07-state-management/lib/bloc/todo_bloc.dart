// Level 7 - State Management: Bloc/Cubit (Todo List)
// TodoCubit mengelola List<Todo>. State immutable; setiap perubahan emit(state baru).
// Cocok untuk aplikasi besar dengan alur event → state yang jelas.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/models.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    emit([
      ...state,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    ]);
  }

  void toggleTodo(String id) {
    emit([
      for (final t in state)
        t.id == id ? t.copyWith(isDone: !t.isDone) : t,
    ]);
  }

  void removeTodo(String id) {
    emit(state.where((t) => t.id != id).toList());
  }
}

class TodoBlocScreen extends StatelessWidget {
  const TodoBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: const _TodoBlocBody(),
    );
  }
}

class _TodoBlocBody extends StatelessWidget {
  const _TodoBlocBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Bloc/Cubit'),
      ),
      body: Column(
        children: [
          const _AddTodoField(),
          Expanded(
            child: BlocBuilder<TodoCubit, List<Todo>>(
              builder: (context, todos) {
                if (todos.isEmpty) {
                  return const Center(
                    child: Text('Belum ada todo. Tambah di atas.'),
                  );
                }
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, i) {
                    final todo = todos[i];
                    return ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              todo.isDone
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: todo.isDone ? Colors.green : null,
                            ),
                            onPressed: () =>
                                context.read<TodoCubit>().toggleTodo(todo.id),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () =>
                                context.read<TodoCubit>().removeTodo(todo.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AddTodoField extends StatefulWidget {
  const _AddTodoField();

  @override
  State<_AddTodoField> createState() => _AddTodoFieldState();
}

class _AddTodoFieldState extends State<_AddTodoField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodoCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Todo baru',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (v) {
                cubit.addTodo(v);
                _controller.clear();
              },
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              cubit.addTodo(_controller.text);
              _controller.clear();
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
