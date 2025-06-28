import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class DoctorQueueWidget extends StatefulWidget {
  final String clinicId;
  const DoctorQueueWidget({super.key, required this.clinicId});

  @override
  State<DoctorQueueWidget> createState() => _DoctorQueueWidgetState();
}

class _DoctorQueueWidgetState extends State<DoctorQueueWidget> {
  Map<String, dynamic>? doctorsData;
  Map<String, int> userTokens = {}; // Store "Your Token" per doctor

  Future<void> fetchDoctors() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('clinics')
              .doc(widget.clinicId)
              .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        final doctors = Map<String, dynamic>.from(data['doctors']);
        setState(() {
          doctorsData = doctors;
        });
      }
    } catch (e) {
      debugPrint("Error fetching doctors: $e");
    }
  }

  Future<void> requestToken(String doctorId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('clinics')
          .doc(widget.clinicId);

      // Increment TokensProvided
      await docRef.update({
        "doctors.$doctorId.TokensProvided": FieldValue.increment(1),
      });

      // Re-fetch to get latest tokens
      await fetchDoctors();

      final doctor = Map<String, dynamic>.from(doctorsData![doctorId]);
      final tokensProvided = doctor['TokensProvided'] ?? 0;
      final tokensServed = doctor['TokensServed'] ?? 0;

      // Calculate user token
      final yourToken = tokensProvided - tokensServed;

      // Save in local map
      setState(() {
        userTokens[doctorId] = yourToken;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Your token #$yourToken for ${doctor['Name']} has been generated.",
          ),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      debugPrint("Error requesting token: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error booking token.")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  @override
  Widget build(BuildContext context) {
    if (doctorsData == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children:
          doctorsData!.entries.map((entry) {
            final doctorId = entry.key;
            final doctor = Map<String, dynamic>.from(entry.value);

            final isAvailable = doctor['availaibility'] == true;
            final cardColor = isAvailable ? Colors.green[100] : Colors.red[100];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: cardColor,
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Icon
                    CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          isAvailable ? Colors.green[300] : Colors.red[300],
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    SizedBox(width: 4.w),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. ${doctor['Name']}" ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color:
                                  isAvailable
                                      ? Colors.green[900]
                                      : Colors.red[900],
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "Department: ${doctor['department'] ?? 'N/A'}",
                            style: TextStyle(
                              color:
                                  isAvailable
                                      ? Colors.green[900]
                                      : Colors.red[900],
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          if (isAvailable)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green[800],
                                side: BorderSide(color: Colors.green),
                              ),
                              onPressed: () => requestToken(doctorId),
                              child: Text("Request Token"),
                            )
                          else
                            Text(
                              "Doctor not available",
                              style: TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          // Show "Your Token" only if user has requested
                          if (userTokens.containsKey(doctorId))
                            Padding(
                              padding: EdgeInsets.only(top: 1.h),
                              child: Text(
                                "Your Token: #${userTokens[doctorId]}",
                                style: TextStyle(
                                  color:
                                      isAvailable
                                          ? Colors.green[900]
                                          : Colors.red[900],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
