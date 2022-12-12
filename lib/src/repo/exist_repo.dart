import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<bool> existRepo(String username, String repo) async {
  final user = FirebaseAuth.instance.currentUser;
  final userData =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  final String token = userData.data()['github-token'];
  if (username == null || username.isEmpty) return false;
  if (repo == null || repo.isEmpty) return false;

  String url = 'https://api.github.com/repos/$username/$repo';

  var response = await http.get(
    url,
    headers: {
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    },
  );

  switch (response.statusCode) {
    case 403: // probably API rate limit exceeded
      return true;
    case 200: // repo exist
      return true;
    case 404: // repo not exist
      return false;
    case 301: // Moved Permanently
      return false;
    default:
      return true;
  }
}
