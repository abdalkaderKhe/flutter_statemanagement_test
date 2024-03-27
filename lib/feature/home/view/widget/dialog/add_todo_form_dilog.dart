import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/extensions/context_extension.dart';
import 'package:state_management_test/feature/home/model/todo.dart';
import 'package:state_management_test/feature/home/view_model/state/hooks/custom_todo_hook.dart';
import '../../../../../core/ui/component/column/spacer_column.dart';
import '../../../../../core/ui/component/row/spacer_row.dart';
import '../../../../auth/view/widget/main_button.dart';
import '../../../view_model/state/provider/todo_provider.dart';
import '../priority_cards.dart';


final class AddTodoDialog {
  final BuildContext context;

  AddTodoDialog({required this.context});

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
            height: context.dynamicHeight(0.8),
            width: context.dynamicWidth(0.8),
            child: DialogForm(),
          ),
        );
      },
    );
  }
}

final class DialogForm extends ConsumerWidget {
  DialogForm({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref)
  {
    return HookBuilder(
      builder: (context) {

        var todo = ref.watch(fetchedTodoNotifierProvider);
        final homeStateNotifier = ref.read(homeStateNotifierProvider.notifier);

        final textController = useTextEditingController(text: todo.activity ?? '');
        final todoHook = useTodoHook<Todo>();
        final todosPriorityList = useState(['high','medium','low']);
        final selectedDate = useState(DateTime.now());

        return Form(
          key: formKey,
          child: Center(
            child: SpacerRow(
              spacerFlexValue: 1,
              bodyFlexValue: 10,
              child: SpacerColumn(
                spacerFlexValue: 1,
                bodyFlexValue: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [

                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: textController,
                        style: const TextStyle(fontSize: 12),
                        onChanged: (value)
                        {
                          todoHook.updateActive(textController.text,);
                        },
                        decoration: InputDecoration(
                          hintText: 'Todo Description',
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(width: 2.0, color: Colors.grey.shade300),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Todo description is required ";
                          }
                          return null;
                        },
                      ),
                    ),

                    Expanded(
                        flex: 2,
                        child: PriorityCardItems(
                          todosPriorityList: todosPriorityList.value,
                          onTap: (int index)
                          {
                            todoHook.updatePriority(todosPriorityList.value[index]);
                            todoHook.todo.deadline!.day.toString();
                            return todosPriorityList.value[index];
                          },
                        ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Deadline: ${todoHook.todo.deadline!.day} ${todoHook.todo.deadline!.month} ${todoHook.todo.deadline!.year}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            ElevatedButton(
                              onPressed: () async
                              {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate.value,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null && picked != selectedDate.value)
                                {
                                  selectedDate.value = picked;
                                  todoHook.updateDeadline(picked);
                                }
                              },
                              child: const Text('Select Deadline'),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),

                    //const Expanded(flex: 3, child: DateTimePicker(),),

                    const Expanded(
                      flex: 1,
                      child: SizedBox.shrink(),
                    ),

                    Expanded(
                      flex: 2,
                      child: TextField(
                        style: const TextStyle(fontSize: 12),
                        onChanged: (value) {
                          //todoNotifier.updateNote(value);
                          todoHook.updateNote(value);
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Note',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(width: 2.0, color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: MainButton(
                        title: 'AddTodo',
                        onTap: () async {
                          if (formKey.currentState!.validate() && todoHook.todo.priority != null)
                          {
                            formKey.currentState!.save();
                            todoHook.updateActive(textController.text);
                            await homeStateNotifier.addTodo(todoHook.todo);
                            ref.read(homeStateNotifierProvider.notifier).closeDialogsFlow();
                          }
                          else if (todoHook.todo.priority == null)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('specifying task priority is required '),));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

