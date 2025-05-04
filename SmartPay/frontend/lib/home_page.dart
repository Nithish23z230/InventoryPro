import 'package:flutter/material.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String _hoveredButton = '';
  final TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildQuickActionButton(String text, IconData icon, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredButton = text),
      onExit: (_) => setState(() => _hoveredButton = ''),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: _hoveredButton == text
                ? LinearGradient(
                    colors: [Colors.cyan.shade400, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.cyan.shade400.withOpacity(0.6),
                blurRadius: _hoveredButton == text ? 20 : 10,
                spreadRadius: _hoveredButton == text ? 5 : 2,
                offset: const Offset(0, 3),
              ),
              BoxShadow(
                color: Colors.blue.shade600.withOpacity(0.8),
                blurRadius: _hoveredButton == text ? 30 : 20,
                spreadRadius: _hoveredButton == text ? 8 : 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          transform: _hoveredButton == text
              ? (Matrix4.identity()..scale(1.1))
              : Matrix4.identity(),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            splashColor: Colors.cyanAccent.withOpacity(0.3),
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                    color: Colors.white,
                    size: 30,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      )
                    ]),
                const SizedBox(height: 5),
                Text(text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          )
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("SmartPay Home"),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return CustomPaint(
                painter: _BackgroundPainter(_animationController.value),
                child: Container(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: TextField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search by phone number, UPI ID, or name",
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.search, color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.3,
                    children: [
                      _buildQuickActionButton("Scan QR", Icons.qr_code_scanner, () {}),
                      _buildQuickActionButton("Pay Contacts", Icons.contacts, () {}),
                      _buildQuickActionButton("Pay Phone", Icons.phone, () {}),
                      _buildQuickActionButton("Pay UPI ID", Icons.payment, () {}),
                      _buildQuickActionButton("Self-Help Group", Icons.groups, () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double animationValue;

  _BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.cyan.shade700.withOpacity(0.5),
          Colors.blue.shade400.withOpacity(0.3),
          Colors.transparent,
        ],
        stops: [0.0, 0.6, 1.0],
        center: Alignment(0.0, 0.0),
        radius: 0.9,
        tileMode: TileMode.mirror,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final circleRadius = 120 + 60 * animationValue;
    final circleOffset = Offset(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(circleOffset, circleRadius, paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
