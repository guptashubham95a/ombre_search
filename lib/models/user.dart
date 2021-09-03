import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String eventname;
  final String name;
  final String imageurl;

  User(
    this.eventname,
    this.name,
    this.imageurl,
  );
}

class Users {
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
    )
  ];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Algolia algolia = Algolia.init(
    applicationId: 'Z68GVUPFY5',
    apiKey: 'fc56dcda1831ac8cd232655e97658342',
  );
  List<User> get users {
    return [..._users];
  }

  void pushData() async {
    _users.forEach((user) {
      final data = {
        "eventName": user.eventname,
        "name": user.name,
        "imageUrl": user.imageurl,
      };
      firestore.collection('users').add(data);
      algolia.instance
          .index('users')
          .addObject(data)
          .then((value) => {print("Data added+++______----->>>>")});
    });
    // notifyListeners();
  }

// ******************* For Fetching the data from Firebase  *******************
  void fetchData() async {
    await firestore.collection("users").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        print("Data------------->>>>>>>>>>>>>${result.data()}");
      });
    });
    // notifyListeners();
  }
}
