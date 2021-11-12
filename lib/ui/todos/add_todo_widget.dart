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

import 'package:flutter/material.dart';

import '../../models/todo_model.dart';
import '../../utils/datetime_utils.dart';
import '../app_colors.dart';

final _initialDueDate = DateTime.now();

class AddTodoWidget extends StatefulWidget {
  final void Function(TodoModel) onSubmitTap;

  const AddTodoWidget({Key? key, required this.onSubmitTap}) : super(key: key);

  @override
  _AddTodoWidgetState createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  TodoModel todo = TodoModel(dueDate: _initialDueDate);
  final dueDateController =
      TextEditingController(text: DateTimeUtils.formattedDate(_initialDueDate));

  //TODO: Adding GlobalKey for FormState

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildDueDateField(context),
          buildTodoField(),
          buildPriorityField(),
          const SizedBox(height: 25),
          buildSubmitButton(textTheme),
        ],
      ),
    );
  }

  ElevatedButton buildSubmitButton(TextTheme textTheme) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary)),
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Submit',
          style: textTheme.headline6!.copyWith(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  TextFormField buildPriorityField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Priority (0-5)'),
      validator: (value) {
        if (value == null || int.tryParse(value) == null) {
          return 'Please enter a number';
        } else if (int.parse(value) > 5 || int.parse(value) < 0) {
          return 'Please enter a number between 0 and 5';
        }
        return null;
      },
      onSaved: (value) {
        todo = todo.copyWith(priority: int.parse(value!));
      },
    );
  }

  TextFormField buildTodoField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Todo'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (value) {
        todo = todo.copyWith(text: value);
      },
    );
  }

  TextFormField buildDueDateField(BuildContext context) {
    return TextFormField(
      controller: dueDateController,
      decoration: const InputDecoration(labelText: 'Due Date'),
      onTap: () async {
        FocusScope.of(context).unfocus();
        final date = await selectDate(context);

        if (date != null && date != todo.dueDate) {
          todo = todo.copyWith(dueDate: date);
          dueDateController.text = DateTimeUtils.formattedDate(todo.dueDate);
        }
      },
    );
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    const hundredYears = Duration(days: 36500);
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(hundredYears),
    );
  }
}
