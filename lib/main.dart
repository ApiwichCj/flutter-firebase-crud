import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'edit_item_screen.dart';
import 'firebase_options.dart';
import 'new_item_screen.dart';

Future<void> main() async {
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: ((context, snapshot) {
          final dataDocuments = snapshot.data?.docs;
          if (dataDocuments == null) return const Text("no data");
          return ListView.builder(
            itemCount: dataDocuments.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _editItemScreen(
                    documentid:dataDocuments[index].id,
                    itemName:dataDocuments[index]["name"], 
                    itemDesc:dataDocuments[index]["desc"]),
                child: ListTile(
                  title: Text(dataDocuments[index]["name"].toString()),
                  subtitle: Text(dataDocuments[index]["desc"].toString()),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItem,
        tooltip: 'Create New Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewItemScreen()));
  }

  _editItemScreen({required String documentid, required String itemName, required String itemDesc}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditItemScreen(documentid:documentid, itemName:itemName, itemDesc:itemDesc)));
  }
}
