import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Model/todo_model.dart';
import '../Services/todo_services.dart';

final servicesProvider = StateProvider<TodoServices>((ref) {
  return TodoServices();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todoTask')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
