import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ========== WRITE OPERATIONS ==========

/// Save user data to Firestore during registration
Future<void> saveUserToFirestore(User user, {String? fullName, String? location}) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'uid': user.uid,
    'email': user.email,
    'phone': user.phoneNumber,
    'name': fullName ?? user.displayName ?? '',
    'location': location ?? '',
    'profilePhotoUrl': user.photoURL ?? '',
    'emailVerified': user.emailVerified,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
  print('User ${user.uid} saved to Firestore successfully');
}

/// Add a new user with custom data
Future<void> addUser(String uid, String name, String email, {String? phone, String? location}) async {
  return FirebaseFirestore.instance.collection('users').doc(uid).set({
    'name': name,
    'email': email,
    'phone': phone,
    'location': location,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

/// Update user profile data
Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
  data['updatedAt'] = FieldValue.serverTimestamp();
  return FirebaseFirestore.instance.collection('users').doc(uid).update(data);
}

/// Add a service booking
Future<String> addServiceBooking({
  required String userId,
  required String serviceType,
  required String description,
  required DateTime scheduledDate,
  required String location,
  String status = 'pending',
}) async {
  DocumentReference docRef = await FirebaseFirestore.instance.collection('bookings').add({
    'userId': userId,
    'serviceType': serviceType,
    'description': description,
    'scheduledDate': Timestamp.fromDate(scheduledDate),
    'location': location,
    'status': status,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
  return docRef.id;
}

/// Update booking status
Future<void> updateBookingStatus(String bookingId, String status) async {
  return FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
    'status': status,
    'updatedAt': FieldValue.serverTimestamp(),
  });
}

// ========== READ OPERATIONS ==========

/// Get all users as a stream (real-time updates)
Stream<QuerySnapshot> getUsers() {
  return FirebaseFirestore.instance
      .collection('users')
      .orderBy('createdAt', descending: true)
      .snapshots();
}

/// Get a specific user by ID
Future<DocumentSnapshot> getUserById(String uid) {
  return FirebaseFirestore.instance.collection('users').doc(uid).get();
}

/// Get user data as a stream for real-time updates
Stream<DocumentSnapshot> getUserStream(String uid) {
  return FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
}

/// Get all bookings for a specific user
Stream<QuerySnapshot> getUserBookings(String userId) {
  return FirebaseFirestore.instance
      .collection('bookings')
      .where('userId', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots();
}

/// Get bookings by status
Stream<QuerySnapshot> getBookingsByStatus(String status) {
  return FirebaseFirestore.instance
      .collection('bookings')
      .where('status', isEqualTo: status)
      .orderBy('createdAt', descending: true)
      .snapshots();
}

/// Get all bookings (for admin/service provider view)
Stream<QuerySnapshot> getAllBookings() {
  return FirebaseFirestore.instance
      .collection('bookings')
      .orderBy('createdAt', descending: true)
      .snapshots();
}

/// Search users by name or email
Stream<QuerySnapshot> searchUsers(String searchTerm) {
  return FirebaseFirestore.instance
      .collection('users')
      .where('name', isGreaterThanOrEqualTo: searchTerm)
      .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
      .snapshots();
}

// ========== USER PROFILE OPERATIONS ==========

/// Get current user's profile data
Future<Map<String, dynamic>?> getCurrentUserProfile() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) return null;
  
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser.uid)
      .get();
  
  if (doc.exists) {
    return doc.data() as Map<String, dynamic>;
  }
  return null;
}

/// Check if user profile exists in Firestore
Future<bool> userProfileExists(String uid) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
  return doc.exists;
}
