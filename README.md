# todo_app

## Firestore integration
```jsx
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
```

- Simple Stateful Text Widget

    ```dart
    class TextInputWidget extends StatefulWidget {
      @override
      _TextInputWidgetState createState() => _TextInputWidgetState();
    }

    class _TextInputWidgetState extends State<TextInputWidget> {
      final controller = TextEditingController();
      String text = "";

      @override
      void dispose() {
        super.dispose();
        controller.dispose();
      }

      void changeText(text) {
        if (text == "Hello world") {
          controller.clear();
          text = "";
        }
        setState(() {
          this.text = text;
        });
      }

      @override
      Widget build(BuildContext context) {
        return Column(children: [
          TextField(
            controller: this.controller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.message), labelText: "Type a message"),
            onChanged: (text) => this.changeText(text),
          ),
          Text(this.text),
        ]);
      }
    ```

- More detailed Text input

    ```dart
    class Body extends StatefulWidget {
      @override
      _BodyState createState() => _BodyState();
    }

    class _BodyState extends State<Body> {
      String name;
      final controller = TextEditingController();

      void click() {
        this.name = this.controller.text;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyHomePage(this.name)));
      }

      @override
      Widget build(BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: this.controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(Icons.done),
                  splashColor: Colors.blue,
                  tooltip: 'Submit',
                  onPressed: this.click,
                ),
                labelText: 'Naav kaay tujha ?',
                hintText: 'Enter your name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black),
                ),
              ),
            ),
          ),
        );
      }
    }
    ```

## Navigation
```jsx
void click() {
    signInWithGoogle().then((user) => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyHomePage(user)))
        });
  }
```

