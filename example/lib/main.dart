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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme handler emulator demo')),
      body: Padding(
        padding: appTheme.getAppPadding(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Primary color', style: appTheme.primarySubMenuHeadingStyle),
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
              ElevatedButton(
                onPressed: () {},
                child: const Text('Primary action preview'),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'InputDecoration preview',
                  prefixText: 'Label ',
                ),
              ),
              const SizedBox(height: 12),
              DropdownMenu<String>(
                initialSelection: selectedMode,
                label: const Text('Mode'),
                width: 260,
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
              Row(
                children: [
                  CircularProgressIndicator(color: appTheme.getPrimaryColour()),
                  const SizedBox(width: 12),
                  Text(
                    'Current: #${appTheme.getPrimaryColour().toARGB32().toRadixString(16).toUpperCase()}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
