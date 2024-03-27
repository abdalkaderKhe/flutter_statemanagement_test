import 'package:flutter/cupertino.dart';

import '../../../model/todo.dart';


@immutable
final class HomeStateModel {
  final List<Todo> todos;
  final bool showVerifyDialog;
  final bool showTodoFormDialog;
  final bool showFetchDialog;
  final bool showErrorSnackBar;
  final bool closeDialogsFlow;
  final bool displayLoadingIndicator;
  final String? errorMsg;

  const HomeStateModel({
    this.todos = const [],
    this.showVerifyDialog = false,
    this.showTodoFormDialog = false,
    this.showFetchDialog = false,
    this.showErrorSnackBar = false,
    this.closeDialogsFlow = false,
    this.displayLoadingIndicator = false,
    this.errorMsg,
  });

  factory HomeStateModel.init() => const HomeStateModel();

  HomeStateModel copyWith({
    List<Todo>? todos,
    bool? showVerifyDialog,
    bool? showTodoFormDialog,
    bool? showFetchDialog,
    bool? showErrorSnackBar,
    bool? closeDialogsFlow,
    String? errorMsg,
    bool? displayLoadingIndicator,
  }) {
    return HomeStateModel(
      todos: todos ?? this.todos,
      showVerifyDialog: showVerifyDialog ?? this.showVerifyDialog,
      showTodoFormDialog: showTodoFormDialog ?? this.showTodoFormDialog,
      showFetchDialog: showFetchDialog ?? this.showFetchDialog,
      showErrorSnackBar: showErrorSnackBar ?? this.showErrorSnackBar,
      closeDialogsFlow: closeDialogsFlow ?? this.closeDialogsFlow,
      errorMsg: errorMsg ?? this.errorMsg,
      displayLoadingIndicator: displayLoadingIndicator ?? this.displayLoadingIndicator,
    );
  }
}
