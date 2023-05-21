import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?deleteFunction;
  ToDoTile({super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0,left: 25.0,right: 25.0,bottom: 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
                onPressed:deleteFunction,
               icon: Icons.delete,
              backgroundColor: Colors.white54,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged:onChanged,shape: CircleBorder(),activeColor: Colors.white,),
                Text(taskName,
                style: TextStyle(
                  decoration: taskCompleted ? TextDecoration.lineThrough:TextDecoration.none,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(12)
          ),

        ),
      ),
    );
  }
}
