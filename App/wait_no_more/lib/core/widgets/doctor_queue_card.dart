import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class DoctorQueueCard extends StatelessWidget {
  final Clinic clinic;
  const DoctorQueueCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: 43.w,
      decoration: BoxDecoration(
        color: AppColors.blue100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outlined,
                size: 20.sp,
                color: AppColors.blue600,
              ),
              SizedBox(width: 1.w),
              Text(
                "Doctor Queue",
                style: TextStyle(
                  color: AppColors.blue600,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          Padding(
            padding: EdgeInsets.only(left: 0.9.w),
            child: Text(
              "#${clinic.tokensProvided}",
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.blue600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 0.5.h),
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 20.sp,
                color: AppColors.blue600,
              ),
              SizedBox(width: 1.w),
              Text(
                "45 min wait",
                style: TextStyle(
                  color: AppColors.blue600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
