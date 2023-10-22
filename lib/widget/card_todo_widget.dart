import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_task/Provider/services_provider.dart';
import 'package:flutter/cupertino.dart';

class CardTodoListWidget extends ConsumerWidget {
  const CardTodoListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;
        final getCategory = todoData[getIndex].category;

        switch (getCategory) {
          case 'Learning':
            categoryColor = Colors.green;
            break;

          case 'Working':
            categoryColor = Colors.blue.shade700;
            break;

          case 'General':
            categoryColor = Colors.amber.shade700;
            break;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                width: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: IconButton(
                        icon: const Icon(CupertinoIcons.delete),
                        onPressed: () => ref
                            .read(servicesProvider)
                            .deleteTask(todoData[getIndex].docId),
                      ),
                      title: Text(
                        todoData[getIndex].titleTask,
                        maxLines: 1,
                        style: TextStyle(
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      subtitle: Text(
                        todoData[getIndex].description,
                        maxLines: 1,
                        style: TextStyle(
                            decoration: todoData[getIndex].isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      trailing: Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          activeColor: Colors.blue.shade800,
                          shape: const CircleBorder(),
                          value: todoData[getIndex].isDone,
                          onChanged: (value) => ref
                              .read(servicesProvider)
                              .updateTask(todoData[getIndex].docId, value),
                        ),
                      ),
                    ),
                    const Gap(6),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 1,
                              color: Colors.grey.shade200,
                            ),
                            Row(
                              children: [
                                const Text('Today'),
                                const Gap(12),
                                Text(todoData[getIndex].timeTask)
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text(stackTrace.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
