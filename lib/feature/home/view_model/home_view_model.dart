import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/network/api_service.dart';
import 'package:state_management_test/feature/home/view_model/state/provider/todo_provider.dart';
import '../../../core/cache/locale_manager.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/network/api_result.dart';
import '../model/todo.dart';

final class HomeViewModel {
  final ApiService _apiService;

  TodosCacheManager todosCacheManager = TodosCacheManager();

  HomeViewModel(this._apiService);

  Future<ApiResult<Todo>> getTodo(Ref ref) async {
    try {
      final response = await _apiService.fetchTodo();
      final todo = ref.read(fetchedTodoNotifierProvider.notifier);
      todo.update(response);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<void> saveTodo(Todo todo) async {
    await todosCacheManager.addTodo(todo);
  }

  Future<List<Todo>> fetchLocalTodos() async {
    final response = await todosCacheManager.getTodosList();
    return response;
  }

  Future<void> updateTodoStatus(
      int index, bool value, List<Todo> todosList) async {
    todosList[index] = todosList[index].copyWith(isDone: value);
    await todosCacheManager.toggleTodoStatus(index);
  }
}

final class TodosCacheManager {
  Future<List<Todo>> getTodosList() async {
    final String todosListValue =
        LocaleManager.instance.getStringValue(PreferencesKeys.USER_TODOS);
    if (todosListValue.isEmpty) {
      return [];
    } else {
      final List<dynamic> decoded = jsonDecode(todosListValue);
      decoded.map((e) => Todo.fromJson(e)).toList();
      return decoded.map((e) => Todo.fromJson(e)).toList();
    }
  }

  Future<void> saveTodoList(List<Todo> todoList) async {
    final String encoded = jsonEncode(todoList);
    await LocaleManager.instance
        .setStringValue(PreferencesKeys.USER_TODOS, encoded);
  }

  Future<void> addTodo(Todo todo) async {
    List<Todo> todoList = await getTodosList();
    todoList.add(todo);
    await saveTodoList(todoList);
  }

  Future<void> toggleTodoStatus(int index) async {
    List<Todo> todoList = await getTodosList();
    todoList[index] = todoList[index].copyWith(isDone: !todoList[index].isDone!);
    await saveTodoList(todoList);
  }
}
