import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../model/todo.dart';
import '../model/hoem_state_model.dart';
import '../provider/todo_provider.dart';

final class HomeStateNotifier extends Notifier<HomeStateModel> {

  Future<void> fetchTodo() async {
    displayLoadingIndicator();
    final result = await ref.refresh(fetchTodoProvider.future);
    result.when(success: (value) {displayVerifyDialog();},
    failure: (value) {displayErrorSnackBar(value);});
  }

  Future<void> fetchLocalTodos() async {
    List<Todo> todos = [];
    final homeViewMode = ref.read(homeViewModelProvider);
    todos = await homeViewMode.fetchLocalTodos();
    state = state.copyWith(todos: todos);
  }

  Future<void> toggle(
    int index,
    bool value,
  ) async {
    final homeViewMode = ref.read(homeViewModelProvider);
    await homeViewMode.updateTodoStatus(index, value, state.todos);
    await fetchLocalTodos();
  }

  Future<void> addTodo(Todo todo) async {
    final homeViewMode = ref.watch(homeViewModelProvider);
    await homeViewMode.saveTodo(todo);
    await fetchLocalTodos();
    closeDialogsFlow();
  }

  void restart() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
      closeDialogsFlow: false,
      displayLoadingIndicator:false,
    );
  }

  void displayLoadingIndicator() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
      displayLoadingIndicator: true,
    );
  }

  void displayVerifyDialog() {
    state = state.copyWith(
      showVerifyDialog: true,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
      displayLoadingIndicator:false,
    );
  }

  void displayFetchDialog() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: true,
      showErrorSnackBar: false,
      closeDialogsFlow: false,
      displayLoadingIndicator:false,
    );
  }

  void displayTodoFormDialog() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: true,
      showFetchDialog: false,
      showErrorSnackBar: false,
      closeDialogsFlow: false,
      displayLoadingIndicator:false,
    );
  }

  void displayErrorSnackBar(String value) {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: true,
      closeDialogsFlow: false,
      displayLoadingIndicator:false,
      errorMsg: value,
    );
  }

  void closeDialogsFlow() {
    state = state.copyWith(
      showVerifyDialog: false,
      showTodoFormDialog: false,
      showFetchDialog: false,
      showErrorSnackBar: false,
      displayLoadingIndicator:false,
      closeDialogsFlow: true,
    );
  }

  @override
  HomeStateModel build() {
    return HomeStateModel.init();
  }
}
