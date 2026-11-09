import 'package:flutter/material.dart';

class Todo {
  final String title;
  bool done = false;
  final int id;
  Todo(this.id, this.title);
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  final List<Todo> todos = [];
  final input = TextEditingController();
  int nextId = 0;

void add() {
    if (input.text.isEmpty) return; 
    
    setState(() {
      todos.add(Todo(nextId++, input.text)); 
    });
    input.clear(); 
    testFilter();
  }
  // Bug 2: no setState
    /*  void toggle(Todo todo) => setState(() => todo.done = !todo.done);
    
*/
void toggle(Todo todo) {
  setState(() => todo.done = !todo.done);
  countDone();
}
  void remove(Todo todo) => setState(() => todos.remove(todo));
  
//BUG 1 
void countDone() {
    int doneCount = 0;
    // Bug 1: off-by-one
    for (var i = 0; i < todos.length; i++) { 
      doneCount += todos[i].done ? 1 : 0;
    }
    print('Completed tasks: $doneCount');
  }

  // Bug 3
String? _filter;
void testFilter() {
  final visible = todos.where(
      (t) => t.title.contains(_filter?? '')).toList();
  print(visible);
}

  @override
 
    void dispose() {
      input.dispose();
      super.dispose();
    }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: input,
              decoration: const InputDecoration(
                labelText: 'Enter new task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
         Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, i) {
                final todo = todos[i];
                return Dismissible(
                  key: ValueKey(todo.id), 
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red), 
                  onDismissed: (_) {
                  
                    final deletedIndex = i;
                    final deletedTodo = todo;

                    setState(() {
                      todos.removeWhere((t) => t.id == todo.id); 
                    });

              
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${deletedTodo.title} deleted'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            setState(() {
                              todos.insert(deletedIndex, deletedTodo);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: TodoTile(
                    todo: todo,
                    onToggle: () => toggle(todo), 
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add, 
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;

  const TodoTile({super.key, required this.todo, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.done,
          onChanged: (bool? newValue) {
            onToggle();
          },
        ),
        title: Text(todo.title),
      ),
    );
  }
}