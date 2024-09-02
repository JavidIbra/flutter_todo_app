import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/color.dart';
import 'package:flutter_todo_app/constants/tasktype.dart';
import 'package:flutter_todo_app/model/task.dart';
import 'package:flutter_todo_app/screens/add_new_task.dart';
import 'package:flutter_todo_app/services/todo_service.dart';
import 'package:flutter_todo_app/todoitem.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todoList = ["Study Lesson", "Run 5k", "Go To Party"];
  //List<String> completedTodoList = ["Game meetup", "trash move out"];

  List<Task> todoList = [
    Task(
      type: TaskType.note,
      title: "Study Lesson",
      description: "test",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calendar,
      title: "Run 5k",
      description: "set",
      isCompleted: false,
    ),
    Task(
      type: TaskType.contest,
      title: "Go To Party",
      description: "attend at the party",
      isCompleted: false,
    )
  ];

  List<Task> completedTodoList = [
    Task(
      type: TaskType.note,
      title: "Game meetUp",
      description: "1:00pm",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calendar,
      title: "Run 5k",
      description: "salam",
      isCompleted: false,
    ),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todoList.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundColor),
        body: Column(
          children: [
            //Header
            Container(
              width: deviceWidth,
              height: deviceHeight / 3,
              decoration: const BoxDecoration(
                  color: Colors.pink,
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/header.png"),
                    fit: BoxFit.cover,
                  )),
              // child: const Column(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.only(top: 20),
              //       child: Text(
              //         "23.03.2024",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.only(top: 40),
              //       child: Text(
              //         "Todo App",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 30,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
            ),
            //Top column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: FutureBuilder(
                  future: todoService.getUncompletedTodos(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TodoItem(task: snapshot.data![index]);
                        },
                      );
                    }
                  },
                )),
              ),
            ),
            //Completed text
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Completed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            //bottom column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: FutureBuilder(
                  future: todoService.getCompletedTodos(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return TodoItem(task: snapshot.data![index]);
                        },
                      );
                    }
                  },
                )),
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNewTaskScreen(
                            addNewTask: (newTask) => addNewTask(newTask),
                          )));
                },
                child: const Text("Add Task"))
          ],
        ),
      ),
    ));
  }
}
