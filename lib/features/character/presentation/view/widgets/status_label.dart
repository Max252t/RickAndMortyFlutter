import 'package:flutter/material.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/presentation/utils/character_format.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class StatusLabel extends StatelessWidget {
  const StatusLabel({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = character.status.label(AppLocalizations.of(context));
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: character.status.color,
            shape: BoxShape.circle,
          ),
          child: const SizedBox.square(dimension: 8),
        ),
        Flexible(
          child: Text(
            '$status · ${character.species}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
