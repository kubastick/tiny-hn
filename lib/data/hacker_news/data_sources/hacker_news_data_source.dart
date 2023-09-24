import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

part 'hacker_news_data_source.chopper.dart';

@injectable
@ChopperApi(baseUrl: 'https:////hacker-news.firebaseio.com/v0/')
abstract class HackerNewsDataSource extends ChopperService {
  @factoryMethod
  static HackerNewsDataSource create([ChopperClient? client]) => _$HackerNewsDataSource(client);

  @Get(path: '{categoryKey}stories.json')
  Future<Response<List<int>>> getStoriesFromCategory({
    @Path() required String categoryKey,
  });

  @Get(path: 'item/{id}.json')
  Future<Response<Map<String, dynamic>>> getItem({
    @Path() required int id,
  });
}
