import 'package:flutter/material.dart';
import 'user_profile_data.dart';

class ProviderDashboardPostSetup extends StatefulWidget {
  final UserProfileData userProfile;
  
  const ProviderDashboardPostSetup({super.key, required this.userProfile});

  @override
  State<ProviderDashboardPostSetup> createState() => _ProviderDashboardPostSetupState();
}

class _ProviderDashboardPostSetupState extends State<ProviderDashboardPostSetup>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for bookings and requests
  final List<Map<String, dynamic>> upcomingBookings = [
    {
      'customerName': 'Anjali Patel',
      'service': 'Bridal Mehndi',
      'date': '2024-01-15',
      'time': '2:00 PM',
      'status': 'Confirmed',
      'amount': '₹2500',
    },
    {
      'customerName': 'Riya Sharma',
      'service': 'Festive Mehndi',
      'date': '2024-01-18',
      'time': '4:00 PM',
      'status': 'Pending',
      'amount': '₹800',
    },
  ];

  final List<Map<String, dynamic>> bookingRequests = [
    {
      'customerName': 'Meera Singh',
      'service': 'Traditional Mehndi',
      'date': '2024-01-20',
      'time': '11:00 AM',
      'amount': '₹600',
      'message': 'Need mehndi for my sister\'s engagement ceremony',
    },
    {
      'customerName': 'Kavya Reddy',
      'service': 'Bridal Mehndi',
      'date': '2024-01-25',
      'time': '1:00 PM',
      'amount': '₹2500',
      'message': 'Looking for intricate bridal designs',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Bookings'),
            Tab(icon: Icon(Icons.notifications), text: 'Requests'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildBookingsTab(),
          _buildRequestsTab(),
          _buildProfileTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${widget.userProfile.fullName ?? 'User'}!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Bookings', '12', Icons.event, Colors.blue),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatCard('This Month', '₹8,500', Icons.currency_rupee, Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Pending Requests', '2', Icons.pending, Colors.orange),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStatCard('Rating', '4.8 ⭐', Icons.star, Colors.amber),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Quick Actions
          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  'Edit Profile',
                  Icons.edit,
                  Colors.red,
                  () => _tabController.animateTo(3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickAction(
                  'View Requests',
                  Icons.notifications,
                  Colors.orange,
                  () => _tabController.animateTo(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: upcomingBookings.length,
      itemBuilder: (context, index) {
        final booking = upcomingBookings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: booking['status'] == 'Confirmed' ? Colors.green : Colors.orange,
              child: Text(
                booking['customerName'][0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(booking['customerName']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${booking['service']} - ${booking['amount']}'),
                Text('${booking['date']} at ${booking['time']}'),
              ],
            ),
            trailing: Chip(
              label: Text(booking['status']),
              backgroundColor: booking['status'] == 'Confirmed' ? Colors.green.shade100 : Colors.orange.shade100,
            ),
            onTap: () => _showBookingDetails(booking),
          ),
        );
      },
    );
  }

  Widget _buildRequestsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookingRequests.length,
      itemBuilder: (context, index) {
        final request = bookingRequests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        request['customerName'][0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request['customerName'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${request['service']} - ${request['amount']}'),
                          Text('${request['date']} at ${request['time']}'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  request['message'],
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _acceptRequest(index),
                        child: const Text('Accept'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () => _declineRequest(index),
                        child: const Text('Decline'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            widget.userProfile.fullName ?? 'User Name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.userProfile.bio ?? 'Professional Service Provider',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),

          _buildProfileOption('Edit Profile Information', Icons.person, () {}),
          _buildProfileOption('Update Pricing', Icons.currency_rupee, () {}),
          _buildProfileOption('Manage Availability', Icons.schedule, () {}),
          _buildProfileOption('Portfolio Management', Icons.photo_library, () {}),
          _buildProfileOption('Reviews & Ratings', Icons.star, () {}),
          _buildProfileOption('Payment Settings', Icons.payment, () {}),
          _buildProfileOption('Notifications', Icons.notifications, () {}),
          _buildProfileOption('Help & Support', Icons.help, () {}),
          
          const SizedBox(height: 20),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () {},
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showBookingDetails(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${booking['customerName']}'),
            Text('Service: ${booking['service']}'),
            Text('Date: ${booking['date']}'),
            Text('Time: ${booking['time']}'),
            Text('Amount: ${booking['amount']}'),
            Text('Status: ${booking['status']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _acceptRequest(int index) {
    setState(() {
      final request = bookingRequests.removeAt(index);
      upcomingBookings.add({
        'customerName': request['customerName'],
        'service': request['service'],
        'date': request['date'],
        'time': request['time'],
        'status': 'Confirmed',
        'amount': request['amount'],
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking request accepted!')),
    );
  }

  void _declineRequest(int index) {
    setState(() {
      bookingRequests.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking request declined')),
    );
  }
}
