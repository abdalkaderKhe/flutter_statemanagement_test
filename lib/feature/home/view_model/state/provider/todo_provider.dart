import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../core/network/api_result.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../../core/network/dio_factory.dart';
import '../../../model/todo.dart';
import '../../home_view_model.dart';
import '../model/hoem_state_model.dart';
import '../notifier/fetched_todo_notifier.dart';
import '../notifier/home_state_notifier.dart';

final fetchedTodoNotifierProvider = NotifierProvider<FetchedTodoNotifier, Todo>(() {
  return FetchedTodoNotifier();
});

final fetchTodoProvider = FutureProvider<ApiResult<Todo>>((ref) {
  final homeViewModel = ref.watch(homeViewModelProvider);
  return homeViewModel.getTodo(ref);
});

final homeViewModelProvider = Provider<HomeViewModel>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return HomeViewModel(apiService);
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(DioFactory.getDio());
});

final homeStateNotifierProvider = NotifierProvider<HomeStateNotifier, HomeStateModel>(() {
  return HomeStateNotifier();
});

final fetchLocalTodosProvider = FutureProvider<void>((ref) {
  final fetchedTodos = ref.read(homeStateNotifierProvider.notifier);
  return fetchedTodos.fetchLocalTodos();
});
