import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmortyflutter/common/widgets/app_scaffold.dart';
import 'package:rickandmortyflutter/common/widgets/centered_message.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/character_detail_screen.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/character_list_screen.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

abstract final class AppRoutes {
  static const String list = '/';
  static String detail(int id) => '/character/$id';
}

abstract final class AppRouter {
  static const Duration _transition = Duration(milliseconds: 300);

  static final GoRouter router = _create();

  static GoRouter _create() {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    return GoRouter(
      initialLocation: AppRoutes.list,
      routes: [
        GoRoute(
          path: AppRoutes.list,
          pageBuilder: (context, state) =>
              _page(state, const CharacterListScreen()),
          routes: [
            GoRoute(
              path: 'character/:id',
              pageBuilder: (context, state) {
                final id = int.tryParse(state.pathParameters['id']!);
                return _page(
                  state,
                  id == null
                      ? const _NotFoundScreen()
                      : CharacterDetailScreen(id: id),
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const _NotFoundScreen(),
    );
  }

  static Page<void> _page(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionDuration: _transition,
      reverseTransitionDuration: _transition,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: CenteredMessage(
        icon: Icons.explore_off,
        text: AppLocalizations.of(context).pageNotFound,
      ),
    );
  }
}
