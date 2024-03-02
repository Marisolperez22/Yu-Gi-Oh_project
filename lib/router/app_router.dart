import 'package:go_router/go_router.dart';
import 'package:ygo_project/models/card_model.dart';
import 'package:ygo_project/screens/home_screen.dart';

import '../screens/archetypes_screen.dart';
import '../screens/card_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
            path: 'card',
            builder: (context, state) {
              final card = state.extra as CardInfo;
              return CardScreen(card: card);
            }),
        GoRoute(
            path: 'archetypes',
            builder: (context, state) {
              return ArchetypesScreen();
            }),
      ]),
]);
