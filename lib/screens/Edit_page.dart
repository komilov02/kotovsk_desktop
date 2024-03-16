import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kotovsk_1/controllers/news_controller/news_controller.dart';
import 'package:kotovsk_1/repositoryes/storge_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotovsk_1/screens/Creat_page.dart';

import 'Heading_sceen.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

late  List  newsList ;
NewsController newsController  = NewsController();
@override
void initState() {
  super.initState();
  var data =newsController.getNews();
  newsList =data.data!;
}


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ratio = deviceSize.width / deviceSize.height;
    final animationTransitionPoint = ratio < 9 / 16 ? 0.5 : 0.2;
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
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Редактор Новостей',
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
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
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
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      "assets/images/204.png",
                                      fit: BoxFit.cover,
                                      color: Colors.white.withOpacity(0.9),
                                      colorBlendMode: BlendMode.softLight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 12,
                                  width: 125,
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      StorageRepository.setInt(key: "editId", value:newsList[index]?.id ?? 1 );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const HeadingPage(),
                                        ),
                                      );
                                      // Handle edit button tap
                                      print('Edit button tapped for item ${newsList}');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(246, 253, 199, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5), // Set border radius here
                                      ),
                                      side: const BorderSide(
                                        color:
                                        Color.fromARGB(219, 187, 105, 1), // Set border color here
                                        width: 2, // Set border width here
                                      ),
                                    ),
                                    child: Text(
                                      'Изменить',
                                      style: GoogleFonts.philosopher(
                                        textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 24,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(
                                      'Оборона Ленинграда', // Your text here
                                      style: GoogleFonts.philosopher(
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(246, 253, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set border radius here
                  ),
                  side: const BorderSide(
                    color: Color.fromARGB(
                        219, 187, 105, 1), // Set border color here
                    width: 2, // Set border width here
                  ),
                ),
                child: Text(
                  'Добавить',
                  style: GoogleFonts.philosopher(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
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
                  backgroundColor: const Color.fromRGBO(246, 253, 199, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set border radius here
                  ),
                  side: const BorderSide(
                    color: Color.fromARGB(
                        219, 187, 105, 1), // Set border color here
                    width: 2, // Set border width here
                  ),
                ),
                child: Text(
                  'Выйти',
                  style: GoogleFonts.philosopher(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



















class GridItem extends StatelessWidget {
final List  newsList ;
  const GridItem({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "assets/images/204.png",
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.softLight,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 12,
            width: 125,
            height: 35,
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HeadingPage(),
                  ),
                );
                // Handle edit button tap
                print('Edit button tapped for item ${newsList}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(246, 253, 199, 1),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Set border radius here
                ),
                side: const BorderSide(
                  color:
                      Color.fromARGB(219, 187, 105, 1), // Set border color here
                  width: 2, // Set border width here
                ),
              ),
              child: Text(
                'Изменить',
                style: GoogleFonts.philosopher(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Оборона Ленинграда', // Your text here
                style: GoogleFonts.philosopher(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
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
