import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/database.dart';
import 'package:to_do_list/dialog_box.dart';
import 'package:to_do_list/todo_tile.dart';
class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  ToDoDataBase db=ToDoDataBase();
  //reference the hive box
  final _myBox=Hive.box("mybox");
  @override
  void initState() {
    // if this is the first time ever opening the app,then create default data
    if(_myBox.get("TODOLIST")==null){
    db.createInitialData();
    }else{
      // there already exists data
      db.loadData();
    }
    super.initState();
  }
  //text controller
  final _controller=TextEditingController();
  //checkbox was tapped
  void checkBoxChanged(bool? value,int index){
   setState(() {
     db.toDoList[index][1] = ! db.toDoList[index][1];
   });
   db.updateDataBase();
  }
  // save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //create a new task
  void createNewTask(){
    showDialog(context: context, builder:(context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=>Navigator.of(context).pop(),
      );
    });
  }
  //delete task
  void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[200],
      appBar: AppBar(
        title: const Center(child: Text("TO DO")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder:(context,index){
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged:(value)=>checkBoxChanged(value,index),
              deleteFunction:(context) =>deleteTask(index),
          );
        }
      ),
    );
  }
}
