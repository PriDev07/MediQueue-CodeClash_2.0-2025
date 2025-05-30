import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/widgets/bed_availability_card.dart';
import 'package:wait_no_more/core/widgets/details_home_top.dart';

class BedQueueWidget extends StatelessWidget {
  final String clinicId;
  const BedQueueWidget({super.key,required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [BedAvailabilityCard(clinicId: clinicId), SizedBox(height: 10.h)],
      ),
    );
  }
}
