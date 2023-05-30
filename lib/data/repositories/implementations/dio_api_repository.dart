import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_api_test2/data/models/post_model.dart';
import 'package:flutter_api_test2/data/repositories/api_repository.dart';
import 'package:flutter_api_test2/data/repositories/errors/api_exception.dart';

class DioApiRepository implements ApiRepository {
  final Dio _dio;

  DioApiRepository({required Dio dio}) : _dio = dio;

  @override
  Future<PostModel?> getPost(int postId) async {
    try {
      final url = '$API_URL/posts/$postId';

      await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.get(url);

      return PostModel.fromMap(response.data);
    } on DioError catch (dioError) {
      throw ApiException(message: dioError.message ?? "Erro ao Carregar");
    } catch (error, stacktrace) {
      log(
        'Erro ao fazer get do post',
        error: error,
        stackTrace: stacktrace,
      );
      throw ApiException(message: "Erro ao carregar post");
    }
  }
}
