import 'package:csc13118_mobile/constants/appSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/language.dart';
import '../../model/tokensUser.dart';
import '../../model/user.dart';
import '../../routing/routes.dart';
import '../../services/authentication.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _googleSignIn = GoogleSignIn();
  Map<String, dynamic>? _loginResponse;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPass = TextEditingController();
  Map<String, dynamic>? _register;
  String _ErrorInputEmail ="";
  String _ErrorInputPass ="";
  String _ErrorInputPassConfirm ="";
  Language lag = Language(id: "vi-Vn");

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

  void _handleValidation() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (_email.text.isEmpty) {
      _ErrorInputEmail ="Please input your Email!";
    } else if (!emailRegex.hasMatch(_email.text)) {
      _ErrorInputEmail ="The input is not valid E-mail!";
    } else {
      _ErrorInputEmail ="";
    }

    if (_password.text.isEmpty) {
      _ErrorInputPass ="Please input your Password!";
    } else {
      _ErrorInputPass ="";
    }
    if (_confirmPass.text.isEmpty) {
      _ErrorInputPassConfirm ="Please input your Confirm Password!";
    }
    setState(() {});
  }
  void _handleValidationPass() {
    if (_password.text.isEmpty) {
      _ErrorInputPass ="Please input your Password!";
    } else {
      _ErrorInputPass ="";
    }
    setState(() {});
  }
  void _handleValidationPassConfirm() {
    if (_confirmPass.text.isEmpty) {
      _ErrorInputPassConfirm ="Please input your Confirm Password!";
    } else if  (_confirmPass.text != _password.text ) {
      _ErrorInputPassConfirm ="Password and ConfirmPassword no incorrect!";
    }
    else {
      _ErrorInputPassConfirm ="";
    }
    setState(() {});
  }


  void registerAccount() async {
    try {
      if(_ErrorInputEmail.isEmpty ||  _ErrorInputPass.isEmpty || _ErrorInputPassConfirm.isEmpty){
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
  Future<void> _handleAuthorizeGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final String? accessToken = googleAuth?.accessToken;
      _loginResponse = await AuthenticationService().loginWithGoogle(accessToken: accessToken ?? "");
      final user = User.fromJson(_loginResponse!['user']);
      final token = TokensUser.fromJson(_loginResponse!['tokens']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', token.access!.token!,);
      await prefs.setString('refreshToken', token.refresh!.token!,);
      await prefs.setString('userId', user.id!,);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
              (route) => false,
        );
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error Login')),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    _initPrefs();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          lag.register,
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
                  lag.email,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _email,
                  onChanged: (value) {
                    _handleValidation();
                  },
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
              Text(
                _ErrorInputEmail,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.red),
              ),
              gapH8,
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  lag.password,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _password,
                  onChanged: (value) {
                    _handleValidationPass();
                  },
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
              Text(
                _ErrorInputPass,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.red),
              ),
              gapH8,
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  lag.confirmPassword,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
              ),
              TextField(
                  controller: _confirmPass,
                  onChanged: (value) {
                    _handleValidationPassConfirm();
                  },
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
              Text(
                _ErrorInputPassConfirm,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.red),
              ),
              gapH16,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    _handleValidation();
                    registerAccount();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      lag.buttonRegister,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              gapH12,
              Center(
                  child: Column(
                    children: [
                      Text(lag.orContinue),
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
                            onPressed: () {
                              _handleAuthorizeGoogle();
                            },
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
                          Text(lag.alreadyAccount),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                              },
                              child:  Text(lag.login,
                                  style: const TextStyle(
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

