import 'package:flutter/material.dart';
import 'package:wait_no_more/core/constants/color_constants.dart';
import 'package:wait_no_more/core/widgets/clinic_card.dart';
import 'package:wait_no_more/core/widgets/clinic_list.dart';
import 'package:wait_no_more/core/widgets/home_top.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Future<void> _refresh() async {
    // You can perform any refresh logic here.
    // For example, fetching new data from API, or resetting state.

    // Just simulating a network call delay here.
    await Future.delayed(const Duration(seconds: 1));

    // Then call setState to rebuild UI if necessary
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensure scroll works even if content less
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
