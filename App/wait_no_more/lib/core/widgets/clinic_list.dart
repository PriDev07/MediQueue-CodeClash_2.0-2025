import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wait_no_more/services/firestore_service.dart';
import 'package:wait_no_more/core/widgets/clinic_card.dart';

class ClinicsList extends StatefulWidget {
  @override
  _ClinicsListState createState() => _ClinicsListState();
}

class _ClinicsListState extends State<ClinicsList> {
  final FirestoreService _firestoreService = FirestoreService();

  late Future<List<Clinic>> _futureClinics;

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  void _loadClinics() {
    _futureClinics = _firestoreService.getClinics();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadClinics();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Clinic>>(
      future: _futureClinics,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No clinics found."));
        }

        final clinics = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: clinics.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final clinic = clinics[index];
            return ClinicCard(clinic: clinic);
          },
        );
      },
    );
  }
}
