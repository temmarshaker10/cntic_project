import 'package:flutter/material.dart';

class ThemeSwitch extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onToggle;

  // Constructor to receive the theme state and callback
  ThemeSwitch({
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  _ThemeSwitchState createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  late bool _localDarkMode;

  @override
  void initState() {
    super.initState();
    // Initialize the local state with the passed value
    _localDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dark Mode'),
        Switch(
          value: _localDarkMode,
          onChanged: (value) {
            setState(() {
              _localDarkMode = value;
            });
            widget.onToggle(value); // Notify the parent about the change
          },
        ),
      ],
    );
  }
}
