import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';

class LiveQueueCard extends StatefulWidget {
  final String clinicId;
  const LiveQueueCard({super.key, required this.clinicId});

  @override
  State<LiveQueueCard> createState() => _LiveQueueCardState();
}

class _LiveQueueCardState extends State<LiveQueueCard> {
  List<Map<String, dynamic>> queueData = [];
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchQueue();
  }

  Future<void> fetchQueue() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('clinics')
          .doc(widget.clinicId)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        int currentStatus = data['currentStatus'] ?? 0;
        int tokensProvided = data['TokensProvided'] ?? 0;

        List<Map<String, dynamic>> queue = [];

        for (int i = currentStatus; i <= tokensProvided; i++) {
          queue.add({
            'token': i,
            'status': i == currentStatus ? 'In Progress' : 'Waiting',
            'time': i == currentStatus ? '5 min' : '${(i - currentStatus + 1) * 10} min',
          });
        }

        setState(() {
          queueData = queue;
          isLoading = false;
        });
      } else {
        setState(() {
          error = "Clinic data not found.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Failed to load queue: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(child: Text(error));
    }

    return Container(
      margin: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        border: Border.all(color: AppColors.gray400),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Live Queue",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              children: queueData.map((item) => QueueItem(data: item)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}


class QueueItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const QueueItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              data['token'].toString(),
              style: TextStyle(
                color: Colors.blue.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Token #${data['token']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  data['status'],
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Text(data['time'], style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
