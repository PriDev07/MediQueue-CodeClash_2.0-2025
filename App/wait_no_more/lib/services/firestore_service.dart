import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Clinic>> streamClinics() {
    return _db.collection('clinics').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Clinic.fromFirestore(doc)).toList();
    });
  }
}


class Clinic {
  final String id;
  final String name;
  final String location;
  final double rated;
  final int currentStatus;
  final int tokensProvided;
  final Map<String, dynamic> bedSection; // 👈 Add this

  Clinic({
    required this.id,
    required this.name,
    required this.location,
    required this.rated,
    required this.currentStatus,
    required this.tokensProvided,
    required this.bedSection,
  });

  factory Clinic.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Clinic(
      id: doc.id,
      name: data['Name'] ?? '',
      location: data['location'] ?? '',
      rated:
          (data['Rating'] is int)
              ? (data['Rating'] as int).toDouble()
              : (data['Rating'] ?? 0.0),
      currentStatus: data['currentStatus'],
      tokensProvided: data['TokensProvided'],
      bedSection: data['bedSection'] ?? {},
    );
  }
}
