import 'package:flutter/material.dart';
import 'package:todo_native/models/todo.dart';
import 'package:todo_native/widgets/update_todo_dialog.dart';
import 'package:implicitly_animated_reorderable_list_2/implicitly_animated_reorderable_list_2.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final Function(bool? val) onToggle;
  final Function(String newTitle) onUpdate;
  final Function() onDelete;
  const TodoItem({
    super.key,
    required this.onToggle,
    required this.onUpdate,
    required this.onDelete,
    required this.todo,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Handle(
      delay: const Duration(milliseconds: 100),
      vibrate: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: widget.todo.isDone ? Colors.grey[200] : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
          child: ListTile(
            leading: Checkbox(
              shape: const CircleBorder(),
              value: widget.todo.isDone,
              onChanged: widget.onToggle,
            ),
            title: Text(
              widget.todo.title,
              style: TextStyle(
                color: widget.todo.isDone ? Colors.grey : Colors.black,
              ),
            ),
            onTap: () async {
              await showDialog(
                context: context,
                builder:
                    (context) => UpdateTodoDialog(
                      onDelete: widget.onDelete,
                      onUpdate: widget.onUpdate,
                      initialValue: widget.todo.title,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}
