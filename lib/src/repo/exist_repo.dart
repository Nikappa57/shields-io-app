import 'package:http/http.dart' as http;

Future<bool> existRepo(String username, String repo) async {
  repo = repo.trim();
  if (username == null || username.isEmpty) return false;
  if (repo == null || repo.isEmpty) return false;

  String url = 'https://api.github.com/repos/$username/$repo';

}
