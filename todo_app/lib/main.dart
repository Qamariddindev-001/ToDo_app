import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/todo_api.dart';

void main() {
  runApp(ToDoAppState());
}

class ToDoAppState extends StatefulWidget {
  const ToDoAppState({super.key});

  @override
  State<ToDoAppState> createState() => _ToDoAppStateState();
}

class _ToDoAppStateState extends State<ToDoAppState> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 207, 201, 201),
          appBar: AppBar(
            // elevation: 0,
            title: const Text('ToDo App in Flutter', style: TextStyle(color: Colors.black)),
            backgroundColor: const Color.fromARGB(255, 7, 100, 60),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh),
              )
            ],
          ),
          // body: ListView(children: list),
          body: FutureBuilder(
              future: getTodo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return ListView.separated(
                    // shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Checkbox(
                          value: snapshot.data![index]['done'],
                          onChanged: (v) {
                            setState(() {
                              snapshot.data![index]['done'] ? undone(snapshot.data![index]['id']) : done(snapshot.data![index]['id']);
                              print(snapshot.data![index]['done']);
                            });
                          }),
                      trailing: InkWell(
                        onTap: () {
                          setState(() {
                            deleteTodo(snapshot.data![index]['id']);
                          });
                          print('something');
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                            child: Text('Delete'),
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index]['title'],
                        style: TextStyle(decoration: snapshot.data![index]['done'] ? TextDecoration.lineThrough : null),
                      ),
                      subtitle: Text(
                        snapshot.data![index]['description'],
                        style: TextStyle(decoration: snapshot.data![index]['done'] ? TextDecoration.lineThrough : null),
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  );
                }
              }),
          floatingActionButton: Container(
            margin: EdgeInsets.only(left: 20),
            color: Colors.blue,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(minimumSize: MaterialStatePropertyAll(Size(142, 60)), backgroundColor: MaterialStatePropertyAll(Colors.green)),
                  onPressed: () {
                    setState(() {
                      addTodo(Todo(title: _controller.text, description: DateTime.now().toString().substring(0, 16)));
                    });
                  },
                  child: const Text('+ Add ToDo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
