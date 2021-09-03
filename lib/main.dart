import 'package:flutter/material.dart';
import './Widgets/searchBar.dart';
import './Widgets/userComponent.dart';
import './models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:algolia/algolia.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ******************* Dummy data to be stored on Firebase *******************
  List<User> _users = [
    User(
      'Rock | Blues',
      'The Beacon Jams',
      'https://images.unsplash.com/photo-1504735217152-b768bcab5ebc?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=0ec8291c3fd2f774a365c8651210a18b',
    ),
    User(
      'Blues Dwyer',
      'The Beacon Jams',
      'https://images.unsplash.com/photo-1503467913725-8484b65b0715?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=cf7f82093012c4789841f570933f88e3',
    ),
    User(
      'Rock | Blues |Country',
      'The Bluegrass Situation|Julian',
      'https://images.unsplash.com/photo-1507081323647-4d250478b919?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=b717a6d0469694bbe6400e6bfe45a1da',
    ),
    User(
      'Jazz',
      'The Bullen Family',
      'https://images.unsplash.com/photo-1502980426475-b83966705988?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=ddcb7ec744fc63472f2d9e19362aa387',
    ),
    User(
      'Rock',
      'The Creekside Music Hall Show',
      'https://images.unsplash.com/photo-1541710430735-5fca14c95b00?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    User(
      'Rock',
      'The Creekside Music Hall Show',
      'https://images.unsplash.com/photo-1542534759-05f6c34a9e63?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
    User(
      'Rock | Blues',
      'The Last LiveStream',
      'https://images.unsplash.com/photo-1516239482977-b550ba7253f2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ',
    ),
  ];
  bool _isLoading = false;
// ******************* Searched results *******************
  List<User> _foundedUsers = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Algolia algolia = Algolia.init(
    applicationId: 'Z68GVUPFY5',
    apiKey: 'fc56dcda1831ac8cd232655e97658342',
  );

  @override
  void initState() {
    super.initState();
    // ******************* For Fetching the data from Firebase  *******************
    // Users().fetchData();
// ******************* For sending data to Firebase and Algolia *******************
    // Users().pushData();
  }

  void onSearch(String value) async {
    // ******************* For Loading CircularProgressIndicator *******************
    setState(() {
      _isLoading = true;
    });
    // ******************* Quering and fetching the data the hits from algolia *******************
    AlgoliaQuery query = algolia.instance.index('users').query(value);
    AlgoliaQuerySnapshot querySnap = await query.getObjects();
    List<AlgoliaObjectSnapshot> result = querySnap.hits;

    // if (result.length == 0) return;
    _foundedUsers = result.map((snapshot) {
      final response = snapshot.data;
      print("Response---->${response}");
      return User(
          response['eventName'], response['name'], response['imageUrl']);
    }).toList();
    // print("FoundedUsers---->${_foundedUsers}");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade900,
          title: SearchBar(onSearch)),
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        color: Colors.grey.shade900,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (_foundedUsers.length > 0)
                ? ListView.builder(
                    itemCount: _foundedUsers.length,
                    itemBuilder: (context, index) {
                      return userComponent(user: _foundedUsers[index]);
                    })
                : Center(
                    child: Text(
                    "No users found",
                    style: TextStyle(color: Colors.white),
                  )),
      ),
    );
  }
}
