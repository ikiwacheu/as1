import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FireScreen extends StatelessWidget {
  const FireScreen({super.key});

  static const String title = 'Действия при пожаре';
  static const String header = 'В случае возникновения пожара:';
  static const String fireServiceNumber = '101';
  static const List<Map<String, dynamic>> steps = [
    {
      'text': 'Немедленно позвоните в пожарную службу по номеру ',
      'phoneNumber': fireServiceNumber,
      'icon': Icons.phone
    },
    {
      'text':
          'Сообщите диспетчеру точный адрес пожара и кратко опишите ситуацию.',
      'icon': Icons.location_on
    },
    {
      'text':
          'По возможности, попробуйте потушить пожар самостоятельно, используя огнетушитель или подручные средства (вода, песок, плотная ткань).',
      'icon': Icons.fire_extinguisher
    },
    {
      'text':
          'Если потушить пожар не удается, немедленно покиньте помещение, предупредив всех находящихся внутри.',
      'icon': Icons.exit_to_app
    },
    {
      'text':
          'При эвакуации двигайтесь к выходу, пригнувшись к полу, чтобы избежать отравления дымом.',
      'icon': Icons.directions_run
    },
    {'text': 'Не пользуйтесь лифтом.', 'icon': Icons.elevator},
    {
      'text':
          'Если пути эвакуации отрезаны, найдите безопасное место (балкон, лоджия) и дождитесь прибытия пожарных.',
      'icon': Icons.home
    },
    {
      'text':
          'Помните, что ваша безопасность - главное! Не рискуйте своей жизнью.',
      'icon': Icons.warning
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              header,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: steps.length,
                itemBuilder: (context, index) {
                  final step = steps[index];
                  return _buildStepTile(
                    step['text'],
                    step['phoneNumber'],
                    step['icon'],
                    context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each step tile.
  Widget _buildStepTile(
      String text, String? phoneNumber, IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: text, style: const TextStyle(fontSize: 16)),
              if (phoneNumber != null)
                WidgetSpan(
                  child: InkWell(
                    onTap: () => _launchPhoneCall(phoneNumber, context),
                    child: Text(
                      phoneNumber,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Launches a phone call to the provided number.
  Future<void> _launchPhoneCall(String number, BuildContext context) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось позвонить')),
        );
      }
    }
  }
}
