// Level 7 - State Management: setState (Todo List)
// Todo list dengan state lokal. Tambah item, toggle selesai, hapus.
// Jika logic makin kompleks atau banyak layar butuh data yang sama, pertimbangkan Provider/Riverpod/Bloc.

import 'package:flutter/material.dart';

import '../common/models.dart';

/// Demo todo list dengan setState.
/// List todo disimpan di State; setiap perubahan memanggil setState agar UI update.
class TodoSetStateScreen extends StatefulWidget {
  const TodoSetStateScreen({super.key});

  @override
  State<TodoSetStateScreen> createState() => _TodoSetStateScreenState();
}

class _TodoSetStateScreenState extends State<TodoSetStateScreen> {
  final List<Todo> _todos = [];
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodo() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    setState(() {
      _todos.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ));
      _controller.clear();
    });
  }

  void _toggleTodo(String id) {
    setState(() {
      final i = _todos.indexWhere((t) => t.id == id);
      if (i >= 0) {
        _todos[i] = _todos[i].copyWith(isDone: !_todos[i].isDone);
      }
    });
  }

  void _removeTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - setState'),
      ),
      body: Column(
        children: [
          Padding(
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
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, i) {
                final todo = _todos[i];
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
                          todo.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                          color: todo.isDone ? Colors.green : null,
                        ),
                        onPressed: () => _toggleTodo(todo.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _removeTodo(todo.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
