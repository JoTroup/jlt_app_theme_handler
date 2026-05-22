import 'package:flutter/material.dart';
import 'package:jlt_app_theme_handler/jlt_app_theme_handler.dart';

void main() {
  runApp(const ThemeExampleApp());
}

class ThemeExampleApp extends StatelessWidget {
  const ThemeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return ValueListenableBuilder<ThemeData>(
      valueListenable: appTheme.theme,
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'JLT Theme Handler Example',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const ThemePreviewPage(),
        );
      },
    );
  }
}

class ThemePreviewPage extends StatefulWidget {
  const ThemePreviewPage({super.key});

  @override
  State<ThemePreviewPage> createState() => _ThemePreviewPageState();
}

class _ThemePreviewPageState extends State<ThemePreviewPage> {
  final AppTheme appTheme = AppTheme();
  final List<String> appModes = <String>['Light', 'Dark', 'System'];

  final List<Color> swatches = <Color>[
    const Color(0xFFFF5400),
    const Color(0xFF0F62FE),
    const Color(0xFF2A9D8F),
    const Color(0xFF8A2BE2),
  ];

  late Color selectedColor;
  String selectedMode = 'Light';
  bool isSwitchOn = true;
  int radioSelection = 0;
  bool isCheckboxChecked = false;

  @override
  void initState() {
    super.initState();
    selectedColor = appTheme.getPrimaryColour();
  }

  void _applyPrimaryColor(Color color) {
    setState(() {
      selectedColor = color;
    });

    appTheme.setPrimaryColour(primaryColour: color);
    appTheme.updateTheme(appTheme.getThemeData(colour: color));
  }

  void _showThemeDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Dialog preview', style: appTheme.getH3TextStyle()),
          content: Text(
            'This dialog uses the theme dialog styles and typography.',
            style: appTheme.getBodyTextStyle(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
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
        title: Text(
          'Theme handler emulator demo',
          style: appTheme.getH2TextStyle(),
        ),
      ),
      body: Container(
        padding: AppTheme().getAppPadding(),
        child: ListView(
          padding: appTheme.getAppPadding(),
          children: [
            Text('Theme preview', style: appTheme.getH1TextStyle()),
            const SizedBox(height: 6),
            Text(
              'Preview core components using the current theme settings.',
              style: appTheme.getBodyTextStyle(),
            ),
            const SizedBox(height: 18),
            Text('Primary color', style: appTheme.getH3TextStyle()),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children: swatches.map((color) {
                final bool isSelected =
                    selectedColor.toARGB32() == color.toARGB32();
                return InkWell(
                  borderRadius: appTheme.primaryBorderRadius,
                  onTap: () => _applyPrimaryColor(color),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: appTheme.primaryBorderRadius,
                      border: Border.all(
                        color: isSelected ? Colors.black87 : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Buttons', style: appTheme.getH3TextStyle()),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Primary action'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined action'),
                ),
                TextButton(
                  onPressed: _showThemeDialog,
                  child: const Text('Open dialog'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Inputs', style: appTheme.getH3TextStyle()),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                hintText: 'InputDecoration preview',
                prefixText: 'Label ',
              ),
            ),
            const SizedBox(height: 12),
            DropdownMenu<String>(
              leadingIcon: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Mode',
                  style: appTheme.getBodyTextStyle(),
                ),
              ),
              hintText: 'Select mode',
              initialSelection: selectedMode,
              width: 280,
              onSelected: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  selectedMode = value;
                });
              },
              dropdownMenuEntries: appModes
                  .map(
                    (mode) =>
                        DropdownMenuEntry<String>(value: mode, label: mode),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            Text('Toggles', style: appTheme.getH3TextStyle()),
            const SizedBox(height: 12),
            SwitchListTile(
              value: isSwitchOn,
              contentPadding: EdgeInsets.zero,
              title: Text('Enable feature', style: appTheme.getBodyTextStyle()),
              onChanged: (value) {
                setState(() {
                  isSwitchOn = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<int>(
                  value: 0,
                  groupValue: radioSelection,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      radioSelection = value;
                    });
                  },
                ),
                Text('Option A', style: appTheme.getBodyTextStyle()),
                const SizedBox(width: 16),
                Radio<int>(
                  value: 1,
                  groupValue: radioSelection,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      radioSelection = value;
                    });
                  },
                ),
                Text('Option B', style: appTheme.getBodyTextStyle()),
              ],
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: isCheckboxChecked,
              contentPadding: EdgeInsets.zero,
              title: Text('Remember selection', style: appTheme.getBodyTextStyle()),
              onChanged: (value) {
                setState(() {
                  isCheckboxChecked = value ?? false;
                });
              },
            ),
            const SizedBox(height: 24),
            Text('Indicators', style: appTheme.getH3TextStyle()),
            const SizedBox(height: 12),
            Row(
              children: [
                CircularProgressIndicator(color: appTheme.getPrimaryColour()),
                const SizedBox(width: 12),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.6,
                    color: appTheme.getPrimaryColour(),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Current: #${appTheme.getPrimaryColour().toARGB32().toRadixString(16).toUpperCase()}',
              style: appTheme.getBodyTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
