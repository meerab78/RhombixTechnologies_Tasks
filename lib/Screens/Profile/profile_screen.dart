import 'package:flutter/material.dart';
import 'package:college_alert_app/Screens/Profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  static Widget infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFC9A36A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Meerab Shahbaz";
  String email = "meerab@gmail.com";
  String phone = "+92 300 1234567";
  String department = "Computer Science";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F1),
      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 24),
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
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // 🔙 BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF3E2C1C),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 6),

                // 👤 AVATAR
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Color(0xFFC9A36A),
                  child: Icon(Icons.person, size: 48, color: Colors.white),
                ),

                const SizedBox(height: 12),

                // NAME
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3E2C1C),
                  ),
                ),

                const SizedBox(height: 4),

                // EMAIL
                Text(email, style: const TextStyle(color: Color(0xFF6D4C41))),

                const SizedBox(height: 4),

                // ROLE
                const Text(
                  "Flutter Developer",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6D4C41),
                  ),
                ),
              ],
            ),
          ),

          // ================= BODY =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  ProfileScreen.infoTile(
                    icon: Icons.phone,
                    title: "Phone",
                    value: phone,
                  ),
                  ProfileScreen.infoTile(
                    icon: Icons.school,
                    title: "Department",
                    value: department,
                  ),
                  ProfileScreen.infoTile(
                    icon: Icons.confirmation_number,
                    title: "Roll No",
                    value: "CS-2023-045",
                  ),
                  ProfileScreen.infoTile(
                    icon: Icons.location_on,
                    title: "Location",
                    value: "Lahore, Pakistan",
                  ),

                  const SizedBox(height: 30),

                  // ✏️ EDIT PROFILE
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(
                            name: name,
                            email: email,
                            phone: phone,
                            department: department,
                          ),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          name = result["name"];
                          email = result["email"];
                          phone = result["phone"];
                          department = result["department"];
                        });
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC9A36A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🚪 LOGOUT
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
