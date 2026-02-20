// Level 7 - State Management: Common Models
// Model data yang dipakai ulang di semua pendekatan (setState, Provider, Riverpod, Bloc).

/// Model Todo untuk demo list (tambah, toggle selesai, hapus).
/// Hanya bentuk data; logic state ada di masing-masing pendekatan.
class Todo {
  final String id;
  final String title;
  final bool isDone;

  const Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  Todo copyWith({String? id, String? title, bool? isDone}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
