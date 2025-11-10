import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseSessionsPage extends StatelessWidget {
  final Map<String, dynamic> courseUrls;

  CourseSessionsPage({super.key, required this.courseUrls});

  @override
  Widget build(BuildContext context) {
    final sessions =
        courseUrls.entries
            .map(
              (entry) => {
                'name': entry.key,
                'url': entry.value.toString(),
              },
            )
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        title: const Text('Course Sessions'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            final session = sessions[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 24,
                ),
                title: Text(
                  session['name']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RichText(
                    text: TextSpan(
                      text: session['url'],
                      style: const TextStyle(
                        color: Color(0xFF1E88E5),
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(session['url']!);
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                              // Logic unchanged
                            },
                    ),
                  ),
                ),
                onTap: () {
                  // Logic unchanged
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: Text(session['name']!),
                          content: Text('URL: ${session['url']}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
