import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin _flnp =
      FlutterLocalNotificationsPlugin();
  static const _prefKeyEnabled = 'notifications_enabled';
  bool _enabled = true; // default
  bool get enabled => _enabled;
  bool _initialized = false;

  Future<void> ensureInitialized() async {
    if (_initialized) return;
    await init();
    _initialized = true;
  }

  Future<void> init() async {
    // Load preference first
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_prefKeyEnabled) ?? true;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    final darwinInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
      macOS: darwinInit,
    );

    await _flnp.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (resp) {
        // Handle tap if needed
      },
    );

    // Request permission explicitly on iOS/macOS  (Android 13+ uses runtime permission for POST_NOTIFICATIONS)
    if (Platform.isAndroid) {
      // For Android 13+, prompt permission via plugin method channel if available
      await _flnp
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    } else if (Platform.isIOS || Platform.isMacOS) {
      await _flnp
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      await _flnp
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKeyEnabled, value);
  }

  Future<void> showNewAccountNotification({
    required String fullName,
    required String email,
  }) async {
    if (!_initialized) {
      // Lazy init if not yet
      await ensureInitialized();
    }
    if (!_enabled) return;

    const androidDetails = AndroidNotificationDetails(
      'account_channel',
      'Account Notifications',
      channelDescription: 'Notifications about account events',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );

    await _flnp.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'มีการเพิ่มบัญชีใหม่',
      '$fullName ($email)',
      notificationDetails,
    );
  }
}
