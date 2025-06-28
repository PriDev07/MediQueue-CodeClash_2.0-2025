import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wait_no_more/core/widgets/clinic_card.dart';
import 'package:wait_no_more/providers/clinicProvider.dart';

class ClinicsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clinicsProvider = context.watch<ClinicProvider>();
    final clinics = clinicsProvider.clinics;
    final userPosition = clinicsProvider.userPosition;
    final locationEnabled = clinicsProvider.locationEnabled;

    if (clinics.isEmpty) {
      return Center(child: Text("No clinics found."));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Sort by nearest"),
            Switch(
              value: locationEnabled,
              onChanged: (value) async {
                if (value) {
                  await clinicsProvider.enableLocationAndSort();
                } else {
                  clinicsProvider.disableLocationSort();
                }
              },
            ),
          ],
        ),
        ListView.builder(
          itemCount: clinics.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final clinic = clinics[index];
            return ClinicCard(clinic: clinic, userPosition: userPosition);
          },
        ),
      ],
    );
  }
}
