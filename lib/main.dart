// lib/main.dart
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

<<<<<<< HEAD
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
=======
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(camera: cameras.first));
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});
  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Dropdown Aerolíneas',
=======
      title: 'Demo en Componentes',
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: const MyHomePage(title: 'Ejemplo de DropdownMenu'),
=======
      home: HomePage(camera: camera),
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c
    );
  }
}

<<<<<<< HEAD
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
=======
/* ─────────────────────────── Modelos/Tipos ─────────────────────────── */

typedef LogoEntry = DropdownMenuEntry<LogoOption>;

enum LogoOption {
  blue('Azul', 'assets/logos/blue.png'),
  pink('Rosa', 'assets/logos/pink.png'),
  green('Verde', 'assets/logos/green.png'),
  orange('Naranja', 'assets/logos/orange.png'),
  grey('Gris', 'assets/logos/grey.png');

  const LogoOption(this.label, this.asset);
  final String label;
  final String asset;
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c

  static final List<LogoEntry> entries = UnmodifiableListView<LogoEntry>(
    values.map((o) => LogoEntry(value: o, label: o.label)),
  );
}

<<<<<<< HEAD
class _MyHomePageState extends State<MyHomePage> {
  ColorLabel _selectedColor = ColorLabel.aerolinea1;
=======
enum AnalyzeStatus { idle, analyzing, ok, fail }

/* ─────────────────────────── Página principal ─────────────────────────── */

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.camera});
  final CameraDescription camera;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late CameraController _controller;
  late Future<void> _initCamera;

  LogoOption _selectedLogo = LogoOption.blue;
  AnalyzeStatus _status = AnalyzeStatus.idle;
  bool _isRecording = false;
  String _analysisText = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = CameraController(widget.camera, ResolutionPreset.medium, enableAudio: true);
    _initCamera = _controller.initialize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _controller = CameraController(widget.camera, ResolutionPreset.medium, enableAudio: true);
      _initCamera = _controller.initialize();
      setState(() {});
    }
  }

  Future<void> _toggleRecord() async {
    await _initCamera;
    if (_isRecording) {
      final file = await _controller.stopVideoRecording();
      setState(() => _isRecording = false);
      await _analyzeVideo(file.path);
    } else {
      await _controller.prepareForVideoRecording();
      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
        _status = AnalyzeStatus.idle;
        _analysisText = '';
      });
    }
  }

  Future<void> _analyzeVideo(String path) async {
    setState(() => _status = AnalyzeStatus.analyzing);
    // ⬇️ Reemplaza esta simulación por tu análisis real:
    await Future.delayed(const Duration(seconds: 2));
    final ok = path.length.isEven; // demo
    setState(() {
      _status = ok ? AnalyzeStatus.ok : AnalyzeStatus.fail;
      _analysisText = ok
          ? 'Análisis exitoso: patrón detectado.'
          : 'Análisis fallido: sin coincidencias.';
    });
  }
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      appBar: LogoSelectorAppBar(
        selected: _selectedLogo,
        onChanged: (v) => setState(() => _selectedLogo = v),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SectionTitle('Cámara'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CameraPreviewPane(controller: _controller, initFuture: _initCamera),
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: StatusRow(
                status: _status,
                text: _analysisText.isEmpty
                    ? (_isRecording ? 'Grabando… detén para analizar.' : 'El texto aparecerá tras el análisis.')
                    : _analysisText,
              ),
            ),
            const SizedBox(height: 72), // espacio para el FAB
          ],
        ),
      ),
<<<<<<< HEAD
=======
      floatingActionButton: RecordFab(
        isRecording: _isRecording,
        onPressed: _toggleRecord,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

/* ─────────────────────────── Componentes UI ─────────────────────────── */

class LogoSelectorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LogoSelectorAppBar({super.key, required this.selected, required this.onChanged});
  final LogoOption selected;
  final ValueChanged<LogoOption> onChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(selected.asset, height: 36, fit: BoxFit.contain),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<LogoOption>(
              value: selected,
              icon: const Icon(Icons.arrow_drop_down),
              items: LogoOption.values
                  .map((o) => DropdownMenuItem(value: o, child: Text(o.label)))
                  .toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CameraPreviewPane extends StatelessWidget {
  const CameraPreviewPane({super.key, required this.controller, required this.initFuture});
  final CameraController controller;
  final Future<void> initFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.done) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: controller.value.previewSize != null
                  ? controller.value.previewSize!.width / controller.value.previewSize!.height
                  : 3 / 4,
              child: CameraPreview(controller),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class StatusRow extends StatelessWidget {
  const StatusRow({super.key, required this.status, required this.text});
  final AnalyzeStatus status;
  final String text;

  Color get _color => switch (status) {
        AnalyzeStatus.idle => Colors.grey,
        AnalyzeStatus.analyzing => Colors.amber,
        AnalyzeStatus.ok => Colors.green,
        AnalyzeStatus.fail => Colors.red,
      };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(color: _color, shape: BoxShape.circle)),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(text),
          ),
        ),
      ],
    );
  }
}

class RecordFab extends StatelessWidget {
  const RecordFab({super.key, required this.isRecording, required this.onPressed});
  final bool isRecording;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: Icon(isRecording ? Icons.stop : Icons.videocam),
      label: Text(isRecording ? 'Detener y analizar' : 'Grabar video'),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: Theme.of(context).textTheme.titleLarge),
      ),
>>>>>>> 5b5c28e2e9b1650e0121bab486f4f150106cac5c
    );
  }
}