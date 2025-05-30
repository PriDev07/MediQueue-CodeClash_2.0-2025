import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/widgets/button.dart';
import 'package:wait_no_more/core/widgets/current_status_card.dart';
import 'package:wait_no_more/core/widgets/live_queue_card.dart';
import 'package:wait_no_more/core/widgets/your_queue_token_card.dart';

class DoctorQueueWidget extends StatefulWidget {
  final String clinicId;
  const DoctorQueueWidget({super.key, required this.clinicId});

  @override
  State<DoctorQueueWidget> createState() => _DoctorQueueWidgetState();
}

class _DoctorQueueWidgetState extends State<DoctorQueueWidget> {
  bool showQueueTokenCard = false;
  int? nextToken;

  Future<void> fetchNextToken() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('clinics')
              .doc(widget.clinicId)
              .get();

      if (doc.exists && doc.data() != null) {
        int tokensProvided = doc['TokensProvided'] ?? 0;
        setState(() {
          nextToken = tokensProvided + 1;
        });
      }
    } catch (e) {
      ("Error fetching tokensProvided: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNextToken(),
      builder: (context, snapshot) {
        // Optional: show loading state
        if (nextToken == null) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            CurrentStatusCard(clinicId: widget.clinicId),
            if (showQueueTokenCard && nextToken != null)
              YourQueueTokenCard(tokenNumber: nextToken!),
            LiveQueueCard(clinicId: widget.clinicId),
            if (!showQueueTokenCard)
              Buttoncard(
                value: "Book Token",
                onPressed: () async {
                  try {
                    final docRef = FirebaseFirestore.instance
                        .collection('clinics')
                        .doc(widget.clinicId);

                    // Atomically increment the TokensProvided
                    await docRef.update({
                      'TokensProvided': FieldValue.increment(1),
                    });

                    // Fetch updated token
                    await fetchNextToken();

                    setState(() {
                      showQueueTokenCard = true;
                    });

                    // Show snackbar at bottom
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Your token #$nextToken has been generated',
                        ),
                        duration: Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } catch (e) {
                    ("Error: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error booking token.")),
                    );
                  }
                },
                Clinicid: widget.clinicId,
              ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}
