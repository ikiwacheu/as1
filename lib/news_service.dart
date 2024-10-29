import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:logger/logger.dart';
import 'news_item.dart';

class NewsService {
  static final _logger = Logger();
  static const String _baseUrl = 'https://mchs.gov.kg/ru/news/';

  static Future<List<NewsItem>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final newsElements = document.querySelectorAll('.col-md-4');

        _logger.d('Found ${newsElements.length} news elements');

        List<NewsItem> newsList = newsElements
            .map((element) => _parseNewsItem(element))
            .where((item) => item != null)
            .toList()
            .cast<NewsItem>();

        _logger.d('Parsed ${newsList.length} news items');
        return newsList;
      } else {
        _logger.e('Error loading news: ${response.statusCode}');
        throw Exception('Failed to load news: HTTP ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error fetching news: $e');
      throw Exception('Error fetching news: $e');
    }
  }

  static NewsItem? _parseNewsItem(dynamic element) {
    try {
      final titleElement = element.querySelector('h5 > a');
      final title = titleElement?.text.trim() ?? '';

      final linkElement = element.querySelector('h5 > a');
      final relativeLink = linkElement?.attributes['href'] ?? '';
      final link = _baseUrl + relativeLink.replaceAll(_baseUrl, '');

      final dateElement = element.querySelector('.news-date');
      final date = dateElement?.text.trim() ?? '';

      return NewsItem(
        title: title,
        link: link,
        publicationDate: _parseDate(date),
      );
    } catch (e) {
      _logger.e('Error parsing news item: $e');
      return null;
    }
  }

  static DateTime? _parseDate(String dateString) {
    try {
      final regex = RegExp(r'(\d{2}).(\d{2}).(\d{4})');
      final match = regex.firstMatch(dateString);
      if (match != null) {
        final day = int.parse(match.group(1)!);
        final month = int.parse(match.group(2)!);
        final year = int.parse(match.group(3)!);
        return DateTime(year, month, day);
      } else {
        return null;
      }
    } catch (e) {
      _logger.e('Error parsing date: $e');
      return null;
    }
  }
}
