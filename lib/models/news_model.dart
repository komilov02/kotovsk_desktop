
import 'package:hive/hive.dart';
part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsModel{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final List<String> imgs;
  @HiveField(4)
  final String cover_img;
  NewsModel( {required this.id,required this.title, required this.description ,required this.imgs ,required this.cover_img});


  NewsModel.noId(this.id,  {required this.title, required this.description ,required this.imgs ,required this.cover_img});
}
