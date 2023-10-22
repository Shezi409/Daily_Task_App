import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_task/Model/todo_model.dart';

class TodoServices {
  final todoCollection = FirebaseFirestore.instance.collection('todoTask');

  // Create Task Data Post     CURD Operation

  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //  Update Data
  void updateTask(String? docId, bool? valueUpdate) {
    todoCollection.doc(docId).update({
      'isDone': valueUpdate,
    });
  }

  // Delete Data
  void deleteTask(String? docId) {
    todoCollection.doc(docId).delete();
  }
}
