import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

typedef ColorEntry = DropdownMenuEntry<ColorLabel>;

enum ColorLabel {
  aerolinea1('sahdjasd', Colors.blue),
  aerolinea2('asdasd', Colors.pink),
  aerolinea3('Gad', Colors.green),
  aerolinea4('arqwre', Colors.orange),
  aerolinea5('13123sq', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;

  static final List<ColorEntry> entries = UnmodifiableListView<ColorEntry>(
    values.map<ColorEntry>(
      (ColorLabel color) => ColorEntry(
        value: color,
        label: color.label,
        enabled: color.label != '13123sq',
        style: MenuItemButton.styleFrom(foregroundColor: color.color),
      ),
    ),
  );
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown Aerolíneas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Ejemplo de DropdownMenu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ColorLabel _selectedColor = ColorLabel.aerolinea1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownMenu<ColorLabel>(
              initialSelection: _selectedColor,
              label: const Text('Selecciona una aerolínea'),
              onSelected: (value) {
                if (value != null) setState(() => _selectedColor = value);
              },
              dropdownMenuEntries: ColorLabel.entries, // 🔹 Esto era lo que faltaba
            ),
            const SizedBox(height: 20),
            Text(
              'Seleccionaste: ${_selectedColor.label}',
              style: TextStyle(
                fontSize: 18,
                color: _selectedColor.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}