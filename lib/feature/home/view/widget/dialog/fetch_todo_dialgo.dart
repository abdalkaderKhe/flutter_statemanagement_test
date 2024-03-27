import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import 'package:state_management_test/feature/home/view_model/state/provider/todo_provider.dart';
import '../../../../../core/ui/component/column/spacer_column.dart';
import '../../../../../core/ui/component/row/spacer_row.dart';
import '../../../../auth/view/widget/main_button.dart';

final class FetchTodoDialog {
  final BuildContext context;

  FetchTodoDialog({
    required this.context,
  });

  void show() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: context.dynamicHeight(0.3),
            width: context.dynamicWidth(0.6),
            child: Center(
              child: SpacerRow(
                spacerFlexValue: 2,
                bodyFlexValue: 10,
                child: SpacerColumn(
                  spacerFlexValue: 2,
                  bodyFlexValue: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      context.expandedSpace,
                      const Expanded(
                        flex: 5,
                        child: Text('fetch another activity'),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return Expanded(
                                  flex: 2,
                                  child: MainButton(
                                    title: 'ok',
                                    onTap: () async {
                                      final result = await ref
                                          .read(fetchTodoProvider.future);
                                      result.when(success: (value) {
                                        context.pop();
                                        ref
                                            .read(homeStateNotifierProvider
                                                .notifier)
                                            .displayVerifyDialog();
                                      }, failure: (value) {
                                        context.pop();
                                        ref
                                            .read(homeStateNotifierProvider
                                                .notifier)
                                            .displayErrorSnackBar(value);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            context.expandedSpace,
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return Expanded(
                                  flex: 2,
                                  child: MainButton(
                                    title: 'cancel',
                                    onTap: () {
                                      ref
                                          .read(homeStateNotifierProvider
                                              .notifier)
                                          .closeDialogsFlow();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
