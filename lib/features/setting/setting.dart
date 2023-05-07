import 'package:csc13118_mobile/chatGPT/ChatGPT.dart';
import 'package:csc13118_mobile/features/setting/widget/profileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/appSizes.dart';
import '../../../routing/routes.dart';
import '../../model/user.dart';
import '../../providers/userProvider.dart';
import '../../services/userService.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late User user;
  bool _isLoading = false;

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
        body: Padding(
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
                            MaterialPageRoute(builder: (context) => ProflileView()),
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
              gapH24,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  onPressed: () {
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
        )
    );
  }
}
