
import 'package:csc13118_mobile/features/authentication/forgotPassword.dart';
import 'package:csc13118_mobile/features/authentication/signUp.dart';
import 'package:csc13118_mobile/model/tokensUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/token.dart';
import '../../model/user.dart';
import '../../providers/userProvider.dart';
import '../../routing/routes.dart';
import '../../services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/userService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  Map<String, dynamic>? _loginResponse;
  late User user;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    // final userInfo = await UserService.getUserInformation(token: check!);
    // final userProvider = UserProvider();
    // TokensUser? tkUser = userProvider.token;
    // userProvider.addUserProvider(userInfo, tkUser!);
    if(check!.length != 0){
      // Future.delayed(const Duration(seconds: 1), () {
      //   Navigator.pushNamedAndRemoveUntil(
      //     context,
      //     Routes.main,
      //         (route) => false,
      //   );
      // });
    }
  }


  void getInfomation(String tokenUser) async {
    try{
      final userInfo = await UserService.getUserInformation(token: tokenUser);
      setState(() {
        user=userInfo;
      });
      // final userProvider = UserProvider();
      // TokensUser? tkUser = userProvider.token;
      // userProvider.addUserProvider(user, tkUser!);

    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }


  void loginPage() async {
    try{
      _loginResponse = await AuthenticationService().loginAccount(email:"trongkhanh2k1@gmail.com", password: "123456" );
      // _loginResponse = await AuthenticationService().loginAccount(email:"phhai@ymail.com", password: "123456" );

      // _loginResponse = await AuthenticationService().loginAccount(email: _email.text, password: _password.text );
      final user = User.fromJson(_loginResponse!['user']);
      final token = TokensUser.fromJson(_loginResponse!['tokens']);
      // userProvider.addUserProvider(user, token);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('accessToken', token.access!.token!,);
      await prefs.setString('refreshToken', token.refresh!.token!,);
      await prefs.setString('userId', user.id!,);

      //
      // print("loginPage");
      // print( userProvider.token!.refresh!.token!,);
      // print( userProvider.token!.refresh!.expires!,);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.main,
              (route) => false,
        );
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = context.watch<UserProvider>();

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
                          controller: _password,
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
                      children:  [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ForgotPassword()),
                              );
                            },
                            child:  const Text("Forgot password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ))
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        loginPage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Login in",
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
                      children:  <Widget>[
                        const Text("Not a member yet? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUp()),
                            );
                          },
                          child:  const Text("Sign up",
                              style: TextStyle(
                                color: Colors.blue,
                              ))
                        ),

                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}