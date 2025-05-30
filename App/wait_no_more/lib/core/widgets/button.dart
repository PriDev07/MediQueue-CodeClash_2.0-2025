import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/screens/Details/details_main_screen.dart';

class Buttoncard extends StatelessWidget {
  final String value;
  final VoidCallback? onPressed;
  final String Clinicid;

  Buttoncard({super.key, required this.value, this.onPressed,required this.Clinicid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onPressed ??
          () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailsMainScreen(clinicId: Clinicid)),
            );
          },
      child: Container(
        margin: EdgeInsets.all(16.sp),
        padding: EdgeInsets.all(12.sp),
        width: 95.sp,
        decoration: BoxDecoration(
          color: AppColors.blue600,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
