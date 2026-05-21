import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final box = GetStorage();


  // Default Dummy Data
  var name = "John Doe".obs;
  var phone = "+91 98765 43210".obs;
  var isFingerprintScanned = false.obs;

  // Lockout logic
  var failedAttempts = 0.obs;
  var isLockedOut = false.obs;
  var remainingLockoutSeconds = 30.obs;
  Timer? _lockoutTimer;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  void _loadData() {
    // Only load biometric preference, name and phone are dummy
    isFingerprintScanned.value = box.read('is_biometric_enabled') ?? false;
  }

  @override
  void onClose() {
    _lockoutTimer?.cancel();
    super.onClose();
  }

  void setFingerprint(bool value) {
    isFingerprintScanned.value = value;
    box.write('is_biometric_enabled', value);
  }

  Future<bool> getFingerprint() async {
    if (isLockedOut.value) {
      return false;
    }

    try {
      final bool canCheck = await auth.canCheckBiometrics;
      final bool isSupported = await auth.isDeviceSupported();

      if (!canCheck && !isSupported) return false;

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Scan fingerprint to verify identity',
        options: const AuthenticationOptions(
          stickyAuth: false,
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      
      if (didAuthenticate) {
        failedAttempts.value = 0;
        return true;
      } else {
        _handleFailure();
        return false;
      }
    } on PlatformException catch (e) {
      debugPrint("Biometric error: $e");
      _handleFailure();
      return false;
    }
  }

  void _handleFailure() {
    failedAttempts.value++;
    if (failedAttempts.value >= 5) {
      _startLockout();
    }
  }

  void _startLockout() {
    isLockedOut.value = true;
    remainingLockoutSeconds.value = 30;
    _lockoutTimer?.cancel();
    _lockoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingLockoutSeconds.value > 0) {
        remainingLockoutSeconds.value--;
      } else {
        isLockedOut.value = false;
        failedAttempts.value = 0;
        timer.cancel();
      }
    });
  }

  void logout() {
    Get.offAllNamed('/biometric');
  }
}
