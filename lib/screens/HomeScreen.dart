import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

import '../constant.dart';
import 'news_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  // final List<Widget> pages = [
  // BeginWayPage(),
  // CityPage(),
  // KotovskTodayPage(),
  // HistoryScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final ratio = deviceSize.width / deviceSize.height;
    final animationTransitionPoint = ratio < 9 / 16 ? 0.5 : 0.2;
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
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
                      child: Animate(
                        effects: [const FadeEffect(), const ScaleEffect()],
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Image.asset(
                                "assets/images/${index + 1}.png",
                                fit: BoxFit.cover,
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
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    print("news pressed");
                    Navigator.of(context).push(
                      TurnPageRoute(
                        overleafColor: baseColor,
                        animationTransitionPoint: animationTransitionPoint,
                        transitionDuration: const Duration(milliseconds: 900),
                        reverseTransitionDuration:
                            const Duration(milliseconds: 900),
                        builder: (context) => const NewsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(219, 187, 105, 1.0),
                  ),
                  child: Text(
                    'Новости',
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
        ),
      ),
    );
  }
}
