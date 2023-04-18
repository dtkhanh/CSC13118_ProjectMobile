import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/appSizes.dart';
import '../../routing/routes.dart';

class ProflileView extends StatefulWidget {
  const ProflileView({Key? key}) : super(key: key);

  @override
  State<ProflileView> createState() => _ProflileViewState();
}

class _ProflileViewState extends State<ProflileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children:  const [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue,
                    backgroundImage: AssetImage('assets/images/ironman.png'),
                  ),
                  gapH4,
                  Text(
                      'Dinh Trong Khanh',
                      style: TextStyle(
                          fontSize: Sizes.p24, fontWeight: FontWeight.bold, color: Colors.grey)
                  ),
                  gapH4,
                  Text(
                      'Trongkhanh2k1@gmail.com',
                      style: TextStyle(
                          fontSize: Sizes.p20, fontWeight: FontWeight.bold,color: Colors.grey)
                  ),
                ],
              ),
            ),
            gapH12,
            Text(
              "Phone number",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            gapH2,
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
                    hintText: "0383******")
            ),
            gapH8,
            Text(
              "Birthday",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            gapH2,
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
                    hintText: "29/04/2001")
            ),
            gapH8,
            Text(
              "Country",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            gapH2,
            DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Please select your country',
                hintStyle:TextStyle(fontSize: 15, color: Colors.grey[700]),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
              ),
              onChanged: (value) {}, items: <String>['VietNam', 'Albania', 'America', 'Andorra'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              );
            }).toList(),
            ),
            gapH8,
            Text(
              "My Level",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800]),
            ),
            gapH2,
            DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade100,
                hintText: 'Please select your level',
                hintStyle:TextStyle(fontSize: 15, color: Colors.grey[700]),
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
              ),
              onChanged: (value) {}, items: <String>['Beginner', 'Intermediate', 'Advanced'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
              );
            }).toList(),
            ),
            gapH16,
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
                    "Save",
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
