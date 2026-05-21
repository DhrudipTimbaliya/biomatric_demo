import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'biometric_login_page.dart';
import 'fingerprint_scan_page.dart';
import 'profile_page.dart';
import 'auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // Initialize Global Auth Controller
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HumaX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/biometric',
      getPages: [
        GetPage(name: '/biometric', page: () => const BiometricLoginPage()),
        GetPage(name: '/scan', page: () => const FingerprintScanPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
      ],
    );
  }
}
