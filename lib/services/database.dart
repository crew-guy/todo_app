import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';

class Database {
  final FirebaseFirestore firestore;

  Database({this.firestore});

  Stream<List<TodoModel>> streamTodos({String uid}){
    try{
      return firestore
        .collection("todos")
        .doc(uid)
        .collection("todos")
        .where("done",isEqualTo:false)
        .snapshots()
        .map((query) => {
          final List<TodoModel> retVal = <TodoModel>[];
          for(final DocumentSnapshot doc in query.docs){
            retVal.add(TodoModel.fromDocumentSnapshot(documentSnapshot:doc))
          }
          return retVal;
        });
    }catch (e){
      rethrow;
    }
  }

  Future<void> addTodo({String uid, String content}) async{
    try{
      firestore.collection("todos").doc(uid).collection("todos").add({
        "content":content,
        "done":false
      });
    }catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo({String uid, String todoId}){
    try{
      firestore
        .collection('todos')
        .doc(uid)
        .collection('todos')
        .doc(todoId)
        .update({
          done:true
        })
    }catch (e) {
      rethrow;
    }
  }
}

//! For using locally stored data in app instead of a managed database like Firestore
// class Database{
//   Future<TodoModel> loadDatabase() async{
//     try{
//       Future.delayed(Duration(seconds:3));
//       print("this got called ?!");
//       return TodoModel("From Database", true)
//     }catch (e){
//       print(e);
//       rethrow;
//     }
//   }
// }