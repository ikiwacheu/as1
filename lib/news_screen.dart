import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_item.dart';
import 'news_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsItem>> _newsItemsFuture;
  final String _baseUrl = 'https://mchs.gov.kg';

  @override
  void initState() {
    super.initState();
    _newsItemsFuture = NewsService.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новости МЧС')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _newsItemsFuture = NewsService.fetchNews();
          });
        },
        child: FutureBuilder<List<NewsItem>>(
          future: _newsItemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Ошибка загрузки новостей: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Новостей нет'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final newsItem = snapshot.data![index];
                  return ListTile(
                    title: Text(newsItem.title),
                    subtitle: newsItem.publicationDate != null
                        ? Text(
                            "${newsItem.publicationDate!.day.toString().padLeft(2, '0')}"
                            ".${newsItem.publicationDate!.month.toString().padLeft(2, '0')}"
                            ".${newsItem.publicationDate!.year}",
                          )
                        : null,
                    onTap: () => _launchNewsUrl(newsItem.link),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _launchNewsUrl(String relativeUrl) async {
    final url = Uri.parse(_baseUrl + relativeUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось открыть ссылку')),
        );
      }
    }
  }
}
