import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/core/utils/bed_queue_widget.dart';
import 'package:wait_no_more/core/utils/doctor_queue_widget.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class DetailsSwitchWidget extends StatefulWidget {
  final String clinicId;
  const DetailsSwitchWidget({super.key,required this.clinicId});

  @override
  State<DetailsSwitchWidget> createState() => _DetailsSwitchWidgetState();
}

class _DetailsSwitchWidgetState extends State<DetailsSwitchWidget> {
  int selectedIndex = 0; // 0: Doctor Queue, 1: Bed Queue

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle Switch
        Container(
          width: 95.w,
          height: 5.h,
          margin: EdgeInsets.all(14.sp),
          decoration: BoxDecoration(
            color: AppColors.blue100,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Doctor Queue
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          selectedIndex == 0
                              ? AppColors.blue500
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text(
                      "Doctor Queue",
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              // Bed Queue
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          selectedIndex == 1
                              ? AppColors.green500
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: Text(
                      "Bed Queue",
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Conditional Content Based on Selection
        if (selectedIndex == 0) DoctorQueueWidget(clinicId: widget.clinicId) else BedQueueWidget(clinicId: widget.clinicId),
      ],
    );
  }
}
