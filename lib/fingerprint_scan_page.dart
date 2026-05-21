import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'assetsConstant.dart';
import 'auth_controller.dart';

class FingerprintScanPage extends StatefulWidget {
  const FingerprintScanPage({super.key});

  @override
  State<FingerprintScanPage> createState() => _FingerprintScanPageState();
}

class _FingerprintScanPageState extends State<FingerprintScanPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final AuthController authController = Get.find<AuthController>();
  
  bool _isVerified = false;
  bool _isProcessing = false;
  late bool _isRegisterFlow;

  @override
  void initState() {
    super.initState();
    _isRegisterFlow = Get.arguments?['flow'] == 'register';
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleScan() async {
    if (authController.isLockedOut.value || _isProcessing) return;

    bool success = await authController.getFingerprint();
    if (success) {
      setState(() => _isProcessing = true);
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _isVerified = true;
        _isProcessing = false;
      });
      
      Get.snackbar(
        "Verified", 
        "Fingerprint recognized!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[50],
        colorText: Colors.green[900],
      );
    } else {
      if (authController.isLockedOut.value) {
        Get.snackbar(
          "Access Denied", 
          "Locked for ${authController.remainingLockoutSeconds.value}s.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[50],
          colorText: Colors.red[900],
        );
      } else {
        Get.snackbar(
          "Failed", 
          "Fingerprint not recognized.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[50],
          colorText: Colors.red[900],
        );
      }
    }
  }

  void _handleSubmit() {
    if (_isVerified) {
      authController.setFingerprint(true);
      Get.offAllNamed('/profile'); // Always go to profile
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(child: Image.asset(AssetsConstants.loginLogo)),
            const SizedBox(height: 48),
            Text(
              _isRegisterFlow ? 'Secure Your Account' : 'Welcome Back',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E)),
            ),
            const SizedBox(height: 16),
            Text(
              authController.isLockedOut.value 
                ? 'Security Lockout'
                : (_isVerified 
                    ? 'Scan Complete! Tap Submit to finish.' 
                    : (_isProcessing ? 'Processing biometric data...' : 'Tap the icon below to scan your fingerprint.')),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: authController.isLockedOut.value ? Colors.red : Colors.grey[600]),
            ),
            const Spacer(),
            
            if (authController.isLockedOut.value)
              _buildLockoutUI()
            else
              _buildScanUI(),
            
            const Spacer(),
            
            _buildSubmitButton(),
            const SizedBox(height: 24),
          ],
        ),
      )),
    );
  }

  Widget _buildLockoutUI() {
    return Column(
      children: [
        const Icon(Icons.lock_person, size: 80, color: Colors.red),
        const SizedBox(height: 16),
        Text(
          'Wait ${authController.remainingLockoutSeconds.value}s',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildScanUI() {
    return Column(
      children: [
        ScaleTransition(
          scale: _animation,
          child: InkWell(
            onTap: (_isVerified || _isProcessing) ? null : _handleScan,
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: _isVerified ? Colors.green.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isVerified ? Colors.green : Colors.blue.withValues(alpha: 0.2),
                  width: 2
                ),
              ),
              child: _isProcessing 
                ? const SizedBox(width: 100, height: 100, child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(
                    _isVerified ? Icons.check : Icons.fingerprint,
                    size: 100,
                    color: _isVerified ? Colors.green : Colors.blue,
                  ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _isVerified ? 'Verification Successful' : (_isProcessing ? 'Verifying...' : 'Tap to scan'),
          style: TextStyle(
            fontSize: 18,
            color: _isVerified ? Colors.green : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: (authController.isLockedOut.value || !_isVerified) ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          disabledBackgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
