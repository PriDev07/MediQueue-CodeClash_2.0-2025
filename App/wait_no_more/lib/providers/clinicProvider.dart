import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wait_no_more/services/firestore_service.dart';

class ClinicProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Clinic> _allClinics = [];
  List<Clinic> _filteredClinics = [];
  String _searchQuery = '';

  late StreamSubscription<List<Clinic>> _clinicSubscription;

  List<Clinic> get clinics => _filteredClinics;

  ClinicProvider() {
    _listenToClinics(); // Start real-time Firestore subscription
  }

  /// Listens to real-time clinic updates and filters on data change
  void _listenToClinics() {
    _clinicSubscription = _firestoreService.streamClinics().listen((clinicList) {
      _allClinics = clinicList;
      _applySearch(); // Keep search applied with fresh data
    });
  }

  /// Updates the search query and filters the list
  void updateSearchQuery(String query) {
  _searchQuery = query.toLowerCase();
  _applySearch();
}

void _applySearch() {
  if (_searchQuery.isEmpty) {
    _filteredClinics = _allClinics;
  } else {
    _filteredClinics = _allClinics.where((clinic) {
      return clinic.name.toLowerCase().contains(_searchQuery) ||
             clinic.location.toLowerCase().contains(_searchQuery);
    }).toList();
  }
  notifyListeners(); // 🔁 Must be called
}


  /// Optional: manual refresh logic if needed
  Future<void> refreshClinics() async {
    // Can be used if you want to refetch manually
  }

  /// Clean up the stream when widget is disposed
  void disposeProvider() {
    _clinicSubscription.cancel();
  }
}
