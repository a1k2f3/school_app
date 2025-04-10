import 'package:flutter/material.dart';

void main() {
  runApp(SchoolApp());
}

class SchoolApp extends StatefulWidget {
  const SchoolApp({super.key});

  @override
  _SchoolAppState createState() => _SchoolAppState();
}

class _SchoolAppState extends State<SchoolApp> {
  // Default theme settings
  ThemeData _currentTheme = ThemeData.light();
  Color _primaryColor = Colors.blue;
  double _textScaleFactor = 1.0;
  bool _isDarkMode = false;

  // Updates the theme based on user's customization
  void _updateTheme(Color primaryColor, bool isDarkMode, double textScaleFactor) {
    setState(() {
      _primaryColor = primaryColor;
      _isDarkMode = isDarkMode;
      _textScaleFactor = textScaleFactor;
      _currentTheme = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: _currentTheme.copyWith(
        textTheme: _currentTheme.textTheme.apply(
          fontSizeFactor: _textScaleFactor,
        ),
      ),
      home: ThemeCustomizationPage(
        primaryColor: _primaryColor,
        isDarkMode: _isDarkMode,
        textScaleFactor: _textScaleFactor,
        onThemeChanged: _updateTheme,
      ),
    );
  }
}

class ThemeCustomizationPage extends StatefulWidget {
  final Color primaryColor;
  final bool isDarkMode;
  final double textScaleFactor;
  final Function(Color, bool, double) onThemeChanged;

  const ThemeCustomizationPage({super.key, 
    required this.primaryColor,
    required this.isDarkMode,
    required this.textScaleFactor,
    required this.onThemeChanged,
  });

  @override
  _ThemeCustomizationPageState createState() => _ThemeCustomizationPageState();
}

class _ThemeCustomizationPageState extends State<ThemeCustomizationPage> {
  late Color _selectedColor;
  late bool _darkMode;
  late double _textScale;

  // Define available color options
  final List<Color> _colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.primaryColor;
    _darkMode = widget.isDarkMode;
    _textScale = widget.textScaleFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme & Customization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dark Mode Toggle
            SwitchListTile(
              title: Text('Dark Mode'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
                widget.onThemeChanged(_selectedColor, _darkMode, _textScale);
              },
            ),
            SizedBox(height: 20),
            // Primary Color Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Primary Color:'),
                DropdownButton<Color>(
                  value: _selectedColor,
                  items: _colorOptions.map((color) {
                    return DropdownMenuItem<Color>(
                      value: color,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (Color? newColor) {
                    if (newColor != null) {
                      setState(() {
                        _selectedColor = newColor;
                      });
                      widget.onThemeChanged(_selectedColor, _darkMode, _textScale);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Text Scale Factor Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Text Size (${_textScale.toStringAsFixed(1)}x)'),
                Slider(
                  value: _textScale,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7,
                  label: _textScale.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      _textScale = value;
                    });
                    widget.onThemeChanged(_selectedColor, _darkMode, _textScale);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Preview Area
            Expanded(
              child: Center(
                child: Text(
                  'This is a preview of your theme!',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
