import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import '../../../../../core/ui/component/column/spacer_column.dart';
import '../../../../../core/ui/component/row/spacer_row.dart';
import '../../../../auth/view/widget/main_button.dart';
import '../../../view_model/state/provider/todo_provider.dart';

final class VerifyDialog {
  final BuildContext context;

  VerifyDialog({required this.context});

  void show() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: context.dynamicHeight(0.5),
            width: context.dynamicWidth(0.6),
            child: Center(
              child: SpacerRow(
                spacerFlexValue: 1,
                bodyFlexValue: 12,
                child: SpacerColumn(
                  spacerFlexValue: 2,
                  bodyFlexValue: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      context.expandedSpace,
                      Expanded(
                          flex: 2,
                          child: Consumer(
                            builder: (BuildContext context, WidgetRef ref,
                                Widget? child) {
                              var todo = ref.watch(fetchedTodoNotifierProvider);
                              return Text(
                                  'The activity ${todo.activity} was fetched successfully');
                            },
                          )),
                      const Expanded(flex: 2, child: SizedBox.shrink()),
                      Expanded(
                        flex: 4,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: MainButton(
                                    title: 'accept',
                                    onTap: () {
                                      context.pop();
                                      ref
                                          .read(homeStateNotifierProvider
                                              .notifier)
                                          .displayTodoFormDialog();
                                    },
                                  ),
                                ),
                                context.expandedSpace,
                                Expanded(
                                  flex: 2,
                                  child: MainButton(
                                    title: 'reject',
                                    onTap: () {
                                      context.pop();
                                      ;
                                      ref
                                          .read(homeStateNotifierProvider
                                              .notifier)
                                          .displayFetchDialog();
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
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
