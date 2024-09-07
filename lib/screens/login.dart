import 'package:examinate/widgets/button.dart';
import 'package:examinate/widgets/text_field.dart';
import 'package:examinate/widgets/tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.yellow,),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
      //displayMessage(e.code);
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Incorrect email'),
            ));
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Incorrect password'),
            )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //logo
                Image.asset(
                  'lib/images/1.png',
                  height: 72,
                ),
                const SizedBox(
                  height: 100,
                ),

                //welcome text
                const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                //username
                MyTextField(
                  controller: emailController,
                  obscureText: false,
                  hintText: 'email',
                ),
                const SizedBox(
                  height: 25,
                ),
                //password
                MyTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'password',
                ),
                const SizedBox(
                  height: 25,
                ),
                //forgot password
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'forgot password ?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //sign in button
                Button(
                  text: 'Login',
                  onTap: signIn,
                ),

                const SizedBox(
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
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('or continue with'),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //google
                const Tile(
                  imagePath: 'lib/images/Google.png',
                ),
                const SizedBox(
                  height: 25,
                ),
                //not a member ?
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('do not have an account ?'),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Register now',
                      style: TextStyle(color: Colors.blue),
                    )
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
