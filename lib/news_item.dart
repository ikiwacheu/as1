/// Represents a news item fetched from the MCHS website.
class NewsItem {
  /// The title of the news item.
  final String title;

  /// The URL link to the full news article.
  final String link;

  /// The publication date of the news item.
  final DateTime? publicationDate;

  /// Creates a new [NewsItem].
  NewsItem({
    required this.title,
    required this.link,
    this.publicationDate,
  });

  @override
  String toString() {
    return 'NewsItem(title: $title, link: $link, publicationDate: $publicationDate)';
  }
}
