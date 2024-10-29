import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  static const String title = 'Другие ситуации';
  static const String header =
      'В случае возникновения других чрезвычайных ситуаций:';
  static const List<Map<String, dynamic>> steps = [
    {
      'icon': Icons.pan_tool_alt,
      'text': 'Сохраняйте спокойствие и не паникуйте.',
    },
    {
      'icon': Icons.search,
      'text': 'Оцените ситуацию и определите, какая помощь вам необходима.',
    },
    {
      'icon': Icons.phone_in_talk,
      'text':
          'Четко и ясно сообщите диспетчеру о происшествии, своем местонахождении и необходимой помощи.',
    },
    {
      'icon': Icons.follow_the_signs,
      'text': 'Следуйте указаниям диспетчера и спасательных служб.',
    },
    {
      'icon': Icons.medical_services,
      'text':
          'По возможности, окажите первую помощь нуждающимся до прибытия специалистов.',
    },
  ];
  static const List<Map<String, dynamic>> emergencyContacts = [
    {'service': 'Пожарная служба', 'number': '101', 'icon': Icons.fire_truck},
    {'service': 'Полиция', 'number': '102', 'icon': Icons.local_police},
    {'service': 'Скорая помощь', 'number': '103', 'icon': Icons.local_hospital},
    {'service': 'МЧС (единый номер)', 'number': '112', 'icon': Icons.shield},
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
                itemCount: steps.length + 1, // +1 for emergency contacts
                itemBuilder: (context, index) {
                  if (index < steps.length) {
                    final step = steps[index];
                    return _buildStepTile(step['icon'], step['text']);
                  } else {
                    return _buildEmergencyContacts();
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildMchsLink(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTile(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }

  Widget _buildEmergencyContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Позвоните в соответствующую службу экстренной помощи:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...emergencyContacts.map((contact) => _buildContactTile(
              contact['service'],
              contact['number'],
              contact['icon'],
            )),
      ],
    );
  }

  Widget _buildContactTile(String service, String number, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(service),
      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            final Uri url = Uri(scheme: 'tel', path: number);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              debugPrint('Could not launch $url');
            }
          },
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMchsLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async {
          const url = 'https://mchs.gov.kg/';
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url));
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Не удалось открыть ссылку')),
              );
            }
          }
        },
        child: const Text('Официальный сайт МЧС КР'),
      ),
    );
  }
}
