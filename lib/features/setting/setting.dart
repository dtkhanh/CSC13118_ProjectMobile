import 'package:csc13118_mobile/features/setting/widget/profileView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/appSizes.dart';
import '../../../routing/routes.dart';
import '../../providers/userProvider.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child:  Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                      if (userProvider.user == null) {
                        return Text('Not logged in');
                      } else {
                        return Column(
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
                                        userProvider.user.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                )
                            ),
                            gapH4,
                            Text(
                                userProvider.user.name ?? "",
                                style: const TextStyle(
                                    fontSize: Sizes.p24, fontWeight: FontWeight.bold, color: Colors.grey)
                            ),
                            gapH4,
                            Text(
                                userProvider.user.email ?? "",
                                style: const TextStyle(
                                    fontSize: Sizes.p20, fontWeight: FontWeight.bold,color: Colors.grey)
                            ),
                          ],
                        );
                      }
                  },
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
              Card(
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
              gapH12,
              Card(
                surfaceTintColor: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: const [
                      Icon(Icons.history, size: 30),
                      SizedBox(width: 12),
                      Text(
                        'View Feedbacks',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
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
