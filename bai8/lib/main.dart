import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bai8/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Flutter App',
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();

    // Thêm một số công việc mẫu
    _tasks.add(Task(
      title: 'Học Flutter',
      deadline: DateTime.now().add(Duration(days: 7)),
      name: '',
    ));
    _tasks.add(Task(
      title: 'Mua sữa',
      deadline: DateTime.now().subtract(Duration(days: 1)),
      name: '',
    ));
    _tasks.add(Task(
      title: 'Đi bơi',
      deadline: DateTime.now().add(Duration(days: 2)),
      name: '',
    ));
  }

  void _addTask() async {
    // Hiển thị hộp thoại để người dùng nhập thông tin công việc
    TextEditingController titleController = TextEditingController();
    TextEditingController deadlineController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm công việc mới'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Tên công việc',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: deadlineController,
                decoration: InputDecoration(
                  labelText: 'Thời hạn chót (VD: 2023-03-31)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final deadline = DateTime.tryParse(deadlineController.text);
                if (title.isNotEmpty && deadline != null) {
                  setState(() {
                    _tasks
                        .add(Task(title: title, deadline: deadline, name: ''));
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Vui lòng nhập đầy đủ thông tin.'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Công việc của tôi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          final deadlineFormatted =
              DateFormat('dd/MM/yyyy').format(task.deadline);

          return ListTile(
            title: Text(task.title),
            subtitle: Text('Hạn chót: $deadlineFormatted'),
            trailing:
                task.isOverdue() ? Icon(Icons.error, color: Colors.red) : null,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
