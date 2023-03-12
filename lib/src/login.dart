import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child:  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover, // sử dụng BoxFit.cover để đảm bảo hình ảnh full màn hình
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                          style:
                          TextStyle(fontSize: 15, color: Colors.grey[700]),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              hintText: "abc@gmail.com")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                          obscureText: true,
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
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Forgot password?",
                            style: TextStyle(
                              color: Colors.blue,
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Sign in",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Or continue with")],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
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

                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const <Widget>[
                            Text("Not a member yet? "),
                            Text("Sign up",
                                style: TextStyle(
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}