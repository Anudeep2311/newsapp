import 'package:news/models/categories_news_model.dart';
import 'package:news/models/news_headline_model.dart';
import 'package:news/repo/news_repo.dart';

class NewsViewModel {
  final _rep = NewsRepo();

  Future<NewsChannelHeadlineModel> fetchNewsChannelApi() async {
    final response = await _rep.fetchNewsChannelApi();
    return response;
  }

  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
