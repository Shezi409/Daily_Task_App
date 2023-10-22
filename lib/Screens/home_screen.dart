import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_task/Provider/services_provider.dart';
import '../common/show_model.dart';
import '../widget/card_todo_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toData = ref.watch(fetchStreamProvider);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber.shade200,
            radius: 20,
            child: Image.asset("assets/bgpic.png"),
          ),
          title: Text(
            ' Hello I\'m',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          subtitle: const Text(
            'Jam Shahzad',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.calendar),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Today\'s Task',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Gap(2),
                      Text(
                        ' Friday, 11 Sept',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD5E8FA),
                        foregroundColor: Colors.blue.shade700,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        context: context,
                        builder: (context) => AddNewTaskModel()),
                    child: const Text('+ New Task'),
                  ),
                ],
              ),

              // Card List task here
              const Gap(20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: toData.value!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    CardTodoListWidget(getIndex: index),
              )
            ],
          ),
        ),
      ),
    );
  }
}
