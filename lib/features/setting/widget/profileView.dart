import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/appSizes.dart';
import '../../../model/user.dart';
import '../../../providers/userProvider.dart';
import '../../../routing/routes.dart';
import '../../../services/userService.dart';

class ProflileView extends StatefulWidget {
  const ProflileView({Key? key}) : super(key: key);

  @override
  State<ProflileView> createState() => _ProflileViewState();
}

class _ProflileViewState extends State<ProflileView> {
  late User user;
  bool _isLoading = false;
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _birthDay = TextEditingController();
  String country = "";
  String level = "";


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

  void updateInformation() async {
    try{
      setState(() {
        _isLoading = false;
      });
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      final userInfo = await UserService.UpdateInformation(token: check!,
          name: _name.text =="" ? user.name ?? "" : _name.text ,
          country: country =="" ? user.country ?? "" : country,
          phone: _phone.text =="" ? user.phone ?? "" : _phone.text,
          birthday: _birthDay.text =="" ? user.birthday ?? "" :  _birthDay.text,
          level: level =="" ? user.level ?? "" :  level,);
      setState(() {
        user=userInfo;
        _isLoading = true;
      });
      print("updateInformation");
      print(userInfo);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    getInfomation();
    // setState(() {
    //   _isLoading = false;
    // });
    return Scaffold(
     appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.blue[600],
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              //letterSpacing: 1.0,
              color: Colors.blue[600],
            ),
          ),
        ),
     body: SingleChildScrollView(
         child: !_isLoading ?
         const Center(
           child: Text(
             'NO DATA',
             textAlign: TextAlign.left,
             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
           ),
         )
             :
         Padding(
           padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Center(
                 child: Column(
                   children:  [
                     Align(
                       alignment: Alignment.center,
                       child: Stack(
                         children: [
                           CircleAvatar(
                             radius: 45,
                             child: ClipOval(
                                 child: Image.network(
                                   user.avatar ?? 'https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg',                                  width: 100,
                                   height: 100,
                                   fit: BoxFit.cover,
                                 )
                             ),
                           ),

                           Positioned(
                             bottom: 0,
                             right: 0,
                             child: GestureDetector(
                               onTap: () {},
                               child: CircleAvatar(
                                 backgroundColor: Colors.grey[300],
                                 radius: 18,
                                 child: const Icon(
                                   Icons.camera_alt,
                                   color: Colors.grey,
                                 ),
                               ),
                             ),
                           )
                         ],
                       ),
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
               Text(
                 "name",
                 style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                     color: Colors.grey[800]),
               ),
               gapH2,
               TextField(
                   style:
                   TextStyle(fontSize: 15, color: Colors.grey[700]),
                   controller: _name,
                   decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.grey.shade100,
                       border: const OutlineInputBorder(
                           borderSide: BorderSide.none,
                           borderRadius:
                           BorderRadius.all(Radius.circular(10))),
                       hintText: user.name ?? "")
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
                   controller: _phone,
                   decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.grey.shade100,
                       border: const OutlineInputBorder(
                           borderSide: BorderSide.none,
                           borderRadius:
                           BorderRadius.all(Radius.circular(10))),
                       hintText: user.phone ?? "")
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
                   controller: _birthDay,
                   decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.grey.shade100,
                       border: const OutlineInputBorder(
                           borderSide: BorderSide.none,
                           borderRadius:
                           BorderRadius.all(Radius.circular(10))),
                       hintText: user.birthday ?? "")
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
                   hintText: user.country ?? 'Please select your country',
                   hintStyle:TextStyle(fontSize: 15, color: Colors.grey[700]),
                   border: const OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius:
                       BorderRadius.all(Radius.circular(10))),
                 ),
                 onChanged: (value) {
                   setState(() {
                     country = value!;
                   });
                 }, items: <String>['VietNam', 'Albania', 'America', 'Andorra'].map<DropdownMenuItem<String>>((String value) {
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
                   hintText: user.level ??'Please select your level',
                   hintStyle:TextStyle(fontSize: 15, color: Colors.grey[700]),
                   border: const OutlineInputBorder(
                       borderSide: BorderSide.none,
                       borderRadius:
                       BorderRadius.all(Radius.circular(10))),
                 ),
                 onChanged: (value) {
                   setState(() {
                     level = value!;
                   });
                 }, items: <String>['BEGINNER','HIGHER_BEGINNER', 'INTERMEDIATE', 'ADVANCED','PROFICIENCY'].map<DropdownMenuItem<String>>((String value) {
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
                     updateInformation();
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
     ),
    );
  }
}
