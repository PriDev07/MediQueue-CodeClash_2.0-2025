import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class CurrentStatusCard extends StatefulWidget {
  final String clinicId;
  const CurrentStatusCard({super.key, required this.clinicId});

  @override
  State<CurrentStatusCard> createState() => _CurrentStatusCardState();
}

class _CurrentStatusCardState extends State<CurrentStatusCard> {
  late Future<int?> _futureStatus;

  @override
  void initState() {
    super.initState();
    _futureStatus = fetchCurrentStatus();
  }

  Future<int?> fetchCurrentStatus() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('clinics')
              .doc(widget.clinicId)
              .get();

      ("Fetched document: ${doc.data()}");

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['currentStatus'] is int
            ? data['currentStatus']
            : int.tryParse(data['currentStatus'].toString());
      }
    } catch (e) {
      ("Error fetching currentStatus: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _futureStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingContainer();
        }

        if (snapshot.hasError) {
          return _buildErrorContainer("Error: ${snapshot.error}");
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return _buildErrorContainer("Unable to fetch current status");
        }

        int currentStatus = snapshot.data!;
        return _buildCard(currentStatus);
      },
    );
  }

  Widget _buildLoadingContainer() {
    return Container(
      width: 95.w,
      height: 15.h,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildErrorContainer(String message) {
    return Container(
      width: 95.w,
      height: 15.h,
      alignment: Alignment.center,
      child: Text(message),
    );
  }

  Widget _buildCard(int currentStatus) {
    return Container(
      width: 95.w,
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
      decoration: BoxDecoration(
        color: AppColors.blue100,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: AppColors.borderBlue200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Text(
            "Current Status",
            style: TextStyle(
              color: AppColors.blue800,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Token #$currentStatus",
                    style: TextStyle(
                      color: AppColors.blue600,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Currently being Served",
                    style: TextStyle(
                      color: AppColors.blue500,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "45 Min",
                    style: TextStyle(
                      color: AppColors.blue800,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Estimated wait",
                    style: TextStyle(
                      color: AppColors.blue500,
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
