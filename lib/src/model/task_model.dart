class Task {
  final int key;
  final String title;
  final bool isDone;
  final bool isPriority;
  final DateTime date;

  Task({
    required this.key,
    required this.title,
    required this.isDone,
    required this.isPriority,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'isDone': isDone,
        'isPriority': isPriority,
        'date': date.toIso8601String(),
      };

  factory Task.fromMap(int key, Map map) => Task(
        key: key,
        title: map['title'],
        isDone: map['isDone'],
        isPriority: map['isPriority'],
        date:
            map['date'] is DateTime ? map['date'] : DateTime.parse(map['date']),
      );
}
