import 'package:flutter/material.dart';
import '../../model/todo.dart';

class TodoCardItem extends StatelessWidget
{
  const TodoCardItem({super.key,required this.todo,required this.onChanged});
  final Todo todo;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              const SizedBox.shrink(),
              Text(todo.activity!),
              Checkbox(value: todo.isDone,onChanged: onChanged),
            ],
          ),
          Text(todo.deadline.toString()),
          Text(todo.priority!),
          todo.note != null  ? Text(todo.note!) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
