import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/widgets.dart';
import 'package:state_management_test/feature/home/model/todo.dart';

_SetHookState<T> useTodoHook<T>() {
  return use(_SetHook<T>());
}


class _SetHook<T> extends Hook<_SetHookState<T>> {
  const _SetHook();

  @override
  _SetHookState<T> createState() => _SetHookState<T>();
}

class _SetHookState<T> extends HookState<_SetHookState<T>, _SetHook<T>> {
  late Todo todo;

  @override
  void initHook() {
    super.initHook();
    todo = Todo.initial();
  }

  void updateActive(String value)
  {
    todo = todo.copyWith(activity: value);
  }

  void updateNote(String value)
  {
    todo = todo.copyWith(note: value);
  }

  void updatePriority(String value)
  {
    todo = todo.copyWith(priority: value);
  }

  void updateDeadline(DateTime value)
  {
    todo = todo.copyWith(deadline: value);
  }

  @override
  _SetHookState<T> build(BuildContext context) => this;
}

