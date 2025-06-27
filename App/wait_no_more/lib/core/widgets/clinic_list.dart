import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wait_no_more/core/widgets/clinic_card.dart';
import 'package:wait_no_more/providers/clinicProvider.dart';

class ClinicsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clinics = context.watch<ClinicProvider>().clinics; // ✅ This is now the filtered list

    if (clinics.isEmpty) {
      return Center(child: Text("No clinics found."));
    }

    return ListView.builder(
      itemCount: clinics.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final clinic = clinics[index];
        return ClinicCard(clinic: clinic);
      },
    );
  }
}
