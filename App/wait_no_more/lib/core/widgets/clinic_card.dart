import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/core/widgets/bed_queue_card.dart';
import 'package:wait_no_more/core/widgets/button.dart';
import 'package:wait_no_more/core/widgets/doctor_queue_card.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class ClinicCard extends StatelessWidget {
  final Clinic clinic;
  final Position? userPosition;

  const ClinicCard({super.key, required this.clinic, this.userPosition});

  @override
  Widget build(BuildContext context) {
    String? distanceText;
    if (userPosition != null) {
      final distanceMeters = Geolocator.distanceBetween(
        userPosition!.latitude,
        userPosition!.longitude,
        clinic.loc.latitude,
        clinic.loc.longitude,
      );
      final distanceKm = (distanceMeters / 1000).toStringAsFixed(1);
      distanceText = "$distanceKm km away";
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16.sp),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinic.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.pin_drop_outlined, size: 18.sp),
                        SizedBox(width: 1.w),
                        Flexible(child: Text(clinic.location)),
                      ],
                    ),
                    if (distanceText != null)
                      Row(
                        children: [
                          Icon(
                            Icons.directions_walk,
                            size: 16.sp,
                            color: AppColors.blue600,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            distanceText,
                            style: TextStyle(color: AppColors.blue600),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star_rate, color: AppColors.yellow500),
                  SizedBox(width: 0.5.w),
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
            children: [
              DoctorQueueCard(clinic: clinic),
              BedQueueCard(clinic: clinic),
            ],
          ),
          SizedBox(height: 2.h),
          Buttoncard(value: "View Details >", Clinicid: clinic.id),
        ],
      ),
    );
  }
}
