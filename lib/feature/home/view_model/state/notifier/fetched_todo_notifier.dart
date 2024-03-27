import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../model/todo.dart';

final class FetchedTodoNotifier extends Notifier<Todo> {

  void update(Todo todo)
  {
    state = todo;
  }

  @override
  Todo build() {
    return Todo.initial();
  }

}
