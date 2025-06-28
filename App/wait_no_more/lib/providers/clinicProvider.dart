import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wait_no_more/services/firestore_service.dart';
import 'package:geolocator/geolocator.dart';

class ClinicProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Clinic> _allClinics = [];
  List<Clinic> _filteredClinics = [];
  String _searchQuery = '';

  late StreamSubscription<List<Clinic>> _clinicSubscription;

  bool _locationEnabled = false;
  double _maxDistanceMeters = 5000;
  Position? _userPosition;

  List<Clinic> get clinics => _filteredClinics;
  Position? get userPosition => _userPosition;
  bool get locationEnabled => _locationEnabled;

  ClinicProvider() {
    _listenToClinics();
  }

  void _listenToClinics() {
    _clinicSubscription = _firestoreService.streamClinics().listen((
      clinicList,
    ) {
      _allClinics = clinicList;
      _applySearch();
    });
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applySearch();
  }

  Future<void> enableLocationAndSort() async {
    try {
      _userPosition = await _determinePosition();
      _locationEnabled = true;
      _applySearch();
    } catch (e) {
      debugPrint('Location error: $e');
      _locationEnabled = false;
      _applySearch();
    }
  }

  void disableLocationSort() {
    _locationEnabled = false;
    _userPosition = null;
    _applySearch();
  }

  void _applySearch() {
    List<Clinic> tempClinics = _allClinics;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      tempClinics =
          tempClinics.where((clinic) {
            return clinic.name.toLowerCase().contains(_searchQuery) ||
                clinic.location.toLowerCase().contains(_searchQuery);
          }).toList();
    }

    // Sort by distance if location enabled
    if (_locationEnabled && _userPosition != null) {
      tempClinics.sort((a, b) {
        double distA = Geolocator.distanceBetween(
          _userPosition!.latitude,
          _userPosition!.longitude,
          a.loc.latitude,
          a.loc.longitude,
        );
        double distB = Geolocator.distanceBetween(
          _userPosition!.latitude,
          _userPosition!.longitude,
          b.loc.latitude,
          b.loc.longitude,
        );
        return distA.compareTo(distB);
      });
    }

    _filteredClinics = tempClinics;
    notifyListeners();
  }

  Future<void> refreshClinics() async {
    // Optional reload logic
  }

  void disposeProvider() {
    _clinicSubscription.cancel();
  }
}

// Helper
Future<Position> _determinePosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permissions are permanently denied');
  }

  return await Geolocator.getCurrentPosition();
}
