// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:cloud_functions/cloud_functions.dart'; // Uncomment after enabling Blaze plan

// class NotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   /// Initialize Firebase Messaging permissions and topic subscriptions
//   Future<void> initFirebaseMessaging(String centerId, String studentId) async {
//     // 🔹 Request notification permission
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("✅ Notifications permission granted");
//     } else {
//       print("❌ Notifications permission declined");
//       return;
//     }

//     // 🔹 Subscribe user to relevant topics
//     await _messaging.subscribeToTopic('center_$centerId');
//     await _messaging.subscribeToTopic('student_$studentId');
//     print("📡 Subscribed to topics: center_$centerId & student_$studentId");

//     // 🔹 Foreground message listener
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("📩 Foreground notification: ${message.notification?.title}");
//       print("💬 Message body: ${message.notification?.body}");
//     });

//     // 🔹 When user opens app from background or terminated state
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("📲 Notification opened: ${message.notification?.title}");
//     });

//     // 🔹 Optional: get FCM token (useful for debugging or direct user notifications)
//     final token = await _messaging.getToken();
//     print("🔑 FCM Token: $token");
//   }

//   /// Unsubscribe from topics (optional when user logs out)
//   Future<void> unsubscribeFromTopics(String centerId, String studentId) async {
//     await _messaging.unsubscribeFromTopic('center_$centerId');
//     await _messaging.unsubscribeFromTopic('student_$studentId');
//     print("🚫 Unsubscribed from topics: center_$centerId & student_$studentId");
//   }

  
//   /// 🔔 Send Notification via Cloud Function (requires Blaze plan)
//   Future<void> sendNotificationToTopic({
//     required String topic,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       final functions = FirebaseFunctions.instance;
//       final callable = functions.httpsCallable('sendNotificationToTopic');

//       await callable.call({
//         'topic': topic,
//         'title': title,
//         'body': body,
//       });

//       print('✅ Notification sent to topic: $topic');
//     } catch (e) {
//       print('❌ Error sending notification: $e');
//     }
//   }
  
// }

// // ! now all things are ready , just add payent method to firebase , then call these  method in cases:
// // ! but i think these codes need some adjustments , tehy are from chat , he dont know what my codes are and what center or trainer collection have
// /*
// ✅ When user logs in:
// final notificationService = NotificationService();
// await notificationService.initFirebaseMessaging(centerId, studentId);
// ***********************************************
// ✅ When user logs out:

// await notificationService.unsubscribeFromTopics(centerId, studentId);

// ******************************************************************
// ✅ When trainer adds a session (after you enable Blaze & deploy function):
// // await NotificationService().sendNotificationToTopic(
// //   topic: 'center_$centerId',
// //   title: 'New Session Added!',
// //   body: 'A new session has been created by $trainerName',
// // );

//  */










// // ! older code
// // import 'dart:convert';

// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:http/http.dart' as http;

// // class NotificationService {
// //   final _messaging = FirebaseMessaging.instance;

// //   Future<void> initFirebaseMessaging(String centerId) async {
// //     await _messaging.requestPermission();

// //     // Subscribe to topic
// //     await _messaging.subscribeToTopic('center_$centerId');

// //     // Optional: Handle foreground notifications
// //     FirebaseMessaging.onMessage.listen((message) {
// //       print("📩 New notification: ${message.notification?.title}");
// //     });
// //   }

// //   Future<void> notifyCenter(String centerId, String courseName) async {
// //   const serverKey = 'AIzaSyDlZUiN61HjEZe6AA1s2KVNKZFLaCIKxDI'; // from Firebase Console

// //   final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
// //   final headers = {
// //     'Content-Type': 'application/json',
// //     'Authorization': 'key=$serverKey',
// //   };

// //   final body = {
// //     "to": "/topics/center_$centerId",
// //     "notification": {
// //       "title": "New Course Request",
// //       "body": "A student requested to enroll in $courseName",
// //     },
// //     "data": {
// //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
// //       "courseId": "some_id",
// //     }
// //   };

// //   await http.post(url, headers: headers, body: jsonEncode(body));
// // }

// // }