import 'package:flutter/material.dart';
import 'provider_dashboard_post_setup.dart';
import 'user_profile_data.dart';

class ReviewConfirmProfile extends StatefulWidget {
  final UserProfileData userProfile;
  
  const ReviewConfirmProfile({super.key, required this.userProfile});

  @override
  State<ReviewConfirmProfile> createState() => _ReviewConfirmProfileState();
}

class _ReviewConfirmProfileState extends State<ReviewConfirmProfile> {
  late Map<String, dynamic> profileData;

  @override
  void initState() {
    super.initState();
    // Use dynamic data from user profile
    profileData = widget.userProfile.toMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review & Confirm Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review Your Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Please review all information before submitting your profile.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),

            /// Profile Information Section
            _buildSection(
              'Profile Information',
              [
                _buildInfoRow('Name', profileData['name']),
                _buildInfoRow('Bio', profileData['bio']),
                _buildInfoRow('City', profileData['city']),
                _buildInfoRow('Languages', (profileData['languages'] as List<String>).join(', ')),
              ],
              onEdit: () => _editSection('profile'),
            ),

            /// Services Section
            _buildSection(
              'Services Offered',
              [
                _buildInfoRow('Service Types', (profileData['services'] as List<String>).join(', ')),
                _buildInfoRow('Coverage Areas', (profileData['coverage'] as List<String>).join(', ')),
              ],
              onEdit: () => _editSection('services'),
            ),

            /// Availability Section
            _buildSection(
              'Availability Schedule',
              (profileData['availability'] as Map<String, String>).entries.map((entry) =>
                _buildInfoRow(entry.key, entry.value)
              ).toList(),
              onEdit: () => _editSection('availability'),
            ),

            /// Pricing Section
            _buildSection(
              'Pricing Details',
              [
                _buildInfoRow('Base Price', (profileData['pricing'] as Map<String, String>)['basePrice']!),
                _buildInfoRow('Per Hand Price', (profileData['pricing'] as Map<String, String>)['perHandPrice']!),
                _buildInfoRow('Bridal Package', (profileData['pricing'] as Map<String, String>)['bridalPackage']!),
              ],
              onEdit: () => _editSection('pricing'),
            ),

            /// Portfolio Section
            _buildSection(
              'Portfolio',
              [
                _buildInfoRow('Images Added', '${profileData['portfolioCount']} photos'),
              ],
              onEdit: () => _editSection('portfolio'),
            ),

            const SizedBox(height: 30),

            /// Terms and Conditions
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                const Expanded(
                  child: Text(
                    'I agree to the Terms & Conditions and Privacy Policy',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _submitProfile,
                child: const Text(
                  'Submit Profile & Go Live',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, {VoidCallback? onEdit}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                if (onEdit != null)
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _editSection(String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit $section functionality - Navigate back to respective page'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _submitProfile() {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Submitting your profile...'),
          ],
        ),
      ),
    );

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog
      
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('🎉 Profile Submitted!'),
          content: const Text(
            'Congratulations! Your profile is now live on Servana. You can start receiving booking requests.',
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProviderDashboardPostSetup(userProfile: widget.userProfile),
                  ),
                );
              },
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      );
    });
  }
}
