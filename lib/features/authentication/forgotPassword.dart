import 'package:csc13118_mobile/constants/appSizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/language.dart';
import '../../services/authentication.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email= TextEditingController();
  Map<String, dynamic>? forgot;
  Language lag = Language(id: "en-US");
  bool check = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
  }


  void sendForgotPassword() async {
    try {
      if (_email.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error : No empty field')),
        );
      }
      else {
        forgot = await AuthenticationService.forgotPassword(email: _email.text);
        Future.delayed(const Duration(seconds: 1), () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email send success!')),
          );
          setState(() {
            check =true;
          });
          // Navigator.pop(context);
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
            lag.forgotPass,
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
            child: check ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/lettutor.png',
                        width: 100,
                        height: 100,
                      ),
                      gapH8,
                      const Text(
                          ' LET TUTOR ',
                          style: TextStyle(
                              color: Colors.blue, fontSize: 24
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                Text(
                    lag.getId =="vi-Vn" ? "Kiểm tra hộp thư đến trong email để đặt lại mật khẩu của bạn." : "Check your inbox for a link to reset your password.",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
              ],
            )
            :
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Center(
                   child: Column(
                     children: [
                       Image.asset(
                         'assets/images/lettutor.png',
                         width: 100,
                         height: 100,
                       ),
                       gapH8,
                       const Text(
                           ' LET TUTOR ',
                           style: TextStyle(
                               color: Colors.blue, fontSize: 24
                           )),
                     ],
                   ),
                 ),
                const SizedBox(height: 40,),
                Text(
                  lag.stringForgot,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                gapH24,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _email,
                      style:
                      TextStyle(fontSize: 15, color: Colors.grey[700]),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          hintText:lag.getId =="vi-Vn" ? "Nhập email" : "Enter your email")),
                ),
                const SizedBox(height: 60,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      sendForgotPassword();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        lag.buttonForgotPass,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

