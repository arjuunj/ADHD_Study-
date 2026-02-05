import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme_service.dart';
import '../home/home_page.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  // Mock values for notification settings
  double _volume = 0.5;
  String _sound = 'Chime';

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    // Using a Scaffold with the *current* theme settings to demonstrate changes live
    // However, if the user changes background color, the Scaffold background updates automatically due to main.dart binding
    return Scaffold(
      appBar: AppBar(title: const Text('Customize Your Experience')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Appearance'),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeService.isDarkMode,
              onChanged: (val) {
                themeService.toggleDarkMode(val);
              },
            ),
            const SizedBox(height: 20),

            _buildSectionHeader('Colors'),
            const Text('Background Color'),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildColorCircle(Colors.white, themeService),
                _buildColorCircle(
                  const Color(0xFFF5F5F5),
                  themeService,
                ), // Light Grey
                _buildColorCircle(
                  const Color(0xFFE3F2FD),
                  themeService,
                ), // Light Blue
                _buildColorCircle(
                  const Color(0xFFE8F5E9),
                  themeService,
                ), // Light Green
                _buildColorCircle(
                  const Color(0xFFFFF3E0),
                  themeService,
                ), // Light Orange
                _buildColorCircle(
                  const Color(0xFF121212),
                  themeService,
                ), // Dark
              ],
            ),
            const SizedBox(height: 20),
            const Text('Text Color'),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildColorCircle(Colors.black, themeService, isText: true),
                _buildColorCircle(
                  Colors.grey[800]!,
                  themeService,
                  isText: true,
                ),
                _buildColorCircle(
                  Colors.blue[900]!,
                  themeService,
                  isText: true,
                ),
                _buildColorCircle(Colors.white, themeService, isText: true),
              ],
            ),

            const SizedBox(height: 30),
            _buildSectionHeader('Typography'),
            const Text('Font Size'),
            Slider(
              value: themeService.fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 12,
              label: themeService.fontSize.round().toString(),
              onChanged: (val) {
                themeService.updateFontSize(val);
              },
            ),
            const Text('Font Style'),
            DropdownButton<String>(
              value: themeService.fontFamily,
              items:
                  <String>[
                    'Roboto',
                    'Lato',
                    'Montserrat',
                    'Open Sans',
                    'Oswald',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  themeService.updateFontFamily(newValue);
                }
              },
            ),

            const SizedBox(height: 30),
            _buildSectionHeader('Notifications'),
            const Text('Notification Volume'),
            Slider(
              value: _volume,
              onChanged: (val) {
                setState(() {
                  _volume = val;
                });
              },
            ),
            const Text('Notification Sound'),
            DropdownButton<String>(
              value: _sound,
              items: <String>['Chime', 'Bell', 'Whoosh', 'Ping'].map((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _sound = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'Finish Setup',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildColorCircle(
    Color color,
    ThemeService service, {
    bool isText = false,
  }) {
    bool isSelected = isText
        ? service.textColor.value == color.value
        : service.backgroundColor.value == color.value;

    return GestureDetector(
      onTap: () {
        if (isText) {
          service.updateTextColor(color);
        } else {
          service.updateBackgroundColor(color);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
          boxShadow: isSelected
              ? [const BoxShadow(color: Colors.blue, spreadRadius: 2)]
              : [],
        ),
        child: isSelected
            ? const Icon(Icons.check, size: 20, color: Colors.grey)
            : null,
      ),
    );
  }
}
