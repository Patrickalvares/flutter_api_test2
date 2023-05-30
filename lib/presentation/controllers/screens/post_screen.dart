import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test2/presentation/controllers/post_controller.dart';

import '../../../data/repositories/implementations/dio_api_repository.dart';

// ignore: constant_identifier_names
const POST_ID_TO_LOAD = 3;

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late PostController _postCtrl;

  @override
  void initState() {
    _postCtrl = PostController(apiRepository: DioApiRepository(dio: Dio()));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _postCtrl.onLoadPost(POST_ID_TO_LOAD);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consumo de API com http e dio'),
        ),
        body: _postCtrl.isLoading
            ? const Center(child: CircularProgressIndicator())
            : _postCtrl.getErrorLoadingPost == null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          _postCtrl.getLoadedPost?.title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          _postCtrl.getLoadedPost?.body ?? '',
                          style: const TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )
                : SizedBox.expand(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _postCtrl.getErrorLoadingPost!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.redAccent),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              _postCtrl.onLoadPost(POST_ID_TO_LOAD);
                              setState(() {});
                            },
                            child: const Text('Tentar novamente')),
                      ],
                    ),
                  ));
  }
}
