import 'package:flutter/material.dart';
import 'models/user.dart';
import 'models/bank_account.dart';
import 'models/Library.dart';
import 'models/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'My First Flutter Lab  '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final user1 = User(name:'Ana', age:22);
  final user2 = User(name:'Cristina',email:"cristina.sandru@gmail.com");
  final user3 = User(name:'Peter');


  final List<BankAccount> accounts = [

  BankAccount(
    holderName: 'Ana Popescu',
    bankBranch: 'Main Branch',
    balance: 1200.0,
  )..initializeAccount('1001'),

  BankAccount(
    holderName: 'Cristina Sandru',
    balance: 50.0,
  ),

  BankAccount(
    holderName: 'Peter Parker',
    bankBranch: 'Downtown',
    balance: 300.0,
  ),
];

  @override
  void initState() {
    super.initState();
    _runLibraryTests();
  }

  void _runLibraryTests() {
  
    print(' TEST LIBRARY ');

    final library = Library();
    final book1 = Book(title: 'Book1', author: 'Eric Windmill', publishDate: DateTime(2020, 1, 1));
    final book2 = Book(title: 'Book2', author: 'Robert  Martin', publishDate: DateTime(2008, 8, 1));
    final book3 = Book(title: 'Book3', author: 'Jonathan Sande', publishDate: DateTime(2021, 5, 1));
    final book4 = Book(title: 'Book4', author: 'John Doe', publishDate: DateTime(2023, 2, 10));
    library.addItem(book1);
    library.addItem(book2);
    library.addItem(book3);
    library.addItem(book4);


    print('1. Books added: ${library.items.length} items in the library.');

    final foundBooks = library.searchByTitle('Book1');
    final nullSearch = library.searchByTitle(null);
    print('Searching for ${foundBooks}: ${foundBooks.length} rezultate.');
    print(' Null search test${nullSearch.isEmpty}');


final recent = library.getRecentItems();
    print('Newest book added: ${recent.first.title} (${recent.first.publishDate?.year})');
   
   print('Borrowed:');
    library.borrowItem(book1, user1);
    library.borrowItem(book2, user2);
    print('${user1.name} Borrowed: ${book1.title}');
    print('${user2.name} Borowed: ${book2.title}');

  
  print('Return test:');
  bool isReturned = library.returnItem(book1);
  print('${book1.title } was returned. Is returned: ${isReturned} ');

  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 204, 139, 177),
        title: Text(widget.title),
      ),
      body: Center(
    
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
            const SizedBox(height: 16),   
            Text('User 1 INFO:'),
            Text('Name: ${user1.name}'),
            Text('Age: ${user1.getDisplayAge()}'),
            Text('Email: ${user1.describeEmail()}'),
            const SizedBox(height: 16),
            Text('User 2 INFO'),
            Text('Name: ${user2.name}'),
            Text('Age: ${user2.getDisplayAge()}'),
            Text('Email: ${user2.describeEmail()}'),
            const SizedBox(height: 16),
            Text('User 3 INFO'),
            Text('Name: ${user3.name}'),
            Text('Age: ${user3.getDisplayAge()}'),
            Text('Email: ${user3.describeEmail()}'),
            
            Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, i) {
                final a = accounts[i];
                return ListTile(
                 title: Text(a.holderName),
                 subtitle: Column (
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 Text('Branch: ${a.bankBranch ?? "N/A"}'),
                 Text(a.checkNumber() ? 'Account nr: ${a.accountNumber}': 'Account nr: Not initialized',),
                Text('Balance: \$${a.balance}'),
              ],
             ),
             );
            },
            ),
          ),
          ],
        ),
      ),
      );
      
  }
}