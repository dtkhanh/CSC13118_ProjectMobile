import 'package:csc13118_mobile/constants/appSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routing/routes.dart';
import '../../services/authentication.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

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
            'Forgot password',
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
                  'Enter your email address and we will send you a link to reset your password',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                gapH24,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      style:
                      TextStyle(fontSize: 15, color: Colors.grey[700]),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          hintText: "Enter your email")),
                ),
                const SizedBox(height: 60,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Send",
                        style: TextStyle(fontSize: 20),
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

