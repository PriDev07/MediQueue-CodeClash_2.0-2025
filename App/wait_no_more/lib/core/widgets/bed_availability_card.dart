import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BedAvailabilityCard extends StatelessWidget {
  final String clinicId;

  const BedAvailabilityCard({super.key, required this.clinicId});

  Future<Map<String, dynamic>?> fetchBedSection() async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('clinics')
              .doc(clinicId)
              .get();

      if (doc.exists && doc.data() != null) {
        return doc['bedSection'] as Map<String, dynamic>?;
      }
    } catch (e) {
      ("Error fetching bedSection: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: fetchBedSection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final bedSection = snapshot.data;

        if (bedSection == null) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text("No bed data available")),
          );
        }

        final available = bedSection['available'] ?? 0;
        final occupied = bedSection['occupied'] ?? 0;
        final cleaning = bedSection['cleaning'] ?? 0;
        final bedInfo = bedSection['Bedinfo'] as Map<String, dynamic>? ?? {};

        return Column(
          children: [
            // Summary
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bed Availability",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statusBox(
                        available.toString(),
                        "Available",
                        Colors.green,
                      ),
                      _statusBox(occupied.toString(), "Occupied", Colors.red),
                      _statusBox(
                        cleaning.toString(),
                        "Cleaning",
                        Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Details
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bed Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ...bedInfo.entries.map(
                    (e) => _bedInfoTile(e.key, "${e.value} available"),
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
                    SnackBar(content: Text("Bed request submitted")),
                  );
                },
                icon: Icon(Icons.bed),
                label: Text("Request Bed"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
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

  Widget _statusBox(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _bedInfoTile(String title, String availability) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black12),
            ),
            child: Text(
              availability,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
