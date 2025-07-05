import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:netflix_clone/app/services/http_interceptors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetflixService {
  // ignore: unused_field
  final String _apiKey = dotenv.env['API_KEY'] ?? '';
  final String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
  );

  Future<http.Response> fetchMovie(String title) async {
    final String url = '$_baseUrl&t=$title';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
