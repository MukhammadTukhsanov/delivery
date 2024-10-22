import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff3f4f6),
        appBar: AppBar(
          backgroundColor: const Color(0xfff3f4f6),
          elevation: 0,
          title: const Text('Savat',
              style: TextStyle(
                  color: Color(0xff3c486b), fontFamily: 'Josefin Sans')),
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(
          //         context, widget.backetData); // Return updated backetData
          //   },
          // ),
          // actions: [
          //   GestureDetector(
          //     onTap: () => emptyBacket(),
          //     child: const Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 16),
          //       child: Icon(Icons.delete_outlined),
          //     ),
          //   )
          // ],
        ),
        body: Text("Profile"));
  }
}
