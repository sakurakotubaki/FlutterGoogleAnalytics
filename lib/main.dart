// ignore_for_file: unused_local_variable

import 'package:anlytics_tutorial/analytics_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

// FirebaseAnalytics の instance ゲッターを呼び出して、
//Firebase 向け Google アナリティクスの新しいインスタンスを作成します。
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      // FirebaseAnalyticsObserverは、Navigatorのイベントを監視し、
      //Firebase Analyticsに画面遷移を報告します。
      // 今回は、画面遷移をしないので、必要ないかなと思います。
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsService = ref.read(analyticsServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Analytics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ボタンを押すとイベントを検知して、GoogleAnalyticsに
            // ユーザーがアプリを使用していることが通知される
            ElevatedButton(
              child: const Text('ボタンを押してね'),
              onPressed: () async {
                analyticsService.eventPush();
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text('好きなたべもの'),
              onPressed: () async {
                analyticsService.foodEvent();
              },
            ),
          ],
        ),
      ),
    );
  }
}
