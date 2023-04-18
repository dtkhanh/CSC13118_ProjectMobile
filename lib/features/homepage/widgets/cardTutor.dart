import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/appSizes.dart';
import '../../../data/data.dart';
import '../../view_information/teacher_info/InformationTeacher.dart';


class CardTutor extends StatefulWidget {
  const CardTutor({Key? key}) : super(key: key);
  @override
  State<CardTutor> createState() => _CardTutorStage();

}

class _CardTutorStage extends State<CardTutor> {
  int chosenFilter = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                                        fontSize: Sizes.p20,
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
                                      gapW4,
                                      const Text("France", style: TextStyle(fontSize: Sizes.p16)),
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
                      gapH12,
                      Wrap(
                        spacing: 5,
                        runSpacing: 4,
                        children: List<Widget>.generate(
                          testData.length,
                              (index) =>
                                  Chip(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                                    backgroundColor: Colors.lightBlue[100],
                                    label: Text( testData[index], style: TextStyle( color:  Colors.blue[700], fontSize: Sizes.p12),
                                    ),
                                  ),
                        ),
                      ),
                      gapH12,
                      const Text(
                        'Tốt nghiệp Đại Học SaintPeter College chuyên ngành Tiếng Anh và Triết Học loại ưu+ Liên tục 6 lần dành giải vô địch trong cuộc thi CABUSTAM được tổ chức hàng năm giữa 5 thành phố lớn tại Philipines+ Được mệnh danh là “The Legendary Team Warriors” – “Đội chiến binh huyền thoại” khi vô địch trong năm 2009 & 2010 của cuộc thi PRISAA + Bằng IELTS 8.5 với phần thi Speaking đạt 9.0 – điểm số tuyệt đối+ 5 năm kinh nghiệm dạy tiếng Anh giao tiếp và luyện IELTS tại Thái Lan, 3 năm kinh nghiệm luyện IELTS nâng cao tại Việt Nam.+ Thầy Mark là một giáo viên giảng dạy vô cùng nhiệt huyết, luôn sáng tạo linh hoạt trên từng bài giảng, giúp học viên ở mọi trình độ đều có thể dễ dàng thích ứng và nắm bắt kiến thức một cách dễ dàng. Bên cạnh đó, thầy Mark là 1 giáo viên có kinh nghiệm giảng dạy cho nhiều doanh nghiệp lớn tại Hà Nội như : công ty du lịch HIS, phòng giao dịch BIDV, tập đoàn viễn thông Viettel,…Tốt nghiệp Đại Học SaintPeter College chuyên ngành Tiếng Anh và Triết Học loại ưu+ Liên tục 6 lần dành giải vô địch trong cuộc thi CABUSTAM được tổ chức hàng năm giữa 5 thành phố lớn tại Philipines+ Được mệnh danh là “The Legendary Team Warriors” – “Đội chiến binh huyền thoại” khi vô địch trong năm 2009 & 2010 của cuộc thi PRISAA + Bằng IELTS 8.5 với phần thi Speaking đạt 9.0 – điểm số tuyệt đối+ 5 năm kinh nghiệm dạy tiếng Anh giao tiếp và luyện IELTS tại Thái Lan, 3 năm kinh nghiệm luyện IELTS nâng cao tại Việt Nam.+ Thầy Mark là một giáo viên giảng dạy vô cùng nhiệt huyết, luôn sáng tạo linh hoạt trên từng bài giảng, giúp học viên ở mọi trình độ đều có thể dễ dàng thích ứng và nắm bắt kiến thức một cách dễ dàng. Bên cạnh đó, thầy Mark là 1 giáo viên có kinh nghiệm giảng dạy cho nhiều doanh nghiệp lớn tại Hà Nội như : công ty du lịch HIS, phòng giao dịch BIDV, tập đoàn viễn thông Viettel,…',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: Sizes.p12, color: Colors.grey, height: 1.6
                        ),
                      ),
                      gapH12,
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
          );
  }
}