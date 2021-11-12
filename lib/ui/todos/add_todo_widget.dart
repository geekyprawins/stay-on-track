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
// 1
  final formKey = GlobalKey<FormState>();

// 2
  void addTodo() {
    // 3
    if (formKey.currentState!.validate()) {
      // 4
      formKey.currentState!.save();
      // 5
      return widget.onSubmitTap(todo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: formKey,
      child: Padding(
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
      ),
    );
  }

  ElevatedButton buildSubmitButton(TextTheme textTheme) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.primary)),
      onPressed: addTodo,
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
