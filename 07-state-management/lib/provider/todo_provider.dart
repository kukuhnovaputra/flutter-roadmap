// Level 7 - State Management: Provider (Todo List)
// Todo list dengan ChangeNotifier. List<Todo> disimpan di notifier;
// addTodo, toggleTodo, removeTodo memanggil notifyListeners() agar UI update.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/models.dart';

class TodoListNotifier extends ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    ));
    notifyListeners();
  }

  void toggleTodo(String id) {
    final i = _todos.indexWhere((t) => t.id == id);
    if (i >= 0) {
      _todos[i] = _todos[i].copyWith(isDone: !_todos[i].isDone);
      notifyListeners();
    }
  }

  void removeTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}

class TodoProviderScreen extends StatelessWidget {
  const TodoProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoListNotifier(),
      child: const _TodoProviderBody(),
    );
  }
}

class _TodoProviderBody extends StatelessWidget {
  const _TodoProviderBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Provider'),
      ),
      body: Column(
        children: [
          const _AddTodoField(),
          Expanded(
            child: Consumer<TodoListNotifier>(
              builder: (context, notifier, _) {
                if (notifier.todos.isEmpty) {
                  return const Center(
                    child: Text('Belum ada todo. Tambah di atas.'),
                  );
                }
                return ListView.builder(
                  itemCount: notifier.todos.length,
                  itemBuilder: (context, i) {
                    final todo = notifier.todos[i];
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
                            onPressed: () => notifier.toggleTodo(todo.id),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => notifier.removeTodo(todo.id),
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
    final notifier = context.read<TodoListNotifier>();
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
                notifier.addTodo(v);
                _controller.clear();
              },
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              notifier.addTodo(_controller.text);
              _controller.clear();
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}
