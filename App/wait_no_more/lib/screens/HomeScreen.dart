import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/core/widgets/clinic_card.dart';
import 'package:wait_no_more/core/widgets/clinic_list.dart';
import 'package:wait_no_more/core/widgets/home_top.dart';
import 'package:wait_no_more/providers/clinicProvider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
void dispose() {
  context.read<ClinicProvider>().disposeProvider(); // Clean up stream
  super.dispose();
}

  Future<void> _refresh() async {

    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeTop(),
              ClinicsList(),
            ],
          ),
        ),
      ),
    );
  }
}
