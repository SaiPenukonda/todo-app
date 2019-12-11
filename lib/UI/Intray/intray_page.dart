import 'package:flutter/material.dart';
import 'package:todoapp/bloc/blocs/user_bloc_provider.dart';
import 'package:todoapp/models/classes/task.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/models/widgets/intray_todo_widget.dart';

class IntrayPage extends StatefulWidget {
  final String apiKey;
  IntrayPage({this.apiKey});
  @override
  _IntrayPageState createState() => _IntrayPageState();
}

class _IntrayPageState extends State<IntrayPage> {
  List<Task> taskList = [];
  TaskBloc tasksBloc;

  @override
  void initState() {
    tasksBloc = TaskBloc(widget.apiKey);
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreyColor,
      child: StreamBuilder (
        stream: tasksBloc.getTasks,
        initialData: [],
          builder: (context, snapshot) {
            taskList = snapshot.data;
            return _buildReorderableListSimple(context, taskList);
          }
      )
      // child: ReorderableListView(
      //   padding: EdgeInsets.only(top: 190),
      //   children: taskList,
      //   onReorder: _onReorder,
    );
  }

  Widget _buildListTile(BuildContext context, Task item) {
    return ListTile(
      key: Key(item.taskId.toString()),
      title: IntrayTodo(
        title: item.title,
      ),
    );
  }

  Widget _buildReorderableListSimple(BuildContext context, List<Task> taskList) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent
      ),
      child: ReorderableListView(
        padding: EdgeInsets.only(top: 185.0),
        children: taskList.map((Task item) => _buildListTile(context, item)).toList(),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            Task item = taskList[oldIndex];
            taskList.remove(item);
            taskList.insert(newIndex, item);
          });
        },
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex){
        newIndex -= 1;
      }
      final Task item = taskList.removeAt(oldIndex);
      taskList.insert(newIndex, item);
    });
  }

  // Future<List<Task>> getList() async {
  //   List<Task> tasks = await tasksBloc.getTasks(widget.apiKey);
  //   return tasks;
  // }
}