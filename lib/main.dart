import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'earthquake_screen.dart';
import 'fire_screen.dart';
import 'news_screen.dart';
import 'other_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'МЧС КР',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        textTheme:
            const TextTheme(bodyMedium: TextStyle(fontFamily: 'ProductSans')),
      ),
      home: const MyHomePage(title: 'МЧС Помощь'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmergencyButton(service: 'Пожарная', number: '101'),
                  SizedBox(height: 20),
                  EmergencyButton(service: 'Полиция', number: '102'),
                  SizedBox(height: 20),
                  EmergencyButton(service: 'Скорая помощь', number: '103'),
                  SizedBox(height: 40),
                  CustomOutlinedButton(
                    buttonText: 'Действия при пожаре',
                    route: FireScreen(),
                  ),
                  SizedBox(height: 20),
                  CustomOutlinedButton(
                    buttonText: 'Действия при землетрясении',
                    route: EarthquakeScreen(),
                  ),
                  SizedBox(height: 20),
                  CustomOutlinedButton(
                    buttonText: 'Другие ситуации',
                    route: OtherScreen(),
                  ),
                  SizedBox(height: 20),
                  CustomOutlinedButton(
                    buttonText: 'Новости МЧС',
                    route: NewsScreen(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmergencyButton extends StatelessWidget {
  final String service;
  final String number;

  const EmergencyButton(
      {super.key, required this.service, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          final Uri url = Uri(scheme: 'tel', path: number);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Не удалось открыть ссылку')),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('$service: $number',
                  style: const TextStyle(fontSize: 20)),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String buttonText;
  final Widget route;

  const CustomOutlinedButton(
      {super.key, required this.buttonText, required this.route});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => route));
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(buttonText),
            ),
          ),
        ),
      ),
    );
  }
}
