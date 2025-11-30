import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_event.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/bloc/student_bloc/student_state.dart';

class PaymentMethodPage extends StatefulWidget {
  final String centerId;
  final String currentStudentUid;
  final String currentCourseUid;
  final String currentCourseName;
  const PaymentMethodPage({
    super.key,
    required this.centerId,
    required this.currentCourseUid,
    required this.currentStudentUid,
    required this.currentCourseName,
  });

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  @override
  void initState() {
    super.initState();

    // Trigger event once
    context.read<StudentBloc>().add(
      EnrollInCourseEvent(
        centerId: widget.centerId,
        studentUid: widget.currentStudentUid,
        courseName: widget.currentCourseName,
        courseUid: widget.currentCourseUid,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentRefreshState) {
            Navigator.pop(context); //back to pay details
            Navigator.pop(context); //back to course details
            Navigator.pop(
              context,
            ); //back to pay available courses page
            //! better to use Navigator.popUntil ,,, ghapi
            _buildSnackBar("done paying");
          }
        },
        builder: (context, state) {
          if (state is StudentLoadingState) {
            return const Center(
              child: Center(
                child: SpinKitFadingCube(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            );
          } else if (state is StudentExceptionState) {
            return Center(child: Text(state.message.toString()));
          } else {
            return const Center(child: Text("Processing payment..."));
          }
        },
      ),
    );
  }

  void _buildSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        backgroundColor: Colors.green,
        content: Text(content),
      ),
    );
  }
}
