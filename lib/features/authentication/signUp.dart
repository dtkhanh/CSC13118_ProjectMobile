import 'package:csc13118_mobile/constants/appSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routing/routes.dart';
import '../../services/authentication.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();
  Map<String, dynamic>? _register;


  void registerAccount() async {
    try {
      if(_password.text.isEmpty ||  _confirmPass.text.isEmpty ||  _email.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error : No empty field')),
        );
      }
      else if(_password.text != _confirmPass.text){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password and ConfirmPassword no incorrect')),
        );
      }else {
        _register = await AuthenticationService.registerAccount(password: _password.text, email: _email.text);
        Future.delayed(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully')),
          );
          Navigator.pop(context);
        });

      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.blue[600],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapH12,
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  style:
                  TextStyle(fontSize: 15, color: Colors.grey[700]),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      hintText: "example@email.com")),
              gapH12,
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _password,
                  obscureText: true,
                  autocorrect: false,
                  style:
                  TextStyle(fontSize: 15, color: Colors.grey[700]),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      hintText: "****************")),
              gapH12,
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _confirmPass,
                  obscureText: true,
                  autocorrect: false,
                  style:
                  TextStyle(fontSize: 15, color: Colors.grey[700]),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.all(Radius.circular(10))),
                      hintText: "****************")),
              gapH20,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    registerAccount();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              gapH12,
              Center(
                  child: Column(
                    children: [
                      const Text("Or continue with"),
                      gapH16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xff007CFF))
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/facebook.svg",
                              semanticsLabel: 'Logo Facebook',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xff007CFF))
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/google.svg",
                              semanticsLabel: 'Logo Google',
                              width: 40,
                              height: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xff007CFF))
                              ),
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/zalo.svg",
                              semanticsLabel: 'Logo Zalo',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      gapH8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  <Widget>[
                          const Text("Already have an account? "),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              },
                              child:  const Text("Login",
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ))
                          ),

                        ],
                      )
                    ],
                  )
              ),

            ],
          ),
        ),
      )
    );
  }
}

