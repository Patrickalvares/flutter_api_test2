import 'package:flutter_api_test2/data/models/post_model.dart';
import 'package:flutter_api_test2/data/repositories/api_repository.dart';
import 'package:flutter_api_test2/data/repositories/errors/api_exception.dart';

class PostController {
  final ApiRepository apiRepository;

  PostController({required this.apiRepository});

  String? _errorLoadingPost;

  String? get getErrorLoadingPost => _errorLoadingPost;

  bool isLoading = true;

  PostModel? _loadedPost;

  PostModel? get getLoadedPost => _loadedPost;

  Future<void> onLoadPost(int postId) async {
    isLoading = true;
    _errorLoadingPost = null;

    try {
      final post = await apiRepository.getPost(postId);
      _loadedPost = post;
    } on ApiException catch (apiException) {
      _errorLoadingPost = apiException.message;
    } catch (error) {
      _errorLoadingPost = "Erro ao carregar o post";
    }
    isLoading = false;
  }
}
