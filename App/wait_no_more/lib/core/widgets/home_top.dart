import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class HomeTop extends StatelessWidget {
  const HomeTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.blue500),
      padding: EdgeInsets.all(18.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 7.h),
          Text(
            "MediQueue",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            "Find nearby clinics and skip the wait",
            style: TextStyle(color: AppColors.gray50, fontSize: 17.sp),
          ),
          SizedBox(height: 2.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(color: AppColors.gray400),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search clinics by name or city ....",
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.only(top: 1.1.h),
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
