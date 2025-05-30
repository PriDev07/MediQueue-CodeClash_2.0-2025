import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class DetailsHomeTop extends StatelessWidget {
  final String clinicId;
  const DetailsHomeTop({super.key, required this.clinicId});

  Future<Map<String, dynamic>?> fetchClinicDetails() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('clinics')
              .doc(clinicId)
              .get();
      return doc.data();
    } catch (e) {
      ("Error fetching clinic data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchClinicDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 20.h,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Container(
            height: 20.h,
            alignment: Alignment.center,
            child: Text(
              "Clinic not found",
              style: TextStyle(color: Colors.white),
            ),
            color: AppColors.blue500,
          );
        }

        final data = snapshot.data!;
        final name = data['Name'] ?? "Unknown Clinic";
        final location = data['location'] ?? "Unknown Location";

        return Container(
          width: 100.w,
          decoration: BoxDecoration(color: AppColors.blue500),
          padding: EdgeInsets.all(18.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              BackButton(color: Colors.white),
              Text(
                name,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 19.sp,
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop_outlined,
                    size: 20.sp,
                    color: AppColors.gray50,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    "$location * 2.3 km", // You can also fetch distance from user later
                    style: TextStyle(color: AppColors.white),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
            ],
          ),
        );
      },
    );
  }
}
