import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/locale/locale_bloc.dart';
import 'package:rickandmortyflutter/common/navigation/app_router.dart';
import 'package:rickandmortyflutter/common/theme/app_theme.dart';
import 'package:rickandmortyflutter/common/theme/theme_bloc.dart';
import 'package:rickandmortyflutter/features/character/data/character_repository.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_event.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ICharacterRepository>(
          create: (_) => const CharacterRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CharacterListBloc(context.read<ICharacterRepository>())
                  ..add(const CharacterListStarted()),
          ),
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(
            create: (_) => LocaleBloc(
              AppLocalizations.supportedLocales,
              system: WidgetsBinding.instance.platformDispatcher.locale,
            ),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp.router(
            routerConfig: AppRouter.router,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: context.watch<ThemeBloc>().state,
            locale: context.watch<LocaleBloc>().state,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      ),
    );
  }
}
