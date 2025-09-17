import 'package:flutter/material.dart';
import 'availability_schedule_page.dart';
import 'user_profile_data.dart';

class ServiceDetailsWizard extends StatefulWidget {
  final UserProfileData userProfile;

  const ServiceDetailsWizard({super.key, required this.userProfile});

  @override
  State<ServiceDetailsWizard> createState() => _ServiceDetailsWizardState();
}

class _ServiceDetailsWizardState extends State<ServiceDetailsWizard> {
  final _formKey = GlobalKey<FormState>();

  final Set<String> selectedServices = {};
  final Set<String> selectedCoverages = {};

  final List<String> services = [
    "Bridal",
    "Festive",
    "Kids Mehndi",
    "Traditional",
    "Simple/Minimal",
    "Indian Mehndi",
    "Arabic Mehndi",
    "Pakistani Mehndi",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Offer Your Services"),
        backgroundColor: Colors.deepPurple[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[900]!,
              Colors.grey[800]!,
              Colors.black87,
            ],
          ),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    "Start Your Service Journey",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tell us about the services you offer",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Service Categories
                  _buildSectionTitle("Service Categories"),
                  const SizedBox(height: 12),
                  _buildChipSelection(
                    items: services,
                    selectedItems: selectedServices,
                    selectedGradient: [
                      Colors.deepPurple[600]!,
                      Colors.indigo[600]!,
                    ],
                    selectedBorder: Colors.deepPurple[400]!,
                  ),
                  const SizedBox(height: 20),

                  // Coverage Options
                  _buildSectionTitle("Service Coverage"),
                  const SizedBox(height: 12),
                  _buildChipSelection(
                    items: [
                      "Full Hand (up to elbow)",
                      "Half Hand (up to wrist/mid-arm)",
                      "Back Hand",
                      "Foot / Leg",
                      "Custom",
                    ],
                    selectedItems: selectedCoverages,
                    selectedGradient: [
                      Colors.teal[600]!,
                      Colors.cyan[600]!,
                    ],
                    selectedBorder: Colors.teal[400]!,
                  ),

                  const SizedBox(height: 30),

                  // Continue Button
                  _buildContinueButton(context),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildChipSelection({
    required List<String> items,
    required Set<String> selectedItems,
    required List<Color> selectedGradient,
    required Color selectedBorder,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return Container(
          decoration: BoxDecoration(
            gradient: isSelected ? LinearGradient(colors: selectedGradient) : null,
            color: isSelected ? null : Colors.grey[800],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? selectedBorder : Colors.grey[600]!,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isSelected ? selectedItems.remove(item) : selectedItems.add(item);
                });
              },
              borderRadius: BorderRadius.circular(25),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[300],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple[600]!, Colors.indigo[600]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (selectedServices.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please select at least one service category'),
                  backgroundColor: Colors.red[600],
                ),
              );
              return;
            }
            if (selectedCoverages.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please select at least one coverage option'),
                  backgroundColor: Colors.red[600],
                ),
              );
              return;
            }

            // Update user profile with service details
            widget.userProfile.selectedServices = selectedServices.toList();
            widget.userProfile.selectedCoverages = selectedCoverages.toList();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AvailabilitySchedulePage(
                  userProfile: widget.userProfile,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              "Continue to Availability",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
