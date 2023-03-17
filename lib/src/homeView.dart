import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/data.dart';
import 'package:csc13118_mobile/src/InformationTeacher.dart';
import 'package:csc13118_mobile/src/teamView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewStage();


}

class _HomeViewStage extends State<HomeView> {
  int chosenFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Upcoming Lesson',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '2023-03-11  20:00-00:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const  Text(
                        ' ( Start in 65:43:51 ) ',
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 13, color: Colors.yellow),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // set the radius here
                            ),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),),
                          onPressed: () {  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TeamView()),
                          ); },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/join.svg",
                                semanticsLabel: 'Logo join',
                                width: 10,
                                height: 10,
                              ),
                              const SizedBox(width: 2.0),
                              const Text('Join', style: TextStyle(fontSize: 15))],),
                          ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 24),
                    child: Text(
                      'Total Lesson Time: 4 hours 30 minutes',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Row(
                children: const [
                  Text(
                    'Find a tutor',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  children:  [
                    Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              hintText: "enter tutor name",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child:   DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              hintText: 'select nationality',
                              hintStyle: TextStyle(color: Colors.grey[400],  ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey,),
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                            ),
                            onChanged: (value) {}, items: const [],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Row(
                children: const [
                  Text(
                    'Select available tutoring time',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Column(
                  children:  [
                    Row(
                      children: [
                        ConstrainedBox(
                          constraints:const BoxConstraints(maxWidth: 200),
                          child: Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                hintText: "select a day",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Wrap(
                spacing: 8,
                runSpacing: 6,
                children: List<Widget>.generate(
                  filters.length,
                      (index) => Positioned(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              chosenFilter = index;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor : chosenFilter == index ?  Colors.lightBlue[100]   :  Colors.grey[200], // set the background color of the button
                          ),
                          child: Text( filters[index], style: TextStyle( color: chosenFilter == index ? Colors.blue[700] : Colors.black54,
                          ),),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.blue;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const Text('Reset Filters', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const  EdgeInsets.fromLTRB(12, 20, 12, 12),
              child: Container(
                height: 1,
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child:  Row(
                children: const [
                  Text(
                    'Recommended Tutors',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child:  Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: List<Widget>.generate(
                      teachers.length,
                          (index) => SizedBox(
                          child:
                          SizedBox(
                              width: 420,
                              child: Card(
                                surfaceTintColor: Colors.white,
                                elevation: 3.0,
                                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => InforTeacher()),
                                              );
                                            },
                                            child: const CircleAvatar(
                                              radius: 45,
                                              backgroundColor: Colors.blue,
                                              backgroundImage: AssetImage('assets/images/ironman.png'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const InkWell(
                                                    child: Text(
                                                      'Kerran',
                                                      style: TextStyle(
                                                        // fontSize: MediaQuery.of(context).size.width //
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/svg/icon.svg",
                                                        semanticsLabel: 'Logo Icon',
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text("France", style: const TextStyle(fontSize: 16)),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    children: const <Widget>[
                                                      Icon(Icons.star, color: Colors.yellow, size: 15,),
                                                      Icon(Icons.star, color: Colors.yellow,size: 15,),
                                                      Icon(Icons.star, color: Colors.yellow,size: 15,),
                                                      Icon(Icons.star_half, color: Colors.yellow,size: 15,  ),
                                                      Icon(Icons.star_border, color: Colors.yellow,size: 15),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Xử lý khi người dùng bấm vào nút IconButton
                                            },
                                            icon: const Icon( Icons.favorite , color: Colors.blue, size:25),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Wrap(
                                        spacing: 5,
                                        runSpacing: 6,
                                        children: List<Widget>.generate(
                                          testData.length,
                                              (index) => Chip(
                                            label: Text(
                                              testData[index],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            backgroundColor: Colors.lightBlue[100],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Tốt nghiệp Đại Học SaintPeter College chuyên ngành Tiếng Anh và Triết Học loại ưu+ Liên tục 6 lần dành giải vô địch trong cuộc thi CABUSTAM được tổ chức hàng năm giữa 5 thành phố lớn tại Philipines+ Được mệnh danh là “The Legendary Team Warriors” – “Đội chiến binh huyền thoại” khi vô địch trong năm 2009 & 2010 của cuộc thi PRISAA + Bằng IELTS 8.5 với phần thi Speaking đạt 9.0 – điểm số tuyệt đối+ 5 năm kinh nghiệm dạy tiếng Anh giao tiếp và luyện IELTS tại Thái Lan, 3 năm kinh nghiệm luyện IELTS nâng cao tại Việt Nam.+ Thầy Mark là một giáo viên giảng dạy vô cùng nhiệt huyết, luôn sáng tạo linh hoạt trên từng bài giảng, giúp học viên ở mọi trình độ đều có thể dễ dàng thích ứng và nắm bắt kiến thức một cách dễ dàng. Bên cạnh đó, thầy Mark là 1 giáo viên có kinh nghiệm giảng dạy cho nhiều doanh nghiệp lớn tại Hà Nội như : công ty du lịch HIS, phòng giao dịch BIDV, tập đoàn viễn thông Viettel,…Tốt nghiệp Đại Học SaintPeter College chuyên ngành Tiếng Anh và Triết Học loại ưu+ Liên tục 6 lần dành giải vô địch trong cuộc thi CABUSTAM được tổ chức hàng năm giữa 5 thành phố lớn tại Philipines+ Được mệnh danh là “The Legendary Team Warriors” – “Đội chiến binh huyền thoại” khi vô địch trong năm 2009 & 2010 của cuộc thi PRISAA + Bằng IELTS 8.5 với phần thi Speaking đạt 9.0 – điểm số tuyệt đối+ 5 năm kinh nghiệm dạy tiếng Anh giao tiếp và luyện IELTS tại Thái Lan, 3 năm kinh nghiệm luyện IELTS nâng cao tại Việt Nam.+ Thầy Mark là một giáo viên giảng dạy vô cùng nhiệt huyết, luôn sáng tạo linh hoạt trên từng bài giảng, giúp học viên ở mọi trình độ đều có thể dễ dàng thích ứng và nắm bắt kiến thức một cách dễ dàng. Bên cạnh đó, thầy Mark là 1 giáo viên có kinh nghiệm giảng dạy cho nhiều doanh nghiệp lớn tại Hà Nội như : công ty du lịch HIS, phòng giao dịch BIDV, tập đoàn viễn thông Viettel,…',
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.grey, height: 1.6
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: OutlinedButton.icon(
                                          onPressed: () => {},
                                          icon: const Icon(Icons.edit_calendar),
                                          label: const Text('Book'),
                                        ),
                                      )
                                    ],
                                  ),

                                ),

                              )
                          )
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}