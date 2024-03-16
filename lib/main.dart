
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kotovsk_1/constant.dart';
import 'package:kotovsk_1/controllers/news_controller/news_controller.dart';
import 'package:kotovsk_1/models/news_model.dart';
import 'package:kotovsk_1/repositoryes/storge_repository.dart';
import 'package:kotovsk_1/routes.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NewsModelAdapter());
  await Hive.openBox<NewsModel>('news');


  StorageRepository.instance;
  NewsController newsController =NewsController();
  newsController.saveNews(NewsModel(id: 1, title: "title lorem ipsum dur sit test uchun textlar kerkalk akfjkfjkafjdkfjk", description: "description",
      imgs: ["img"], cover_img: "img"));
  runApp(const MyApp());

  windowManager.waitUntilReadyToShow().then((_) async{
    await windowManager.setAsFrameless();
  });

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = Routes.routes();

    return MaterialApp.router(
      routerConfig: routes,
      title: 'TurnPageTransition Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const TurnPageTransitionsTheme(
          overleafColor: baseColor,
          animationTransitionPoint: 0.5,
        ),
        primarySwatch: Colors.blue,
      ),
      // routeInformationParser: routes.routeInformationParser,
      // routerDelegate: routes.routerDelegate,
    );
  }
}







