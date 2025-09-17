import 'package:flutter/material.dart';
import 'portfolio_page.dart';
import 'user_profile_data.dart';

class AvailabilitySchedulePage extends StatefulWidget {
  final UserProfileData userProfile;
  
  const AvailabilitySchedulePage({super.key, required this.userProfile});

  @override
  _AvailabilitySchedulePageState createState() => _AvailabilitySchedulePageState();
}

class _AvailabilitySchedulePageState extends State<AvailabilitySchedulePage> {
  @override
  void initState() {
    super.initState();
    // Use the availability from user profile
    weeklyAvailability = Map.from(widget.userProfile.weeklyAvailability);
  }

  late Map<String, String> weeklyAvailability;

  void _editTimeSlot(String day) {
    final TextEditingController controller = TextEditingController();
    controller.text = weeklyAvailability[day]!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $day'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Time (e.g., 10:00 AM - 7:00 PM or Off)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  weeklyAvailability[day] = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Availability & Schedule'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: weeklyAvailability.keys.map((day) {
                return ListTile(
                  title: Text(day),
                  subtitle: Text(weeklyAvailability[day]!),
                  trailing: Icon(Icons.edit),
                  onTap: () => _editTimeSlot(day),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  // Update user profile with availability changes
                  widget.userProfile.weeklyAvailability = weeklyAvailability;
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PortfolioPage(userProfile: widget.userProfile),
                    ),
                  );
                },
                child: const Text('Next: Portfolio & Pricing'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
