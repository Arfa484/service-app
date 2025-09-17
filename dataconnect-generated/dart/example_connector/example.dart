import 'package:cloud_firestore/cloud_firestore.dart';

class ExampleConnector {
  // Private constructor so nobody can accidentally create instances
  ExampleConnector._();

  // Firestore instance (single reference across the app)
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Getter to use Firestore anywhere
  static FirebaseFirestore get instance => _firestore;
}
