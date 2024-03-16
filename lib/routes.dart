import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kotovsk_1/screens/Edit_page.dart';
import 'package:kotovsk_1/screens/HomeScreen.dart';
import 'package:kotovsk_1/screens/news_page.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class Routes {
  const Routes();

  static const home = '/';
  static const first = '/news';
  static const second = '/edit';

  static GoRouter routes({String? initialLocation}) {
    return GoRouter(
      initialLocation: initialLocation ?? home,
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: first,
          builder: (context, state) => const NewsPage(),
        ),
        GoRoute(
          path: second,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const EditPage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) =>
                TurnPageTransition(
              animation: animation,
              overleafColor: Colors.blueAccent,
              animationTransitionPoint: 0.5,
              direction: TurnDirection.rightToLeft,
              child: child,
            ),
          ),
        ),
      ],
      errorBuilder: (context, state) => const Scaffold(),
    );
  }
}
