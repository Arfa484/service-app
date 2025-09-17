class UserProfileData {
  // Profile Information
  String? fullName;
  String? bio;
  String? city;
  List<String> languages = [];
  String? profileImagePath;

  // Service Details
  List<String> selectedServices = [];
  List<String> selectedCoverages = [];

  // Availability
  Map<String, String> weeklyAvailability = {
    'Monday': '10:00 AM - 7:00 PM',
    'Tuesday': '10:00 AM - 7:00 PM',
    'Wednesday': '10:00 AM - 7:00 PM',
    'Thursday': '10:00 AM - 7:00 PM',
    'Friday': '10:00 AM - 7:00 PM',
    'Saturday': '10:00 AM - 7:00 PM',
    'Sunday': 'Off',
  };

  // Portfolio & Pricing
  List<String> portfolioImages = [];
  String? basePrice;
  String? perHandPrice;
  String? bridalPackage;

  UserProfileData();

  // Helper methods
  bool get isProfileComplete {
    return fullName != null &&
           bio != null &&
           city != null &&
           languages.isNotEmpty &&
           selectedServices.isNotEmpty &&
           selectedCoverages.isNotEmpty &&
           basePrice != null &&
           perHandPrice != null;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': fullName ?? '',
      'bio': bio ?? '',
      'city': city ?? '',
      'languages': languages,
      'services': selectedServices.toList(),
      'coverage': selectedCoverages.toList(),
      'availability': weeklyAvailability,
      'pricing': {
        'basePrice': basePrice != null ? '₹$basePrice' : '₹0',
        'perHandPrice': perHandPrice != null ? '₹$perHandPrice' : '₹0',
        'bridalPackage': bridalPackage != null ? '₹$bridalPackage' : '₹0',
      },
      'portfolioCount': portfolioImages.length,
    };
  }
}
