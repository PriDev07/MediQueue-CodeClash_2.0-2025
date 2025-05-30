import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/widgets/bed_availability_card.dart';
import 'package:wait_no_more/core/widgets/button.dart';
import 'package:wait_no_more/core/widgets/current_status_card.dart';
import 'package:wait_no_more/core/widgets/details_home_top.dart';
import 'package:wait_no_more/core/widgets/details_switch_widget.dart';
import 'package:wait_no_more/core/widgets/live_queue_card.dart';
import 'package:wait_no_more/core/widgets/your_queue_token_card.dart';

class DetailsMainScreen extends StatefulWidget {
  final String clinicId;

  const DetailsMainScreen({super.key,required this.clinicId});

  @override
  State<DetailsMainScreen> createState() => _DetailsMainScreenState();
}

class _DetailsMainScreenState extends State<DetailsMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetailsHomeTop(clinicId: widget.clinicId),
            SizedBox(height: 2.h),
            DetailsSwitchWidget(clinicId: widget.clinicId),
          ],
        ),
      ),
    );
  }
}
