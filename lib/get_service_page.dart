import 'package:flutter/material.dart';
import 'service_provider_detail.dart';

class GetServicePage extends StatefulWidget {
  const GetServicePage({super.key});

  @override
  State<GetServicePage> createState() => _GetServicePageState();
}

class _GetServicePageState extends State<GetServicePage> {
  String selectedCategory = 'All';
  String selectedLocation = 'All Cities';
  String searchQuery = '';

  final List<String> categories = [
    'All',
    'Bridal Mehndi',
    'Festive Mehndi',
    'Traditional Mehndi',
    'Arabic Mehndi',
    'Kids Mehndi',
  ];

  final List<String> locations = [
    'All Cities',
    'Mumbai',
    'Delhi',
    'Bengaluru',
    'Chennai',
    'Hyderabad',
    'Pune',
  ];

  // Mock service providers data
  final List<Map<String, dynamic>> serviceProviders = [
    {
      'name': 'Meera Designs',
      'rating': 4.8,
      'reviews': 127,
      'location': 'Mumbai',
      'specialties': ['Bridal Mehndi', 'Traditional Mehndi'],
      'basePrice': 500,
      'image': 'assets/provider1.jpg',
      'experience': '8 years',
      'languages': ['Hindi', 'English', 'Marathi'],
      'availability': 'Available Today',
    },
    {
      'name': 'Artistic Henna',
      'rating': 4.9,
      'reviews': 203,
      'location': 'Delhi',
      'specialties': ['Arabic Mehndi', 'Festive Mehndi'],
      'basePrice': 600,
      'image': 'assets/provider2.jpg',
      'experience': '5 years',
      'languages': ['Hindi', 'English'],
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Priya\'s Mehndi Art',
      'rating': 4.7,
      'reviews': 89,
      'location': 'Bengaluru',
      'specialties': ['Bridal Mehndi', 'Kids Mehndi'],
      'basePrice': 450,
      'image': 'assets/provider3.jpg',
      'experience': '6 years',
      'languages': ['English', 'Kannada', 'Tamil'],
      'availability': 'Available This Week',
    },
    {
      'name': 'Royal Henna Designs',
      'rating': 4.6,
      'reviews': 156,
      'location': 'Chennai',
      'specialties': ['Traditional Mehndi', 'Festive Mehndi'],
      'basePrice': 400,
      'image': 'assets/provider4.jpg',
      'experience': '10 years',
      'languages': ['Tamil', 'English', 'Telugu'],
      'availability': 'Available Next Week',
    },
  ];

  List<Map<String, dynamic>> get filteredProviders {
    return serviceProviders.where((provider) {
      final matchesCategory = selectedCategory == 'All' ||
          provider['specialties'].contains(selectedCategory);
      final matchesLocation = selectedLocation == 'All Cities' ||
          provider['location'] == selectedLocation;
      final matchesSearch = searchQuery.isEmpty ||
          provider['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          provider['specialties'].any((specialty) =>
              specialty.toLowerCase().contains(searchQuery.toLowerCase()));

      return matchesCategory && matchesLocation && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('Find Service Providers'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filters Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade800, Colors.grey.shade900],
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for service providers...',
                    hintStyle: TextStyle(color: Colors.grey[400]!),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.deepPurple[300]!),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 12),

                // Filter Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedCategory, // ✅ FIXED
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.grey[800],
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(color: Colors.grey[300]!),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey[600]!),
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedLocation, // ✅ FIXED
                        style: const TextStyle(color: Colors.white),
                        dropdownColor: Colors.grey[800],
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: TextStyle(color: Colors.grey[300]!),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: Colors.grey[600]!),
                          ),
                          filled: true,
                          fillColor: Colors.grey[800],
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: locations.map((location) {
                          return DropdownMenuItem(
                            value: location,
                            child: Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Results Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProviders.length} Providers Found',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Add sort/filter options
                  },
                  icon: Icon(Icons.tune, color: Colors.deepPurple[300]!),
                ),
              ],
            ),
          ),

          // Service Providers List
          Expanded(
            child: filteredProviders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No providers found',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey[300]!),
                        ),
                        const Text(
                          'Try adjusting your filters',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = filteredProviders[index];
                      return _buildProviderCard(provider);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[800]!, Colors.grey[700]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ServiceProviderDetail(provider: provider),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Provider Image Placeholder (using initials)
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.shade400,
                            Colors.indigo.shade500
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          provider['name'][0],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Provider Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                '${provider['rating']} (${provider['reviews']} reviews)',
                                style: TextStyle(color: Colors.grey[300]!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.grey[400]!, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  provider['location'],
                                  style: TextStyle(color: Colors.grey[300]!),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Icon(Icons.work,
                                  color: Colors.grey[400]!, size: 16),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  provider['experience'],
                                  style: TextStyle(color: Colors.grey[300]!),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Price and Availability
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹${provider['basePrice']}+',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[300]!,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[700]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.green[600]!),
                          ),
                          child: Text(
                            provider['availability'],
                            style: TextStyle(
                              color: Colors.green[300]!,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Specialties
                Wrap(
                  spacing: 8,
                  children: (provider['specialties'] as List<String>)
                      .map(
                        (specialty) => Chip(
                          label: Text(
                            specialty,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor:
                              Colors.deepPurple[800]!.withOpacity(0.3),
                          side: BorderSide(
                            color: Colors.deepPurple[400]!,
                          ),
                          labelStyle:
                              const TextStyle(color: Colors.white),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 12),

                // Languages
                Row(
                  children: [
                    Icon(Icons.language,
                        color: Colors.grey[400]!, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Languages: ${(provider['languages'] as List<String>).join(', ')}',
                        style: TextStyle(
                          color: Colors.grey[300]!,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${provider['name']} added to favorites',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.favorite_border),
                        label: const Text('Save'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServiceProviderDetail(provider: provider),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility),
                        label: const Text('View Details'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple[600]!,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
