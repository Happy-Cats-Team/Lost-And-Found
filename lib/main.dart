import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/pages/add_item.dart';
import 'package:lost_and_found/pages/found_items_list.dart';
import 'package:lost_and_found/pages/login.dart';
import 'package:lost_and_found/pages/lost_items_list.dart';

import 'firebase_options.dart';

List<Widget> pageList = [
  const MyLostItemListPage(title: "Lost Iteams"),
  const MyFoundItemListPage(title: "Found Items")
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: MyHomePage(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: Text("Lost & Found")),
    //   body: const MyLostItemListPage(
    //     title: 'Lost Items',
    //   ),
    // );
    return MaterialApp(
      title: 'Lost & Found',
      routes: {
        '/lost': (context) => const MyLostItemListPage(title: "Lost Items"),
        '/found': (context) => const MyFoundItemListPage(title: "Found Items"),
      },
      initialRoute: "/lost",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(
      // ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<MyHomePage> {
  int _selectedTab = 0;

  final List _pages = [
    const MyLostItemListPage(title: "List Items"), //0
    const MyFoundItemListPage(title: "Found Items"), //1
    const MyLoginPage(title: "Login"),
    const MyAddItemPage(title: "Add Item") //3
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lost & Found"),
          actions: [Text("${FirebaseAuth.instance.currentUser?.email}")]),
      body: _pages[_selectedTab],
      floatingActionButton: _selectedTab >= 0 && _selectedTab <= 1
          ? FloatingActionButton(
              backgroundColor: const Color.fromRGBO(0x78, 0x8A, 0xC9, 1),
              child: const Icon(Icons.edit),
              onPressed: () {
                _changeTab(3);
              },
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab >= 3 ? 0 : _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: _selectedTab >= 3 ? Colors.grey : Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lost"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Found"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "Account")
        ],
      ),
    );
  }
}
