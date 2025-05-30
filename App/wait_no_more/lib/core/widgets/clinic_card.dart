import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/core/widgets/bed_queue_card.dart';
import 'package:wait_no_more/core/widgets/button.dart';
import 'package:wait_no_more/core/widgets/doctor_queue_card.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: AppColors.white,
        boxShadow: [],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      wordSpacing: -2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.pin_drop_outlined, size: 20.sp),
                      SizedBox(width: 1.w),
                      Text(clinic.location),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star_rate, color: AppColors.yellow500),
                  SizedBox(width: 0.2.h),
                  Text(
                    clinic.rated.toString(),
                    style: TextStyle(color: AppColors.yellow500),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [DoctorQueueCard(clinic:clinic), BedQueueCard(clinic: clinic)],
          ),
          SizedBox(height: 2.h),
          Buttoncard(value: "View Details >", Clinicid: clinic.id,),
        ],
      ),
    );
  }
}
