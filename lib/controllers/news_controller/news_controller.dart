import 'package:hive/hive.dart';
import 'package:kotovsk_1/models/news_model.dart';
import 'package:kotovsk_1/models/request_model.dart';

class NewsController {
  Box<NewsModel> newsBox = Hive.box<NewsModel>('news');

// List newsModelList = newsBox.values.toList();
// var id = newsModelList.isNotEmpty ? newsModelList.last.id +1 : 1;
// models
// News news =News(id: id, title: "title", description: "description", imgs: ["assets/images/doctor1.png"]);
// catBox.add(cat1);
// catBox.put('key', cat1);

// CatModel? catModel = catBox.get('key');

  Request saveNews(NewsModel news) {
    List newsModelList = newsBox.values.toList();
    int id = newsModelList.length > 0 ? newsModelList.last.id + 1 : 1;

    newsBox.put(news.id, news);
    return Request(status: 201, message: "muvafaqaiyatli qoshildi");
  }

  Request getNews() {
    var allNews = newsBox.values.toList();
    return Request(status: 200, message: 'seccess', data: allNews);
  }
  Request updateNews(NewsModel news) {

    var newNews =NewsModel(id: news.id, title:news.title ,
        description: news.description,
        imgs: news.imgs, cover_img: news.cover_img);
    newsBox.put(news.id, newNews);
    return Request(status: 201, message: "muvafaqaiyatli ozgartirildi " ,data: [newNews]);
  }

  Request getNewsById(int id) {
    var allNews = newsBox.values.toList();
    var findNews = allNews.firstWhere((news) => news.id == id);
    if (findNews == null) {
      return Request(status: 404, message: 'Haber bulunamadı', data: null);
    }
    return Request(status: 200, message: 'Başarılı', data: [findNews]);
  }

  Future<void> deleteNews(int id) async {
    await newsBox.delete(id);
  }
}
