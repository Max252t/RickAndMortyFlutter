import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickandmortyflutter/common/navigation/app_router.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/card_surface.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/character_avatar.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/status_label.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CardSurface(
      onTap: () => context.push(AppRoutes.detail(character.id)),
      child: Row(
        spacing: 16,
        children: [
          CharacterAvatar(
            character: character,
            size: 56,
            initialsStyle: theme.textTheme.titleMedium,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(character.name, style: theme.textTheme.titleMedium),
                StatusLabel(character: character),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
