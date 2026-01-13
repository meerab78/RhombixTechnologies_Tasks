import 'package:college_alert_app/Screens/Alerts/alerts_list_screen.dart';
import 'package:college_alert_app/Screens/Annoucements/annoucements_list_screen.dart';
import 'package:college_alert_app/Screens/Exams/exams_list_screen.dart';
import 'package:college_alert_app/Screens/Profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:college_alert_app/Screens/Events/event_list_screen.dart';
import 'package:college_alert_app/Widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F3EE),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFFF8EE),
        centerTitle: true,
        title: Text(
          "Campus Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmall ? 16 : 18,
            color: const Color(0xFF3E2C1C),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: isSmall ? 20 : 22,
                  color: const Color(0xFF3E2C1C),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            //  WELCOME SECTION (MOBILE OPTIMIZED)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: size.height * 0.035,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF8EE),
                    Color(0xFFEADBC8),
                    Color(0xFFC9A36A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to College Alert 👋",
                    style: TextStyle(
                      fontSize: isSmall ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E2C1C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Stay updated with campus events, exams,\nannouncements and important alerts.",
                    style: TextStyle(
                      fontSize: isSmall ? 13 : 14,
                      height: 1.4,
                      color: const Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // DASHBOARD GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.95, 
                  children: [
                    DashboardCard(
                      title: "Events",
                      icon: Icons.event,
                      color: const Color(0xFFC9A36A),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EventListScreen()),
                        );
                      },
                    ),
                    DashboardCard(
                      title: "Exams",
                      icon: Icons.assignment,
                      color: Colors.blueAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ExamListScreen()),
                        );
                      },
                    ),
                    DashboardCard(
                      title: "Announcements",
                      icon: Icons.campaign,
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AnnouncementListScreen(),
                          ),
                        );
                      },
                    ),
                    DashboardCard(
                      title: "Alerts",
                      icon: Icons.notifications,
                      color: Colors.redAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AlertListScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
