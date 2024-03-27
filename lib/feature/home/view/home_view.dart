import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import 'package:state_management_test/core/ui/component/row/spacer_row.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/add_todo_form_dilog.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/fetch_todo_dialgo.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/progress_indicator_dialog.dart';
import 'package:state_management_test/feature/home/view/widget/dialog/verify_dialog.dart';
import 'package:state_management_test/feature/home/view/widget/todo_card_item.dart';
import '../../../core/router/router.dart';
import '../../auth/view_model/state/provider/auth_providers.dart';
import '../view_model/state/model/hoem_state_model.dart';
import '../view_model/state/provider/todo_provider.dart';

class HomeView extends ConsumerWidget{
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref)
  {

    ref.listen<HomeStateModel>(homeStateNotifierProvider, (previous, current) {
      if (current.displayLoadingIndicator)
      {
        ProgressIndicatorDialog(context: context).show();
      }
      else if (current.showVerifyDialog)
      {
        context.pop();
        ref.watch(fetchTodoProvider);
        VerifyDialog(context: context,).show();
      }

      else if (current.showFetchDialog)
      {
        FetchTodoDialog(context: context,).show();
      }

      else if (current.showTodoFormDialog)
      {
        AddTodoDialog(context: context,).show();
      }
      else if (current.closeDialogsFlow)
      {
        ref.read(homeStateNotifierProvider.notifier).restart();
        context.pop();
      }
      else if (current.showErrorSnackBar)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(current.errorMsg!),));
      }
    });

    final homeStateNotifier = ref.watch(homeStateNotifierProvider.notifier);

    final homeState = ref.watch(homeStateNotifierProvider);

    return Scaffold(

      appBar: AppBar(title: const Text('Home Page'),),

      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            const SizedBox(height: 100,),

            InkWell(
              onTap: () async {
                await ref.read(authProvider.notifier).logOut();
                if(context.mounted)
                {
                  context.pushReplacementNamed(AppRoute.login.name);
                }
                //ref.read(routerNotifierProvider).pushLogin = true;
              },
              child: const Text('LogOut'),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed:(){ref.read(homeStateNotifierProvider.notifier).fetchTodo();},
        child: const Icon(Icons.add),),

      body: ref.watch(fetchLocalTodosProvider).when(
        data: (results) => SpacerRow(spacerFlexValue: 1, bodyFlexValue: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              const Text('Active Todos'),
              SizedBox(
                height: context.dynamicHeight(0.4),
                width: context.dynamicWidth(1),
                child: ListView.builder(
                  itemCount: homeState.todos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return !homeState.todos[index].isDone! ? SizedBox(
                      height: context.dynamicHeight(0.18),
                      child: TodoCardItem(todo: homeState.todos[index], onChanged: (value) async { await homeStateNotifier.toggle(index, value!);},),
                    ) : const SizedBox.shrink();
                  },
                ),
              ),

              const Text('Completed Todos'),
              SizedBox(
                height: context.dynamicHeight(0.4),
                width: context.dynamicWidth(1),
                child: ListView.builder(
                  itemCount: homeState.todos.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return homeState.todos[index].isDone! ? SizedBox(
                      height: context.dynamicHeight(0.18),
                      child: TodoCardItem(todo: homeState.todos[index], onChanged: (value) async { await homeStateNotifier.toggle(index, value!);},),
                    ) : const SizedBox.shrink();
                  },
                ),
              ),

            ],
          ),
        ),
        error: (err, stack) => Text('Error: $err'),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}




