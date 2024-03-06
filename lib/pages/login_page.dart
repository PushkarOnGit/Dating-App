import 'package:bliss_bond/components/my_button.dart';
import 'package:bliss_bond/components/my_textfield.dart';
import 'package:bliss_bond/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {

  final Function()? onTap;
  const LoginPage({super.key, this.onTap, });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

void signUserIn() async{

  //show loading circle
  showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.white,
          ),
        );
      }
  );

  //try sign in
  try{
    await FirebaseAuth.instance.
    signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
    );
    //pop the circular progress indicator
    Navigator.pop(context);
  }on FirebaseAuthException catch (e) {
    //pop circular progress indicator
    Navigator.pop(context);

    //show error message
    showErrorMessage(e.code);
  }
}

void showErrorMessage(String message) {
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
  );
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
                        fontSize: 52,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Bond',
                      style: GoogleFonts.oswald(
                        fontSize: 52,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Icon(Icons.favorite),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Hello Again!',
                  style: GoogleFonts.bebasNeue(fontSize: 40),
                ),

                //welcome back, you've been missed!
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                SizedBox(
                  height: 25,
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

                //forgot password button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.pink[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 14.1),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //sign in button
                MyButton(
                  onTap: signUserIn,
                  buttonText: 'Login',
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
                    Text('Not a member? ',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now!',
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
