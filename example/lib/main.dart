import 'package:dio/dio.dart';
import 'package:example/models/login_request.dart';
import 'package:example/models/login_response.dart';
import 'package:fancy_dio_inspector_personal/fancy_dio_inspector_personal.dart';

/// Import the `fancy_dio_inspector` package.
import 'package:flutter/material.dart';

void main() {
  /// Initialize your `Dio` client.
  DioClient.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  Future<void> login({bool success = true}) async {
    setState(() {
      token = null;
    });

    final response = await DioClient.instance.login(success: success);

    if (response != null) {
      setState(() {
        token = response.token;
      });
    }
  }

  Future<void> mockSuccessHttpRequest() async {
    final response = await DioClient.instance.mockSuccessHttpRequest();
  }

  void openDioInspector(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FancyDioInspectorView(
          leading: CloseButton(onPressed: Navigator.of(context).pop),
        ),
      ),
    );
  }

  void openHttpScopePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HttpScopeView(
          leading: CloseButton(onPressed: Navigator.of(context).pop),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter_list_alt),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fancy Dio Inspector Example',
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Fancy Dio Inspector'),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: mockSuccessHttpRequest,
                  child: const Text('Mock success Http'),
                ),
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Mock error Http Request'),
                ),
                ElevatedButton(
                  onPressed: login,
                  child: const Text('Success Login'),
                ),
                ElevatedButton(
                  onPressed: () => login(success: false),
                  child: const Text('Error Login'),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  // onPressed: () => openDioInspector(context),
                  onPressed: () => openHttpScopePage(context),
                  child: const Text('Open FancyDioInspectorView'),
                ),
                Text('Token: $token'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DioClient {
  DioClient._();
  static final DioClient instance = DioClient._();

  late final Dio _dio;

  void init() {
    _dio = Dio(BaseOptions(baseUrl: 'https://reqres.in/api'));

    /// Add the `FancyDioInterceptor` to the `Dio` client.
    _dio.interceptors.add(
      FancyDioInterceptor(
        options: const FancyDioInspectorOptions(
          consoleOptions: FancyDioInspectorConsoleOptions(verbose: true),
        ),
      ),
    );
  }

  Future<LoginResponse?> login({bool success = true}) async {
    final request = LoginRequest(
      email: 'eve.holt@reqres.${success ? 'in' : 'com'}',
      password: 'cityslicka',
    );

    try {
      final response = await _dio.post('/login', data: request.toJson());
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> mockSuccessHttpRequest() async {
    const url = "https://api.test.yoofinds.com/api/campaign-products/qMjYbP";
    try {
      final response = await _dio.get(url);
      return response;
    } catch (e) {
      return null;
    }
  }
}
