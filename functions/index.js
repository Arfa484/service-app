const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.onNewBooking = functions.firestore
    .document("bookings/{bookingId}")
    .onCreate(async (snap, context) => {
      const booking = snap.data();

      // Get provider's userId
      const providerId = booking.providerId;

      // Fetch provider's FCM token from Firestore
      const providerDoc = await admin.firestore().
          collection("users").doc(providerId).get();
      const token = providerDoc.data().fcmToken;

      if (token) {
        const payload = {
          notification: {
            title: "New Booking Request",
            body: `You have a booking from ${booking.customerName}`,
          },
        };
        await admin.messaging().sendToDevice(token, payload);
      }
    });
