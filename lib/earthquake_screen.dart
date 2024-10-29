import 'package:flutter/material.dart';

class EarthquakeScreen extends StatelessWidget {
  const EarthquakeScreen({super.key});

  static const String title = 'Действия при землетрясении';
  static const String header = 'Если вы почувствовали толчки:';
  static const List<Map<String, dynamic>> steps = [
    {
      'icon': Icons.sentiment_very_dissatisfied,
      'text': 'Сохраняйте спокойствие и не паникуйте.'
    },
    {
      'icon': Icons.broken_image,
      'text':
          'Если вы находитесь в помещении, отойдите от окон, зеркал и предметов, которые могут упасть.'
    },
    {
      'icon': Icons.table_chart,
      'text':
          'Займите безопасное место: под крепким столом, в углу комнаты, у несущей стены.'
    },
    {
      'icon': Icons.nature_people,
      'text':
          'Если вы находитесь на улице, отойдите от зданий, линий электропередач и деревьев.'
    },
    {
      'icon': Icons.warning_amber_rounded,
      'text':
          'После окончания толчков будьте осторожны, возможны повторные толчки (афтершоки).'
    },
    {
      'icon': Icons.personal_injury,
      'text': 'Проверьте себя и окружающих на наличие травм.'
    },
    {
      'icon': Icons.follow_the_signs,
      'text': 'Следуйте указаниям властей и спасательных служб.'
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
                  return _buildStepTile(step['icon'], step['text']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds each step tile
  Widget _buildStepTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }
}
