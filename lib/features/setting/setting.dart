import 'dart:convert';

import 'package:csc13118_mobile/chatGPT/ChatGPT.dart';
import 'package:csc13118_mobile/features/setting/widget/profileView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/appSizes.dart';
import '../../../routing/routes.dart';
import '../../model/user.dart';
import '../../services/userService.dart';

const listLanguage = [
  '{"name": "English","id":"en-US"}','{"name": "Vietnam","id":"vi-VN"}'
];
class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late User user;
  bool _isLoading = false;
  final _googleSignIn = GoogleSignIn();
  bool _isExpanded = false;
  String language ="";


  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    language = prefs.getString('setLanguage')?? "en-US";
  }


  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void getInfomation() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      final userInfo = await UserService.getUserInformation(token: check!);
      setState(() {
        user=userInfo;
        _isLoading = true;
      });
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    getInfomation();
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !_isLoading ?
                const Text('')
                    :
                Center(
                  child: Column(
                    children:  [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProflileView()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 45,
                            child: ClipOval(
                                child: Image.network(
                                  user.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                            ),
                          )
                      ),
                      gapH4,
                      Text(
                          user.name ?? "",
                          style: const TextStyle(
                              fontSize: Sizes.p24, fontWeight: FontWeight.bold, color: Colors.grey)
                      ),
                      gapH4,
                      Text(
                          user.email ?? "",
                          style: const TextStyle(
                              fontSize: Sizes.p20, fontWeight: FontWeight.bold,color: Colors.grey)
                      ),
                    ],
                  ),
                ),
                gapH12,
                Card(
                  surfaceTintColor: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Icon(Icons.settings, size: 30),
                        SizedBox(width: 12),
                        Text(
                          'Advanced Settings',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                gapH12,
                InkWell(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.history,
                          (route) => false,
                    );
                  },
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(Icons.history, size: 30),
                          SizedBox(width: 12),
                          Text(
                            'Session History',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                gapH12,
                InkWell(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.courseDetail,
                          (route) => false,
                    );
                  },
                  child:  Card(
                    surfaceTintColor: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(Icons.school, size: 30),
                          SizedBox(width: 12),
                          Text(
                            'View Courses',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                gapH12,
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatGPT()),
                    );
                  },
                  child:  Card(
                    surfaceTintColor: Colors.white,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(Icons.chat_outlined, size: 30),
                          SizedBox(width: 12),
                          Text(
                            'Chat with GPT',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                gapH12,
                Card(
                  surfaceTintColor: Colors.white,
                  elevation: 2,
                  child:  Container(
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      // color: Colors.blue.shade300,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      language.toString() == "en-US"  ? "assets/svg/england.svg"
                                          :"assets/svg/Vietnam.svg",
                                      width: 35,
                                      height: 35,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      language.toString() == "en-US" ?  'English' : 'Vietnamese',
                                      style: const TextStyle(
                                        color: Colors.black, fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            _isExpanded = !_isExpanded;
                                          });
                                        },
                                        child: Icon( Icons.arrow_forward_ios, color:Colors.grey.shade800,)
                                    ),
                                  ],
                                )
                            ),

                            // SizedBox(width: MediaQuery.of(context).size.width * 0.6 ,),

                          ],
                        ),
                        // const SizedBox(height: 10,),
                        if (_isExpanded)
                          Wrap(
                              spacing: 6,
                              runSpacing: 8,
                              children: List<Widget>.generate(
                                listLanguage.length,
                                    (index) =>Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    InkWell(
                                        onTap: (  ) async {
                                          final prefs = await SharedPreferences.getInstance();
                                          await prefs.setString('setLanguage', jsonDecode(listLanguage[index].toString())["id"]);
                                          setState(() {
                                            _isExpanded = !_isExpanded;
                                            language = prefs.getString('setLanguage')?? "en-US";
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              jsonDecode(listLanguage[index].toString())["name"] == "English" ? "assets/svg/england.svg"
                                                  : "assets/svg/Vietnam.svg",
                                              width: 35,
                                              height: 35,
                                            ),
                                            const SizedBox(width: 10,),
                                            Text( jsonDecode(listLanguage[index].toString())["name"] ,  style: const TextStyle(fontSize: 16,
                                            ),),
                                          ],
                                        )
                                    ),
                                    const SizedBox(height: 10,),
                                    Container(
                                      height: 1,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ),
                      ],
                    ),
                  ),
                ),
                gapH24,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue
                    ),
                    onPressed: () {
                      _handleSignOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.login,
                            (route) => false,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Logout",
                        style: TextStyle(fontSize: Sizes.p20, fontWeight: FontWeight.bold, color: Colors.white ),
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
