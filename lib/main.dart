import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = Colors.teal;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Нова ТТ',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(
          backgroundColor: seed,
          elevation: 2,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 12.0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: const EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 20.0,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 2),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers for text fields
  final _agentController = TextEditingController();
  final _formatController = TextEditingController();
  final _fopController = TextEditingController();
  final _addressController = TextEditingController();
  final _deferController = TextEditingController();
  final _priceController = TextEditingController();
  final _lprController = TextEditingController();
  final _phoneController = TextEditingController();

  // Checkboxes (one-line 3 options)
  bool _chkShok = false;
  bool _chkKorm = false;
  bool _chkRigli = false;

  // Radio-like selection (single choice among 3)
  int _paymentIndex = -1; // -1 none, 0..2 selected

  // Visit date (now simple text input)
  final _visitController = TextEditingController();

  @override
  void dispose() {
    _agentController.dispose();
    _formatController.dispose();
    _fopController.dispose();
    _addressController.dispose();
    _deferController.dispose();
    _priceController.dispose();
    _lprController.dispose();
    _phoneController.dispose();
    _visitController.dispose();
    super.dispose();
  }

  void _submit() {
    // Build a map of only filled values
    final Map<String, String> data = {};

    void addIfNotEmpty(String key, String? value) {
      if (value != null && value.trim().isNotEmpty) data[key] = value.trim();
    }

    addIfNotEmpty('Торговий агент', _agentController.text);
    addIfNotEmpty('Формат ТТ', _formatController.text);

    final List<String> chk = [];
    if (_chkShok) chk.add('Шок');
    if (_chkKorm) chk.add('Корм');
    if (_chkRigli) chk.add('Ріглі');
    if (chk.isNotEmpty) data['Категорії'] = chk.join(', ');

    addIfNotEmpty('День візиту', _visitController.text);

    addIfNotEmpty('ФОП', _fopController.text);
    addIfNotEmpty('Адреса', _addressController.text);

    final paymentLabels = ['нал/2ф', 'чек/факт', 'б/н'];
    if (_paymentIndex >= 0 && _paymentIndex < paymentLabels.length) {
      data['Тип оплати'] = paymentLabels[_paymentIndex];
    }

    addIfNotEmpty('Відтермінування', _deferController.text);
    addIfNotEmpty('Прайс', _priceController.text);
    addIfNotEmpty('ЛПР', _lprController.text);
    addIfNotEmpty('Телефон', _phoneController.text);

    // Navigate to second page with only filled data
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SecondPage(filledData: data)));
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Нова ТТ')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _label('Торговий агент'),
                TextField(
                  controller: _agentController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('Формат ТТ'),
                TextField(
                  controller: _formatController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('Категорії (поставте галочку)'),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _chkShok,
                            onChanged: (v) {
                              setState(() => _chkShok = v!);
                            },
                          ),
                          const SizedBox(width: 6),
                          const Text('Шок'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _chkKorm,
                            onChanged: (v) {
                              setState(() => _chkKorm = v!);
                            },
                          ),
                          const SizedBox(width: 6),
                          const Text('Корм'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _chkRigli,
                            onChanged: (v) {
                              setState(() => _chkRigli = v!);
                            },
                          ),
                          const SizedBox(width: 6),
                          const Text('Ріглі'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _label('День візиту'),
                TextField(
                  controller: _visitController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('ФОП'),
                TextField(
                  controller: _fopController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('Адреса'),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                const SizedBox(height: 12),
                _label('Тип оплати(нал/2ф, чек.факт, б/н)'),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // calculate equal width per button, leave small gaps
                    final totalGap =
                        16.0; // left/right internal padding handled elsewhere
                    final btnWidth = (constraints.maxWidth - totalGap) / 3;
                    final primaryBlue = Colors.blue;
                    return ToggleButtons(
                      isSelected: List.generate(3, (i) => i == _paymentIndex),
                      onPressed: (i) => setState(
                        () => _paymentIndex = (_paymentIndex == i) ? -1 : i,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black87,
                      selectedColor: Colors.white,
                      fillColor: primaryBlue,
                      borderColor: primaryBlue.withAlpha(150),
                      selectedBorderColor: primaryBlue,
                      constraints: BoxConstraints(
                        minWidth: btnWidth,
                        minHeight: 44,
                      ),
                      children: const [
                        Text('нал/2ф'),
                        Text('чек.факт'),
                        Text('б/н'),
                      ],
                    );
                  },
                ),

                _label('Відтермінування'),
                TextField(
                  controller: _deferController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('Прайс'),
                TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('ЛПР'),
                TextField(
                  controller: _lprController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 12),

                _label('Телефон'),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Перейти на іншу сторінку'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final Map<String, String> filledData;

  const SecondPage({super.key, required this.filledData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Перегляд заповнених даних')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: filledData.isEmpty
            ? const Center(
                child: Text(
                  'Нічого не було введено',
                  style: TextStyle(fontSize: 1),
                ),
              )
            : ListView.separated(
                itemCount: filledData.length,
                separatorBuilder: (_, __) => const SizedBox(height: 0),
                itemBuilder: (context, index) {
                  final key = filledData.keys.elementAt(index);
                  final val = filledData.values.elementAt(index);
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            key,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(val, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
