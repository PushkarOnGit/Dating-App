import 'package:bliss_bond/components/my_button.dart';
import 'package:bliss_bond/components/my_textfield.dart';
import 'package:bliss_bond/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final genderController = TextEditingController();

  void signUserUp() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
              backgroundColor: Colors.white,
            ),
          );
        });

    Future addUserDetails(
        String fullName, String email, String gender) async {
      await FirebaseFirestore.instance.collection('users').add({
        'full name': fullName,
        'gender': gender,
        'email': email,
      });
    }

    //try creating user
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        addUserDetails(
          fullNameController.text.trim(),
          emailController.text.trim(),
          genderController.text.trim()
        );
      } else {
        showErrorMessage('Passwords don\'t match');
      }

      //pop the circular progress indicator
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop circular progress indicator
      Navigator.pop(context);

      //show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                message,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bliss',
                      style: GoogleFonts.oswald(
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Bond',
                      style: GoogleFonts.oswald(
                        fontSize: 30,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                //welcome back, you've been missed!
                Text(
                  'Register to find your Bliss!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                MyTextField(
                  hintText: 'Full Name',
                  obscureText: false,
                  controller: fullNameController,
                ),

                SizedBox(
                  height: 20,
                ),

                MyTextField(
                  hintText: 'Male/Female',
                  obscureText: false,
                  controller: genderController,
                ),

                SizedBox(
                  height: 10,
                ),

                //username field
                MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController,
                ),

                SizedBox(
                  height: 10,
                ),

                //password field
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                ),

                SizedBox(
                  height: 10,
                ),

                //confirm password field
                MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPasswordController,
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                  buttonText: 'Sign Up',
                ),

                SizedBox(
                  height: 25,
                ),

                //or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[700],
                      ))
                    ],
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                //Google Sign in  button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () => AuthService().signInWithGoogle(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.grey, width: 1.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/images/google.png',
                            height: 30,
                          ),
                          SizedBox(
                            width: 1,
                          ),
                          Text(
                            ' O O G L E',
                            style: TextStyle(
                              color: Colors.pink[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 29,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already a member? ',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now!',
                        style: TextStyle(
                            color: Colors.pink[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
