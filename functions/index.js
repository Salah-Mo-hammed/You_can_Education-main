const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * 1) Firestore trigger: notify a single student when they are accepted.
 *    - Expects a document created in "acceptances/{acceptanceId}"
 *    - The document should contain at least: { studentId: "<uid>", title?, body? }
 *    - It will send to topic "student_<studentId>" (subscribe students to that topic in client).
 */
exports.notifyStudentAccepted = functions.firestore
  .document("acceptances/{acceptanceId}")
  .onCreate(async (snap, ctx) => {
    const data = snap.data();
    if (!data) return null;

    const studentId = data.studentId;
    const title = data.title || "🎉 You were accepted!";
    const body = data.body || "You have been accepted by the center.";

    if (!studentId) {
      console.log("No studentId in acceptance doc:", ctx.params.acceptanceId);
      return null;
    }

    const message = {
      notification: { title, body },
      topic: `student_${studentId}`,
      data: { type: "accepted", acceptanceId: ctx.params.acceptanceId.toString() },
    };

    try {
      const res = await admin.messaging().send(message);
      console.log("Sent acceptance notification:", res);
    } catch (err) {
      console.error("Error sending acceptance notification:", err);
    }
    return null;
  });

/**
 * 2) Firestore trigger: notify course subscribers when a new session is added.
 *    - Triggered when a document is created in "courses/{courseId}/sessions/{sessionId}"
 *    - Students should be subscribed to topic "course_<courseId>"
 */
exports.notifyNewSession = functions.firestore
  .document("courses/{courseId}/sessions/{sessionId}")
  .onCreate(async (snap, ctx) => {
    const session = snap.data() || {};
    const courseId = ctx.params.courseId;
    const title = session.title || "New Session Added";
    const body = session.description || "A new session has been scheduled in your course.";

    const message = {
      notification: { title, body },
      topic: `course_${courseId}`,
      data: { type: "new_session", courseId },
    };

    try {
      const res = await admin.messaging().send(message);
      console.log("Sent new session notification:", res);
    } catch (err) {
      console.error("Error sending new session notification:", err);
    }
    return null;
  });

/**
 * 3) Optional: Callable function to send to any topic (useful for admin UI or testing)
 *    - Call from client: FirebaseFunctions.instance.httpsCallable('sendNotification')({ topic, title, body })
 */
exports.sendNotification = functions.https.onCall(async (data, context) => {
  const topic = data.topic;
  const title = data.title || "Notification";
  const body = data.body || "";

  if (!topic) {
    throw new functions.https.HttpsError("invalid-argument", "Missing topic");
  }

  const message = {
    notification: { title, body },
    topic,
    data: data.data || {},
  };

  try {
    const res = await admin.messaging().send(message);
    return { success: true, result: res };
  } catch (err) {
    console.error("sendNotification error:", err);
    throw new functions.https.HttpsError("internal", err.message);
  }
});
