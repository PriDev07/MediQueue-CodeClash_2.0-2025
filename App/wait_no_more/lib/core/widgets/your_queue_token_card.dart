import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class YourQueueTokenCard extends StatelessWidget {
  final int tokenNumber;
  const YourQueueTokenCard({super.key, required this.tokenNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(14.sp),
      width: 95.w,
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      decoration: BoxDecoration(
        color: AppColors.green50,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: AppColors.borderBlue200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Text(
            "Your Token",
            style: TextStyle(
              color: AppColors.green800,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Token $tokenNumber",
                    style: TextStyle(
                      color: AppColors.green600,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Position in queue : 2",
                    style: TextStyle(
                      color: AppColors.green500,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "45 Min",
                    style: TextStyle(
                      color: AppColors.green800,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Estimated wait",
                    style: TextStyle(
                      color: AppColors.green500,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
