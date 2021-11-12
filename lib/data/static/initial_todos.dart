import '../../models/todo_model.dart';

List<TodoModel> getInitialTodoList() {
  return [
    TodoModel(
      text: 'Do Nothing',
      dueDate: DateTime.now(),
    ),
    TodoModel(
      text: 'Get back to 1985',
      dueDate: DateTime.now().add(const Duration(hours: 5)),
      priority: 5,
    ),
    TodoModel(
      text:
          '''Buy a parrot and teach him to say "help! I've been turned into a parrot!''',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: 4,
    ),
    TodoModel(
      text: '''Order Diet water whenever I go out to eat''',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: 4,
    ),
    TodoModel(
      text:
          '''Buy a turtle. Name it “The Speed of Light.” Tell everyone that I can run faster than The Speed of Light.''',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: 4,
    ),
    TodoModel(
      text:
          '''Hire two private investigators. Get them to follow each other.''',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      priority: 3,
    ),
    TodoModel(
      text: 'World Peace',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priority: 2,
    ),
    TodoModel(
      text: '''Become a teacher. Make a test where every answer is “C”.''',
      dueDate: DateTime.now().add(const Duration(days: 6)),
      priority: 1,
    ),
  ];
}
