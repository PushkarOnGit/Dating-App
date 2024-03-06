import 'package:bliss_bond/components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final String userId;
  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text('P r o f i l e', style: GoogleFonts.bebasNeue(color: Colors.white),)),
      ),
      body:ListView(
        children: [
          SizedBox(height: 40,),
          Icon(Icons.person, size: 100,),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle( color: Colors.grey[700]),
          ),
          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 15),
            child: Text('My Details', style: TextStyle(fontSize: 17, color: Colors.grey[700]),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 30),
                    child: Text('Name', style: TextStyle(color: Colors.grey),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 30),
                    child: Text('Gender', style: TextStyle(color: Colors.grey),),
                  ),
                  
                ],
              ),
            ),
          ),
                  Padding(
                    padding: const EdgeInsets.only(top: 170.0),
                    child: MyButton(buttonText: 'Log Out', onTap: signUserOut,),
                  )
        ],
      ),
    );
  }
}
