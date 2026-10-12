import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/theme/theme_bloc.dart';
import 'package:rickandmortyflutter/common/theme/theme_event.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () => context.read<ThemeBloc>().add(const ThemeToggled()),
      tooltip: AppLocalizations.of(context).actionToggleTheme,
      icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
    );
  }
}
