import '../../models/todo_model.dart';
import '../data_sources/todos_local_data_source.dart';
import '../static/initial_todos.dart';

class TodosRepository {
  const TodosRepository({
    required this.localDataSource,
  });
  final TodosLocalDataSource localDataSource;

  Future<bool> addTodo(TodoModel todo) async {
    return localDataSource.addTodo(todo);
  }

  Future<bool> editTodo(TodoModel todo) async {
    return localDataSource.editTodo(todo);
  }

  Future<bool> deleteTodo(TodoModel todo) async {
    return localDataSource.deleteTodo(todo);
  }

  Future<List<TodoModel>> fetchTodos() async {
    await _initialize();
    return localDataSource.fetchTodos();
  }

  Future<bool> _initialize() async {
    final doesStoreExist = await localDataSource.doesStoreExist();
    if (!doesStoreExist) {
      return localDataSource.saveTodoList(getInitialTodoList());
    }
    return false;
  }
}
