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
