// page_b.dart - Tab B ของ Mini App 1
import 'package:flutter/material.dart';
import 'package:noppakao/services/notification_service.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _notificationService = NotificationService();
  bool _loading = true;
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _notificationService.ensureInitialized();
    setState(() {
      _enabled = _notificationService.enabled;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mini App 1 - Settings')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  SwitchListTile(
                    title: const Text('เปิดการแจ้งเตือน'),
                    subtitle: const Text('แจ้งเตือนเมื่อมีการเพิ่มบัญชีใหม่'),
                    value: _enabled,
                    onChanged: (v) async {
                      setState(() => _enabled = v);
                      await _notificationService.setEnabled(v);
                    },
                  ),
                ],
              ),
    );
  }
}
