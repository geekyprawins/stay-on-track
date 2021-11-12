import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/todo_model.dart';

class TodosLocalDataSource {
  static const String _todosKey = 'todos';

  Future<bool> addTodo(TodoModel todo) async {
    final prefs = await SharedPreferences.getInstance();
    final todos = await fetchTodos(preferences: prefs);
    final index = todos.indexWhere((e) => e == todo);
    if (index > -1) {
      throw Exception('The todo already exists');
    }
    todos.add(todo);
    final encodedTodos = _getEncodedTodos(todos);
    return prefs.setStringList(_todosKey, encodedTodos);
  }

  Future<bool> editTodo(TodoModel todo) async {
    final prefs = await SharedPreferences.getInstance();
    final todos = await fetchTodos(preferences: prefs);
    final index = todos.indexWhere((e) => e == todo);
    if (index > -1) {
      todos.removeAt(index);
    }
    todos.add(todo);
    final encodedTodos = _getEncodedTodos(todos);
    return prefs.setStringList(_todosKey, encodedTodos);
  }

  Future<bool> saveTodoList(List<TodoModel> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    final todos = await fetchTodos(preferences: prefs);
    todos.addAll(todoList);
    final encodedTodos = _getEncodedTodos(todos);
    return prefs.setStringList(_todosKey, encodedTodos);
  }

  Future<bool> deleteTodo(TodoModel todo) async {
    final prefs = await SharedPreferences.getInstance();
    final todos = await fetchTodos(preferences: prefs);
    if (todos.isEmpty) return false;
    todos.remove(todo);
    final encodedTodos = _getEncodedTodos(todos);
    return prefs.setStringList(_todosKey, encodedTodos);
  }

  Future<List<TodoModel>> fetchTodos({SharedPreferences? preferences}) async {
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final todos = prefs.getStringList(_todosKey) ?? [];
    return _getTodoList(todos);
  }

  Future<bool> doesStoreExist() async {
    final prefs = await SharedPreferences.getInstance();
    final todos = prefs.getStringList(_todosKey);
    return todos != null;
  }

  List<TodoModel> _getTodoList(List<String> decodedJsonStringList) {
    if (decodedJsonStringList.isEmpty) return [];
    return decodedJsonStringList
        .map(jsonDecode)
        .map((e) => TodoModel.fromJson(e))
        .toList();
  }

  List<String> _getEncodedTodos(List<TodoModel> todoList) {
    return todoList.map((e) => e.toJson()).map(jsonEncode).toList();
  }
}
