import 'package:flutter/material.dart';
import 'review_confirm_profile.dart';
import 'user_profile_data.dart';

class PortfolioPage extends StatefulWidget {
  final UserProfileData userProfile;
  
  const PortfolioPage({super.key, required this.userProfile});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  late List<String> portfolioImages;
  late final TextEditingController basePriceController;
  late final TextEditingController perHandPriceController;
  late final TextEditingController bridalPackageController;

  @override
  void initState() {
    super.initState();
    // Initialize with user profile data
    portfolioImages = List.from(widget.userProfile.portfolioImages);
    if (portfolioImages.isEmpty) {
      portfolioImages = ['assets/sample1.jpg', 'assets/sample2.jpg', 'assets/sample3.jpg'];
    }
    
    basePriceController = TextEditingController(text: widget.userProfile.basePrice ?? '');
    perHandPriceController = TextEditingController(text: widget.userProfile.perHandPrice ?? '');
    bridalPackageController = TextEditingController(text: widget.userProfile.bridalPackage ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio & Pricing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📸 Portfolio Section
            const Text(
              'Portfolio Images',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: portfolioImages.length + 1,
                itemBuilder: (context, index) {
                  if (index == portfolioImages.length) {
                    // Add new image button
                    return GestureDetector(
                      onTap: _addImage,
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add_photo_alternate, size: 40),
                      ),
                    );
                  }
                  
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 100,
                            height: 120,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 40),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            /// 💰 Pricing Section
            const Text(
              'Pricing Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: basePriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Base Price (₹)',
                hintText: 'e.g., 500',
                border: OutlineInputBorder(),
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: perHandPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Per Hand Price (₹)',
                hintText: 'e.g., 300',
                border: OutlineInputBorder(),
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 15),

            TextFormField(
              controller: bridalPackageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bridal Package (₹)',
                hintText: 'e.g., 2500',
                border: OutlineInputBorder(),
                prefixText: '₹ ',
              ),
            ),

            const SizedBox(height: 30),

            /// ✅ Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _goToReview,
                child: const Text(
                  'Next: Review & Confirm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addImage() {
    // TODO: Implement image picker
    setState(() {
      portfolioImages.add('assets/new_image.jpg');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker coming soon!')),
    );
  }

  void _removeImage(int index) {
    setState(() {
      portfolioImages.removeAt(index);
    });
  }

  void _goToReview() {
    // Validate pricing fields
    if (basePriceController.text.isEmpty || 
        perHandPriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the pricing details')),
      );
      return;
    }

    // Update user profile with portfolio and pricing data
    widget.userProfile.portfolioImages = portfolioImages;
    widget.userProfile.basePrice = basePriceController.text;
    widget.userProfile.perHandPrice = perHandPriceController.text;
    widget.userProfile.bridalPackage = bridalPackageController.text;

    // Navigate to review page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewConfirmProfile(userProfile: widget.userProfile),
      ),
    );
  }
}
