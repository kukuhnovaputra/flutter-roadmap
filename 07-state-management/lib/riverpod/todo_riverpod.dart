// Level 7 - State Management: Riverpod (Todo List)
// StateNotifier<List<Todo>> + StateNotifierProvider. Logic di StateNotifier;
// UI pakai ConsumerWidget/ref.watch untuk rebuild saat state berubah.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/models.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(String title) {
    if (title.trim().isEmpty) return;
    state = [
      ...state,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final t in state)
        t.id == id ? t.copyWith(isDone: !t.isDone) : t,
    ];
  }

  void removeTodo(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) => TodoListNotifier());

class TodoRiverpodScreen extends ConsumerWidget {
  const TodoRiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List - Riverpod'),
      ),
      body: Column(
        children: [
          const _AddTodoField(),
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text('Belum ada todo. Tambah di atas.'))
                : ListView.builder(
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
                              onPressed: () => ref
                                  .read(todoListProvider.notifier)
                                  .toggleTodo(todo.id),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => ref
                                  .read(todoListProvider.notifier)
                                  .removeTodo(todo.id),
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

class _AddTodoField extends ConsumerStatefulWidget {
  const _AddTodoField();

  @override
  ConsumerState<_AddTodoField> createState() => _AddTodoFieldState();
}

class _AddTodoFieldState extends ConsumerState<_AddTodoField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(todoListProvider.notifier);
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
