import 'package:flutter/material.dart';

void main() {
  runApp(const ThemeSwitcherApp());
}

class ThemeSwitcherApp extends StatefulWidget {
  const ThemeSwitcherApp({Key? key}) : super(key: key);

  @override
  _ThemeSwitcherAppState createState() => _ThemeSwitcherAppState();
}

class _ThemeSwitcherAppState extends State<ThemeSwitcherApp> {
  // Track current theme mode
  ThemeMode _currentThemeMode = ThemeMode.light;

  // Custom light theme
  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFD9E1),
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFFD9E1),
      secondary: Color(0xFFF0B7C5),
      background: Colors.white,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Color(0xFFFFD9E1),
      foregroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
  );

  // Custom dark theme
  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF31101B),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF31101B),
      secondary: Color(0xFF3270B0),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    appBarTheme: AppBarTheme(
      color: Color(0xFF31101B),
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );

  // Toggle theme method
  void _toggleTheme() {
    setState(() {
      _currentThemeMode = _currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Switcher',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _currentThemeMode,
      home: ThemeSwitcherPage(
        toggleTheme: _toggleTheme,
        isDarkMode: _currentThemeMode == ThemeMode.dark,
      ),
    );
  }
}

class ThemeSwitcherPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const ThemeSwitcherPage({
    Key? key, 
    required this.toggleTheme, 
    required this.isDarkMode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Switcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Custom Theme Toggle Button
            ElevatedButton(
              onPressed: toggleTheme,
              style: ElevatedButton.styleFrom(
                primary: isDarkMode 
                  ? Color(0xFF3270B0)  // Dark mode secondary color
                  : Color(0xFFF0B7C5), // Light mode secondary color
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                isDarkMode ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Current Theme Indicator
            Text(
              isDarkMode ? 'Dark Theme Active' : 'Light Theme Active',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
