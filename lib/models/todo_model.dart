// class Todo {
//   final String id;
//   final String title;
//   final bool isComplete;
//
//   Todo({required this.id, required this.title, this.isComplete = false});
//
//   Todo copyWith({String? id, String? title, bool? isComplete}) {
//     return Todo(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       isComplete: isComplete ?? this.isComplete,
//     );
//   }
// }

class Todo {
  final String id;
  final String title;
  bool isComplete;

  Todo({
    required this.id,
    required this.title,
    this.isComplete = false,
  });

  // Define the copyWith method
  Todo copyWith({
    String? id,
    String? title,
    bool? isComplete,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
