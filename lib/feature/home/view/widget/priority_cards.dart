import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PriorityCardItems extends HookWidget {
  const PriorityCardItems({
    super.key,
    required this.todosPriorityList,
    required this.onTap,
  });

  final List<String> todosPriorityList;
  final String Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final selectedItem = useState<String>('');

    return ListView.builder(
      shrinkWrap: true,
      itemCount: todosPriorityList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return PriorityCardItem(
          onTap: () {
            selectedItem.value = onTap(index);
          },
          title: todosPriorityList[index],
          isSelected: selectedItem.value == onTap(index),
        );
      },
    );
  }
}

class PriorityCardItem extends StatelessWidget {
  const PriorityCardItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.isSelected,
  });

  final void Function()? onTap;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        child: Card(
          color: isSelected ? Colors.blue : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}







