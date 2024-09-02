import 'package:flutter/material.dart';
// import 'package:flutter_todo_app/constants/tasktype.dart';
import 'package:flutter_todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task});
  // final String title;
  // final Task task;
  final Todo task;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.completed! ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // widget.task.type == TaskType.note
            //     ? Image.asset("lib/assets/images/category1.png")
            //     : widget.task.type == TaskType.contest
            //         ? Image.asset("lib/assets/images/category2.png")
            //         : Image.asset("lib/assets/images/category3.png"),
            // const Icon(
            //   Icons.notes_outlined,
            //   size: 40,
            // ),
            Image.asset("lib/assets/images/category1.png"),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.todo!,
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                  Text(
                    widget.task.userId.toString(),
                    style: TextStyle(
                        decoration: widget.task.completed!
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: (val) => {
                setState(
                  () {
                    widget.task.completed = !widget.task.completed!;
                    isChecked = val!;
                  },
                )
              },
            )
          ],
        ),
      ),
    );
  }
}
