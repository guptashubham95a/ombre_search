import 'package:flutter/material.dart';

class userComponent extends StatelessWidget {
  final user;
  userComponent({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(user.imageurl),
                )),
            SizedBox(width: 25),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                user.eventname,
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.w500,
                  // fontSize: 15,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(user.name,
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ])
          ]),
        ],
      ),
    );
  }
}
