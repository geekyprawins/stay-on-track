/*
 * Copyright (c) 2021 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for
 * pedagogical or instructional purposes related to programming, coding,
 * application development, or information technology.  Permission for such
 * use, copying, modification, merger, publication, distribution, sublicensing,
 * creation of derivative works, or sale is expressly withheld.
 *
 * This project and source code may use libraries or frameworks that are
 * released under various Open-Source licenses. Use of those libraries and
 * frameworks are governed by their own individual licenses.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
