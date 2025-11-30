import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/clean_you_can/course/domain/entities/course_entity.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/pages/paymnet_method_page.dart';
import 'package:intl/intl.dart';

class ConfirmEnrollmentPage extends StatefulWidget {
  final String currentStudentId;
  final CourseEntity selcetedCourse;
  const ConfirmEnrollmentPage({
    super.key,
    required this.selcetedCourse,
    required this.currentStudentId,
  });

  @override
  State<ConfirmEnrollmentPage> createState() =>
      _ConfirmEnrollmentPageState();
}

class _ConfirmEnrollmentPageState
    extends State<ConfirmEnrollmentPage> {
  int currentIndex =
      -1; // for selecting the payment method (1 is bank transfare ,2 is palpay and so on )

  bool isAgree =
      false; //for the terms and policy  aggreement checkbox
  // to be clear =>
  // you must check these 2 values  when click on the (complete enrollment button )
  //and check where to ge depends on the current index(selected payment methode)
  // last note the user can go to payment methode page  and return to change payment method if he wants

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 120)),

              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    'Payment',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xFF571874),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Color(0xFFC39BD3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        _buildPaymentPageTexts(
                          widget.selcetedCourse.title,
                          23,
                          FontWeight.bold,
                          Color(0xFF4C1565),
                        ),
                        _buildPaymentPageTexts(
                          "Course Descreption",
                          16,
                          FontWeight.bold,
                          Colors.white,
                        ),
                        Text(
                          widget.selcetedCourse.description,
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xFF571874),
                          ),
                        ),
                        _buildPaymentPageTexts(
                          "Course Details",
                          16,
                          FontWeight.bold,
                          Color(0xFF4C1565),
                        ),
                        _buildRowDetailsPayment([
                          "Duration:",

                          "${widget.selcetedCourse.endDate.difference(widget.selcetedCourse.startDate).inDays ~/ 7} weeks",
                          "Start Date:",
                          "${DateFormat('dd MM yyyy').format(widget.selcetedCourse.startDate)}                      ",
                        ]),
                        _buildRowDetailsPayment([
                          "schedule:",
                          //!(dont forget to make this ,it isnt in the course details)
                          "Flexible / self-paced  ",
                          "Credintial:",
                          //!(dont forget to make this ,it isnt in the course details)
                          "professional Certificate",
                        ]),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Divider(
                            color: Color(0xFF571874),
                            thickness: 1,
                          ),
                        ),
                        _buildPaymentPageTexts(
                          "What You'll Get",
                          18,
                          FontWeight.bold,
                          Color(0xFF4C1565),
                        ),
                        _build_What_You_Get_Row(
                          "Professional Certificates upon completion",
                        ),
                        _build_What_You_Get_Row(
                          "Lifetime access to course materials",
                        ),
                        _build_What_You_Get_Row(
                          "24/7 support from instructors",
                        ),
                        _build_What_You_Get_Row(
                          "Practical projects and case studies",
                        ),
                        _build_What_You_Get_Row(
                          "Flexible learning sceduale",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Card(
                  color: Colors.grey[150],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPaymentPageTexts(
                          "Select Payment Method",
                          18,
                          FontWeight.bold,
                          Color(0xFF4C1565),
                        ),
                        _buildPaymentMethodsCard(
                          "Bank Transfare",
                          "Pay Directly from your bank account",
                          0,
                        ),
                        _buildPaymentMethodsCard(
                          "PalPay",
                          "Pay using your PalPay Account",
                          1,
                        ),
                        _buildPaymentMethodsCard(
                          "Pay at Office",
                          "Pay at our compus location",
                          2,
                        ),
                        _buildPaymentMethodsCard(
                          "Jawwal Pay",
                          "Pay using your Jawwal Pay wallet",
                          3,
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              234,
                              223,
                              247,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                _buildPaymentPageTexts(
                                  "Course Fee Summary",
                                  16,
                                  FontWeight.bold,
                                  Color(0xFF4C1565),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildPaymentPageTexts(
                                      "Course Fee",
                                      17,
                                      FontWeight.normal,
                                      Color(0xFF571874),
                                    ),
                                    Text(
                                      "\$ ${widget.selcetedCourse.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildPaymentPageTexts(
                                      "enrollment Fee",
                                      17,
                                      FontWeight.normal,
                                      Color(0xFF571874),
                                    ),
                                    Text(
                                      "\$ 0.99 ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(thickness: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildPaymentPageTexts(
                                      "Total Fee",
                                      17,
                                      FontWeight.normal,
                                      Color(0xFF571874),
                                    ),
                                    Text(
                                      "\$ ${widget.selcetedCourse.price + 0.99} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: isAgree,
                              onChanged: (value) {
                                setState(() {
                                  isAgree = value!;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(text: "I agree to the "),
                                    TextSpan(
                                      text: "Terms and Conditions",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate to show terms conditions
                                            },
                                    ),
                                    TextSpan(text: " & "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      recognizer:
                                          TapGestureRecognizer()
                                            ..onTap = () {
                                              // Navigate show policy conditions
                                            },
                                    ),
                                    TextSpan(
                                      text:
                                          ".\nI understand that by submitting this form\nI am committing to the payment plan selected above.",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF571874),
                          ),
                          onPressed: () {
                            //! evry condition here have it own event or you can make it with one event but it has parameter called index ()
                            if (isAgree && currentIndex != -1) {
                              //! notification event
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => PaymentMethodPage(
                                        centerId:
                                            widget
                                                .selcetedCourse
                                                .centerId,
                                        currentStudentUid:
                                            widget.currentStudentId,
                                        currentCourseUid:
                                            widget
                                                .selcetedCourse
                                                .courseId,
                                        currentCourseName:
                                            widget
                                                .selcetedCourse
                                                .title,
                                      ),
                                ),
                              );
                              //! here put the event for the student to enroll the course but ud depends
                              if (currentIndex == 0) {
                                //! here means student want to pay with bank transfare(first selection)
                              } else if (currentIndex == 1) {
                                //! here means student want to pay with PalPay
                                //! back here
                              } else if (currentIndex == 2) {
                                //! here means student want to pay with Pay At Office
                              } else {
                                //! here means student want to pay with Pay with Jawwal Pay
                              }
                            } else if (!isAgree) {
                              _buildSnackBar(
                                "you must agree in terms and conditions",
                              );
                            } else {
                              _buildSnackBar(
                                "please choose a payment method",
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text("Complete Enrollment"),
                              SizedBox(width: 2),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/course_detail_top_shape.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Positioned(
                  top: 45,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_sharp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/images/course_detail_bottom_shape.png",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  //**************************************************************************************************************************************************!
  void _buildSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        content: Text(content),
      ),
    );
  }

  Card _buildPaymentMethodsCard(
    String title,
    String subtitle,
    int index,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
            border:
                currentIndex == index
                    ? Border.all(
                      color: const Color.fromARGB(255, 162, 118, 245),
                      width: 3,
                    )
                    : null,
            borderRadius: BorderRadius.circular(10),
            color:
                currentIndex == index
                    ? Color(0xFFC39BD3)
                    : Colors.grey[150],
          ),
          width: double.infinity,
          duration: Duration(milliseconds: 100),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPaymentPageTexts(
                      title,
                      16,
                      FontWeight.bold,
                      Color(0xFF4C1565),
                    ),
                    if (currentIndex == index)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color.fromARGB(
                            255,
                            162,
                            118,
                            245,
                          ),

                          child: Icon(
                            _getIconForIndex(index),
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3),
                _buildPaymentPageTexts(
                  subtitle,
                  13,
                  FontWeight.w500,
                  Color(0xFF571874).withOpacity(0.76),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding _build_What_You_Get_Row(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(width: 15),
          Icon(Icons.done, color: Colors.white),
          SizedBox(width: 5),
          Text(title, style: TextStyle(color: Color(0xFF4C1565))),
        ],
      ),
    );
  }

  Row _buildRowDetailsPayment(List<String> headers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headers[0],
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                headers[1],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C1565),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headers[2],
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                headers[3],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C1565),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.payment_outlined;
      case 1:
        return Icons.house_sharp;
      case 2:
        return Icons.person_outline;
      case 3:
        return Icons.settings;
      default:
        return Icons.help_outline;
    }
  }

  Padding _buildPaymentPageTexts(
    String title,
    double size,
    FontWeight fontWieht,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWieht,
          color: color,
        ),
      ),
    );
  }
}
