import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

//  DEFINIR EXCEÇÕES CUSTOMIZADAS PARA MELHOR TRATAMENTO DE ERROS
// Isso permite que a camada superior (Repository/Provider) saiba exatamente que tipo de erro ocorreu.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

// CLASSE DE SERVIÇO REATORADA
class NetflixService {
  // A chave de API e a URL base são privadas e imutáveis.
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  final String _baseUrl = 'https://api.themoviedb.org/3';

  // Injetar o cliente HTTP facilita os testes.
  // Podemos substituir o http.Client por um mock nos testes.
  final http.Client _client;

  // Construtor que permite a injeção do cliente. Se nenhum for fornecido, usa um novo.
  NetflixService({http.Client? client}) : _client = client ?? http.Client();

  /// Função genérica para realizar chamadas GET à API.
  /// Retorna o corpo da resposta decodificado como um Map.
  Future<Map<String, dynamic>> _get(
    String endpoint, {
    Map<String, String>? params,
  }) async {
    // Validação inicial para garantir que a chave da API foi carregada.
    if (_apiKey.isEmpty) {
      throw ApiException('A chave da API do TMDB não foi encontrada.');
    }

    // Parâmetros padrão para todas as requisições.
    final defaultParams = {'api_key': _apiKey, 'language': 'pt-BR'};

    // Adiciona quaisquer parâmetros extras passados para a função.
    if (params != null) {
      defaultParams.addAll(params);
    }

    // Constrói a URI de forma segura e limpa.
    final uri = Uri.parse(
      '$_baseUrl/$endpoint',
    ).replace(queryParameters: defaultParams);

    try {
      final response = await _client.get(uri);
      return _handleResponse(response);
    } on SocketException {
      // Trata erros de conexão (ex: sem internet).
      throw NetworkException('Erro de conexão. Verifique sua internet.');
    } on http.ClientException catch (e) {
      // Trata outros erros do cliente HTTP.
      throw NetworkException('Erro no cliente HTTP: ${e.message}');
    }
  }

  /// Função privada para tratar a resposta HTTP.
  Map<String, dynamic> _handleResponse(http.Response response) {
    // Decodifica o corpo da resposta.
    final responseBody = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Retorna o corpo decodificado em caso de sucesso.
      return responseBody;
    } else {
      // Em caso de erro, lança uma exceção com a mensagem da API.
      final errorMessage =
          responseBody['status_message'] ?? 'Erro desconhecido da API';
      throw ApiException(errorMessage, response.statusCode);
    }
  }

  // --- MÉTODOS PÚBLICOS DA API ---

  /// Busca filmes pelo título.
  /// Retorna um Map que representa o JSON da resposta da API.
  Future<Map<String, dynamic>> searchMovies(String title) async {
    return _get('search/movie', params: {'query': title});
  }

  /// Busca os filmes populares do momento.
  Future<Map<String, dynamic>> fetchPopularMovies() async {
    return _get('movie/popular');
  }

  /// Busca os filmes em alta (trending).
  Future<Map<String, dynamic>> fetchTrendingMovies() async {
    return _get('trending/movie/week');
  }

  /// Busca os detalhes de um filme específico pelo seu ID.
  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    return _get('movie/$movieId');
  }
}
