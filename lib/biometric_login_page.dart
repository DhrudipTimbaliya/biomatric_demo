import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'assetsConstant.dart';

class BiometricLoginPage extends StatelessWidget {
  const BiometricLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                // Logo Header
        
                    Image.asset(
                      AssetsConstants.loginLogo,
                    ),
        
                const SizedBox(height: 32),
                
                const Text(
                  'Set Up Biometric Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D1B3E),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Secure your account with biometric authentication\nfor faster and safer access.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7E8CA0),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Features Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF1F4F9)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildFeatureRow(
                        Icons.shield_outlined,
                        'Secure & Private',
                        'Your biometric data is encrypted and stored securely on your device.',
                        const Color(0xFF2196F3),
                      ),
                      const Divider(height: 1, color: Color(0xFFF1F4F9), indent: 16, endIndent: 16),
                      _buildFeatureRow(
                        Icons.bolt,
                        'Fast Access',
                        'Log in quickly without typing your password every time.',
                        const Color(0xFF2196F3),
                      ),
                      const Divider(height: 1, color: Color(0xFFF1F4F9), indent: 16, endIndent: 16),
                      _buildFeatureRow(
                        Icons.lock_outline,
                        'You\'re in Control',
                        'You can enable or disable biometric login anytime in settings.',
                        const Color(0xFF2196F3),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Primary Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed('/scan', arguments: {'flow': 'login'}),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fingerprint, size: 24),
                        SizedBox(width: 8),
                        const Text(
                          'Enable Biometric Login',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Skip Button
                InkWell(
                  onTap: () => Get.offAllNamed('/profile'),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF1F4F9)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline, size: 16, color: Color(0xFF2196F3)),
                            SizedBox(width: 4),
                            Text(
                              'Skip for Now',
                              style: TextStyle(
                                color: Color(0xFF2196F3),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'You can set it up later in Settings',
                          style: TextStyle(color: Color(0xFF7E8CA0), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Trusted Footer
                _buildTrustedFooter(),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String description, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF0D1B3E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF7E8CA0),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_user, color: Color(0xFF4CAF50), size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trusted by You",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF0D1B3E),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "We never share your biometric data with anyone. Your security is our priority.",
                  style: TextStyle(
                    color: Color(0xFF7E8CA0),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
