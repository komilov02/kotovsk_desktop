import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotovsk_1/controllers/news_controller/news_controller.dart';
import 'package:kotovsk_1/repositoryes/storge_repository.dart';
import 'package:kotovsk_1/screens/Heading_sceen.dart';
import 'package:turn_page_transition/turn_page_transition.dart';
import '../constant.dart';
import 'HomeScreen.dart';
import 'Password_Screen.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List newsList = []; // `News` obyektlari ro'yxati

  NewsController newsController = NewsController();

  @override
  void initState() {
    super.initState();
    // getNews metodini chaqirish
    var data = newsController.getNews();
    // Agar data bo'sh emas bo'lsa, newsList ni to'ldirish
    if (data.data != null) {
      setState(() {
        newsList = data.data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ratio = deviceSize.width / deviceSize.height;
    final animationTransitionPoint = ratio < 9 / 16 ? 0.5 : 0.2;

    return Scaffold(
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
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Новости',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: newsList.isEmpty
                        ? const Center(
                            child: Text(
                            'Нет доступных новостей😔😒',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ))
                        : SingleChildScrollView(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 1.5,
                                mainAxisSpacing: 20.0,
                              ),
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: newsList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            HomeScreen(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                          
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          var offsetAnimation =
                                              animation.drive(tween);
                          
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      StorageRepository.setInt(key: "editId", value:newsList[index]?.id ?? 1 );
                          
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) =>
                                          const HeadingPage(),
                                          transitionsBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            var begin = const Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;
                          
                                            var tween = Tween(begin: begin, end: end).chain(CurveTween(
                                              curve: curve,
                                            ));
                                            var offsetAnimation = animation.drive(tween);
                          
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    } ,
                                    child: Stack(
                                      children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox(
                                          width: deviceSize.width*0.3 +17,
                                            height: deviceSize.height*0.42,
                                            child: Image.asset("assets/images2/1.png" ,fit: BoxFit.contain,)) ,
                                            // child: Image.file(File("C:/Users/shera/AppData/Local/Temp/${newsList[index].cover_img}") ,fit: BoxFit.contain,)) ,
                                      ),
                                        Opacity(
                                          opacity: 0.9,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(0, 0, 0, 1),
                                                   Color(0xFFD7DEAF),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                  ),
                                                  borderRadius: BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 41,
                                            bottom: 50,
                                            child: Text(
                                                "title${newsList[index]?.title}: desc :${newsList[index]?.description}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.philosopher(
                                                  textStyle: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 25,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                )))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                        ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 58,
            right: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  TurnPageRoute(
                    overleafColor: baseColor,
                    animationTransitionPoint: animationTransitionPoint,
                    transitionDuration: const Duration(milliseconds: 900),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 900),
                    builder: (context) => const PasswordPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(219, 187, 105, 1.0),
              ),
              child: Text(
                'Добавить',
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
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(219, 187, 105, 1.0),
              ),
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
    );
  }
}
