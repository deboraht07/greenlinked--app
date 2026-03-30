import 'package:flutter/material.dart';

void main() => runApp(const GreenLinkApp());

class GreenLinkApp extends StatelessWidget {
  const GreenLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF2F0E4),
        primaryColor: const Color(0xFFB4FF00),
        fontFamily: 'Courier',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _activeCategory = "Environmental";

  List<Widget> get _pages => [
        _buildHomeFeed(),
        _buildRankings(),
        _buildCampusHub(),
        _buildProfile(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("GREENLINK",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        shape: const Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 2))),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF8AC700),
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "HOME"),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), label: "RANKING"),
            BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: "CAMPUS"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "PROFILE"),
          ],
        ),
      ),
    );
  }

  // --- 1. HOME ---
  Widget _buildHomeFeed() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("LATEST IMPACT", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 20),
        _impactCard("Stanford University", "SU", "40% solar energy migration complete.", Colors.orange),
        _impactCard("MIT", "MIT", "New campus-wide composting initiative.", Colors.blue),
      ],
    );
  }

  // --- 2. RANKINGS ---
  Widget _buildRankings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("LEADERBOARD", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
        const SizedBox(height: 20),
        _rankCard("#01", "NORDIC INSTITUTE", "99.4"),
        _rankCard("#02", "GREENWICH TECH", "96.8"),
      ],
    );
  }

  // --- 3. CAMPUS HUB ---
  Widget _buildCampusHub() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("REPORT ISSUE", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
        const SizedBox(height: 24),
        Row(
          children: [
            _categoryButton("Infrastructure 🛠", "Infrastructure"),
            const SizedBox(width: 10),
            _categoryButton("Environmental 🌿", "Environmental"),
          ],
        ),
        const SizedBox(height: 24),
        _actionButton("SUBMIT NEW REPORT"),
        const SizedBox(height: 30),
        _statusCard("Broken Solar Lamp", "PENDING", Colors.red),
      ],
    );
  }

  // --- 4. PROFILE ---
  Widget _buildProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("MY IMPACT", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
          const SizedBox(height: 20),
          _profileCard(),
          const SizedBox(height: 30),
          const Text("ACHIEVEMENTS", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _achievementBox("RECYCLE KING", Icons.recycling, true),
              _achievementBox("ENERGY SAVER", Icons.bolt, false),
            ],
          ),
        ],
      ),
    );
  }

  // --- UI HELPERS ---
  Widget _impactCard(String uni, String init, String desc, Color col) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2)),
      child: Column(children: [
        ListTile(title: Text(uni, style: const TextStyle(fontWeight: FontWeight.bold)), leading: CircleAvatar(backgroundColor: const Color(0xFFB4FF00), child: Text(init, style: const TextStyle(color: Colors.black, fontSize: 10)))),
        Container(height: 120, color: col.withOpacity(0.1), child: Icon(Icons.image, color: col)),
        Padding(padding: const EdgeInsets.all(12), child: Text(desc)),
      ]),
    );
  }

  Widget _rankCard(String rank, String name, String score) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(rank, style: const TextStyle(fontWeight: FontWeight.bold)), Text(name), Text(score, style: const TextStyle(color: Color(0xFF8AC700), fontWeight: FontWeight.bold))]),
    );
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2)),
      child: const Center(child: Column(children: [CircleAvatar(radius: 40, backgroundColor: Color(0xFFB4FF00), child: Icon(Icons.person, size: 40, color: Colors.black)), SizedBox(height: 16), Text("USER_ID: 8829", style: TextStyle(fontWeight: FontWeight.bold))])),
    );
  }

  Widget _achievementBox(String label, IconData icon, bool active) {
    return Container(
      decoration: BoxDecoration(color: active ? const Color(0xFFB4FF00) : Colors.white, border: Border.all(width: 2)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon), const SizedBox(height: 8), Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]),
    );
  }

  Widget _categoryButton(String label, String cat) {
    bool isSel = _activeCategory == cat;
    return Expanded(child: GestureDetector(onTap: () => setState(() => _activeCategory = cat), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: isSel ? const Color(0xFFB4FF00) : Colors.white, border: Border.all(width: 2)), child: Center(child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))))));
  }

  Widget _statusCard(String title, String status, Color col) {
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title), Container(padding: const EdgeInsets.all(4), color: col, child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))]));
  }

  Widget _actionButton(String text) {
    return Container(width: double.infinity, height: 55, decoration: BoxDecoration(color: const Color(0xFFB4FF00), border: Border.all(width: 2)), child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold))));
  }
}