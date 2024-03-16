import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotovsk_1/controllers/news_controller/news_controller.dart';
import 'package:kotovsk_1/models/news_model.dart';
import 'package:kotovsk_1/models/request_model.dart';
import 'package:kotovsk_1/repositoryes/storge_repository.dart';
import 'package:kotovsk_1/screens/news_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

import '../constant.dart';

class HeadingPage extends StatefulWidget {
  const HeadingPage({super.key});

  @override
  State<HeadingPage> createState() => _HeadingPageState();
}

class _HeadingPageState extends State<HeadingPage> {

  final TextEditingController _descriptionController = TextEditingController();
  late int newsId;
  late int editId;
  late Request news;

  late int selectedIndex = 0;
  NewsController newsController = NewsController();

  @override
  void initState() {
    super.initState();
    editId = StorageRepository.getInt(key: "editId");
    news = newsController.getNewsById(editId);

    _descriptionController.text = """
 ${news.data?[0].description}
    """;
    newsId = 0; //bu joyda localstorigeda saqlangan idni berib yuborish kk va
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ratio = deviceSize.width / deviceSize.height;
    final animationTransitionPoint = ratio < 9 / 16 ? 0.5 : 0.2;
    // Index of the selected image

    List<NewsModel> newsList = [
      NewsModel(
          id: 1,
          title: "title",
          description: "description",
          imgs: [
            "https://picsum.photos/id/1/200/300",
            "https://picsum.photos/id/2/200/300",
            "https://picsum.photos/id/3/200/300",
            "https://picsum.photos/id/4/200/300",
            "https://picsum.photos/id/5/200/300",
            "https://picsum.photos/id/6/200/300",
            "https://picsum.photos/id/7/200/300",
            "https://picsum.photos/id/8/200/300",
            "https://picsum.photos/id/9/200/300",
          ],
          cover_img: 'https://picsum.photos/id/14/200/300'), //network orqali
    ];

    return MaterialApp(
        home: Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 81.0, top: 50),
            child: Text(
              'Котовск',
              style: GoogleFonts.philosopher(
                textStyle: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 135.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 81),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: deviceSize.width*0.4,
                            child: Container(
                          color: Color(0xFFF6FDC7),
                          child: Column(children: [
                            TextField(
                              controller: _descriptionController,
                              onChanged: (value) {},
                              keyboardType: TextInputType.text,
                              // obscureText: true,

                              textAlign: TextAlign.left,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                isDense: true,
                                hintText: 'Описание новости',
                                contentPadding: EdgeInsets.all(28),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFDBBB69),
                                    width: 5,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFFDBBB69), width: 5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFDBBB69),
                                    width: 5,
                                  ),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              maxLines: 18,
                            ),
                          ]),
                        )),
                        const SizedBox(
                          width: 55,
                        ),
                        // ? Right expended
                        Container(
                          width: deviceSize.width*0.4 +50,
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.s,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                              SizedBox(
                                height: 380,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/loading.gif",
                                      image:
                                          newsList[newsId].imgs[selectedIndex],
                                      placeholderFit: BoxFit.fill,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 34,
                              ),
                              Container(
                                height: 70.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  itemCount: newsList[newsId].imgs.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          // Update the selected index
                                          selectedIndex = index;
                                          print(newsList[newsId]
                                              .imgs[selectedIndex]);
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 88.0,
                                            height: 67.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              border: Border.all(
                                                // color: index != selectedIndex
                                                //     ? Colors.blue
                                                //     : Colors.red,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/images/loading.gif',
                                                image: newsList[newsId]
                                                    .imgs[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ])),
                      ]),
                ),
              ],
            ),
          ),

          // header buttons

          Positioned(
            top: 58,
            right: 176,
            child: ElevatedButton(
              onPressed: () {

                String editDesc = _descriptionController.text.isNotEmpty  ?  _descriptionController.text : news.data?[0]?.description;
                NewsModel newNews =NewsModel(id: news.data?[0]?.id, title:  news.data?[0]?.title,
                    description: editDesc, imgs: news.data?[0]?.imgs, cover_img: news.data?[0]?.cover_img);

                newsController.updateNews(newNews);
                // news =[newNews] ;
                setState(() {

                });


                // Navigator.of(context).push(
                //   TurnPageRoute(
                //     overleafColor: baseColor,
                //     animationTransitionPoint: animationTransitionPoint,
                //     transitionDuration: const Duration(milliseconds: 900),
                //     reverseTransitionDuration:
                //         const Duration(milliseconds: 1000),
                //     builder: (context) => const NewsPage(),
                //   ),
                // );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(219, 187, 105, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
              child: Text(
                'сохранять',
                style: GoogleFonts.philosopher(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 58,
            right: 76,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  TurnPageRoute(
                    overleafColor: baseColor,
                    animationTransitionPoint: animationTransitionPoint,
                    transitionDuration: const Duration(milliseconds: 900),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 1000),
                    builder: (context) => const NewsPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(219, 187, 105, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
              child: Text(
                'назад',
                style: GoogleFonts.philosopher(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
