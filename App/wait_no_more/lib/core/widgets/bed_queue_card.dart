import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class BedQueueCard extends StatelessWidget {
  final Clinic clinic;
  const BedQueueCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      width: 43.w,
      decoration: BoxDecoration(
        color: AppColors.green50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.bed_sharp, size: 20.sp, color: AppColors.green600),
              SizedBox(width: 1.w),
              Text(
                "Bed Queue",
                style: TextStyle(
                  color: AppColors.green600,
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
              "${clinic.bedSection['available']}",
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.green600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 0.5.h),
          SizedBox(width: 1.w),
          Text(
            "beds available",
            style: TextStyle(
              color: AppColors.green600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
