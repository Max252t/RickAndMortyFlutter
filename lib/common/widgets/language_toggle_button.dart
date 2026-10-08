import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/locale/locale_bloc.dart';
import 'package:rickandmortyflutter/common/locale/locale_event.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextButton(
      onPressed: () => context.read<LocaleBloc>().add(const LocaleToggled()),
      child: Tooltip(
        message: l10n.actionToggleLanguage,
        child: Text(l10n.languageCode),
      ),
    );
  }
}
