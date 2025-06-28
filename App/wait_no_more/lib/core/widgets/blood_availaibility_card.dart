import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BloodAvailabilityCard extends StatelessWidget {
  final String clinicId;

  const BloodAvailabilityCard({super.key, required this.clinicId});

  Future<Map<String, dynamic>?> fetchBloodBankData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('clinics')
          .doc(clinicId)
          .get();

      if (doc.exists && doc.data() != null) {
        return doc['bloodBank'] as Map<String, dynamic>?;
      }
    } catch (e) {
      print("Error fetching blood bank data: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchBloodBankData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final bloodBank = snapshot.data;

        if (bloodBank == null || bloodBank.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text("No blood data available")),
          );
        }

        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Blood Availability",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: bloodBank.entries.map((e) {
                      return _bloodTypeBox(e.key, e.value.toString());
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Blood request submitted")),
                  );
                },
                icon: Icon(Icons.water_drop),
                label: Text("Request Blood"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _bloodTypeBox(String type, String units) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.red.shade100),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Text(
            type,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "$units units",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
