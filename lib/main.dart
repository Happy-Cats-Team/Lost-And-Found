import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lost_and_found/pages/lost_items_list.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
        // '/found':
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Lost & Found')),
        body: const MyLostItemListPage(title: 'Flutter Demo Home Page'),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              if (value == 0) {
                // Navigator.push(context, MyLostItemListPage(title: "title"))
              } else if (value == 1) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           const MyLostItemListPage(title: "Found Items")),
                // );
              } else if (value == 2) {}
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lost"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb), label: "Found"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle), label: "Account")
            ]),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      var db = FirebaseFirestore.instance;
      db.collection("posts").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}