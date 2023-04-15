import 'package:anlytics_tutorial/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// AnalyticsServiceを読み込むためのプロバイダー
final analyticsServiceProvider = Provider<AnalyticsService>((ref) => AnalyticsService());

// GoogleAnalyticsを使用するためのサービスクラス
class AnalyticsService {
  // ボタンイベント
  Future<void> eventPush() async {
    await analytics.logEvent(
      name: '押したよ!',
      parameters: <String, dynamic>{
        'button_name': 'example_button',
      },
    );
  }

  // 好きな食べ物の情報を収集する
  Future<void> foodEvent() async {
    const favoriteFood = 'Apple';
    await FirebaseAnalytics.instance.setUserProperty(
      name: 'favorite_food',
      value: favoriteFood,
    );
  }
}
