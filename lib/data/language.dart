class Language {
  // Login Text
  String? id;
  Language({
    this.id,
  });
  String? get getId => id;
  String get email => getId =="vi-Vn"? 'Địa chỉ email' : 'Email';
  String get loading => id =="vi-Vn"? 'Đang tải': "Loading";
  String get cancel => getId =="vi-Vn"? 'Hủy' : 'Cancel';
  String get Submit => getId =="vi-Vn"? 'Nộp' : 'Submit';
  String get noData => getId =="vi-Vn"? 'Không có dữ liệu' : 'NO DATA';



  //Login,Register,Forgot
  String get password => id =="vi-Vn"? 'Mật khẩu': "Password";
  String get confirmPassword => id =="vi-Vn"? 'Nhập lại mật khẩu': "Confirm Password";
  String get forgotPassword =>id =="vi-Vn"? 'Quên mật khẩu?':"Forgot Password?";
  String get buttonLogin =>id =="vi-Vn"? 'ĐĂNG NHẬP':"LOGIN";
  String get login =>id =="vi-Vn"? 'Đăng nhập':"login";
  String get orContinue =>id =="vi-Vn"? 'Hoặc tiếp tục với':"Or continue with";
  String get registerQuestion =>id =="vi-Vn"? 'Chưa có tài khoản?': "Not a member yet?";
  String get register =>id =="vi-Vn"? 'Đăng ký': "Sign up";
  String get buttonRegister =>id =="vi-Vn"? 'Đăng ký': "Register";
  String get alreadyAccount => id =="vi-Vn"?'Đã có tài khoản?':"Already have an account?";
  String get forgotPass => id =="vi-Vn"?'Quên mật khẩu':"Forgot password";
  String get stringForgot => id =="vi-Vn"?'Vui lòng nhập email để tìm kiếm tài khoản của bạn.':"Enter your email address and we will send you a link to reset your password";
  String get buttonForgotPass => id =="vi-Vn"?'Xác nhận':"Send reset link";

  String get invalidEmail => 'Email phải có dạng abc@example.com';
  String get emptyEmail => 'Vui lòng nhập Email';
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';
  String get emptyPassword => 'Vui lòng nhập mật khẩu';
  String get registerSuccess => 'Tạo tài khoản thành công';
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  //Homepage
  String get recommendedTutors => getId =="vi-Vn"? 'Gia sư được đề xuất' : 'Recommended Tutors';
  String get Upcoming => getId =="vi-Vn"? 'Buổi học sắp diễn ra' : 'Upcoming lesson';
  String get Totallessontime => getId =="vi-Vn"? 'Tổng số giờ bạn đã học là' : 'Total lesson time is';
  String get seeAll => getId =="vi-Vn"? 'Xem tất cả' : 'See all';
  String get book => getId =="vi-Vn"? 'Đặt lịch' : 'Book';
  String get youHaveNotAttended => getId =="vi-Vn"? 'Bạn chưa tham gia lớp học nào' : 'You have not attended any class';
  String get ResetFilters => getId =="vi-Vn"? 'Đặt lại bộ tìm kiếm' : 'Reset Filters';
  String get enterTutorName => getId =="vi-Vn"? 'Nhập tên giáo sư' : 'Enter tutor name';
  String get selectNatio => getId =="vi-Vn"? 'Chọn quốc tịch ' : 'Select nationality';
  String get join => getId =="vi-Vn"? 'Tham gia lớp học' : 'Enter lesson room';


  //Infor teacher
  String get InforTeacher => getId =="vi-Vn"? 'Thông tin gia sư' : 'Information Teacher';
  String get languages => getId =="vi-Vn"? 'Ngôn ngữ' : 'Languages';
  String get specialties => getId =="vi-Vn"? 'Chuyên ngành' : 'Specialties';
  String get interests => getId =="vi-Vn"? 'Sở thích' : 'Intereste';
  String get experience => getId =="vi-Vn"? 'Kinh nghiệm giảng dạy' : 'Teaching experience';
  String get Suggested => getId =="vi-Vn"? 'Khóa học tham khảo' : 'Suggested courses';
  String get favorite => getId =="vi-Vn"? 'Yêu thích' : 'Favorite';
  String get review => getId =="vi-Vn"? 'Xem đánh giá' : 'Review';
  String get report => getId =="vi-Vn"? 'Báo cáo' : 'Report';
  String get otherReview => getId =="vi-Vn"? 'Tất cả đánh giá' : 'Other review';
  String get dayAgo => getId =="vi-Vn"? 'ngày trước' : 'days ago';

  //Report
  String get helpUs => getId =="vi-Vn"? 'Bạn đang gặp phải vấn đề gì' : 'Help us understand what happening';
  String get tutor1 => getId =="vi-Vn"? 'Gia sư này làm phiền tôi' : 'days ago';
  String get tutor2 => getId =="vi-Vn"? 'Hồ sơ này là giả mạo' : 'days ago';
  String get tutor3 => getId =="vi-Vn"? 'Ảnh hồ sơ không phù hợp' : 'days ago';
  String get tutorContent => getId =="vi-Vn"? 'Vui lòng cho chúng tôi biết chi tiết về vấn đề của bạn' : 'Please let us know details about your problems';

  //Schedule
  String get schedule => getId =="vi-Vn"? 'Lịch đã đặt' : 'Schedule';
  String get content1 => getId =="vi-Vn"? 'Đây là danh sách những khung giờ bạn đã đặt' : 'Here is a list of the sessions you have booked';
  String get content2 => getId =="vi-Vn"? 'Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.' :
  'You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours';
    //Card Schedule
  String get lessons => getId =="vi-Vn"? 'buổi học' : 'lesson';
  String get consecutiveLessons => getId =="vi-Vn"? 'buổi học liên tục' : 'consecutive lessons';
  String get DirectMess => getId =="vi-Vn"? 'Nhắn tin' : 'Direct Message';
  String get EditRequest => getId =="vi-Vn"? 'Chỉnh sử yêu cầu' : 'Edit Request';
  String get RequestForLesson => getId =="vi-Vn"? 'Yêu cầu buổi học' : 'Request for lesson';
  String get goToMeet => getId =="vi-Vn"? 'Vào buổi học' : 'go to meeting';
  String get contentCardSchedule => getId =="vi-Vn"? 'Hiện tại không có yêu cầu cho lớp học này. Xin vui lòng viết ra bất kỳ yêu cầu nào cho giáo viên nếu có.'
      : 'Current there are no requests for this class. Please write down any request for the teacher';

  //history
  String get history => getId =="vi-Vn"? 'Lịch sử các buổi học' : 'History';
  String get contentHistory1 => getId =="vi-Vn"? 'Đây là danh sách các bài học bạn đã tham gia' : 'The following is a list of lessons you have attended';
  String get contentHistory2 => getId =="vi-Vn"? 'Đây là danh sách các bài học bạn đã tham gia' :
  'The following is a list of lessons you have attended';

  //course
  String get course => getId =="vi-Vn"? 'Khám phá các khóa học' : 'Discover Courses';
  String get contentCourse1 => getId =="vi-Vn"? 'LiveTutor đã xây dựng nên các khóa học của các lĩnh vực trong cuộc sống chất lượng, bài bản và khoa học nhất cho những người đang có nhu cầu trau dồi thêm kiến thức về các lĩnh vực.'
      : 'LiveTutor has built the most quality, methodical and scientific courses in the fields of life for those who are in need of improving their knowledge of the fields.';
  String get level => getId =="vi-Vn"? 'Chọn cấp độ' : 'Select level';
  String get category => getId =="vi-Vn"? 'Chọn danh mục' : 'select category';
  String get sort => getId =="vi-Vn"? 'Sắp xếp theo độ khó' : 'sort by level';
  String get nameCourse => getId =="vi-Vn"? 'Khóa học' : 'Course';







}