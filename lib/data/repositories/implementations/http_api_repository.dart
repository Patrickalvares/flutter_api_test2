import 'dart:developer';
import 'package:flutter_api_test2/data/models/post_model.dart';
import 'package:flutter_api_test2/data/repositories/api_repository.dart';
import 'package:flutter_api_test2/data/repositories/errors/api_exception.dart';
import 'package:http/http.dart';

class HttpApiRepository implements ApiRepository {
  final Client _client;

  HttpApiRepository({required Client client}) : _client = client;

  @override
  Future<PostModel?> getPost(int postId) async {
    try {
      final url = '$API_URL/posts/$postId';

      final response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return PostModel.fromJson(response.body);
      } else {
        throw ApiException(message: "Erro ao Carregar");
      }
    } catch (error, stacktrace) {
      log(
        'Erro ao fazer get do post',
        error: error,
        stackTrace: stacktrace,
      );
      throw ApiException(message: "Erro ao Carregar");
    }
  }
}
