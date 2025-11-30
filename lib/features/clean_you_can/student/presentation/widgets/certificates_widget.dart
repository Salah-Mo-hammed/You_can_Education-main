import 'package:flutter/material.dart';
import 'package:grad_project_ver_1/features/clean_you_can/student/presentation/widgets/common_widgets.dart';

class CertificatesWidget extends StatelessWidget {
  const CertificatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 100)),
        SliverToBoxAdapter(
          child: Center(
            child: CommonWidgets().buildHeaderText(
              "Certificates",
              true,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: CommonWidgets().buildSubTitleText(
              "Your achievements and completed courses",
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return CommonWidgets().buildStack(true);
          }, childCount: 5),
        ),
      ],
    );
  }
}
