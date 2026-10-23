import 'package:flutter/material.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/presentation/utils/character_format.dart';

class CharacterAvatar extends StatelessWidget {
  const CharacterAvatar({
    super.key,
    required this.character,
    required this.size,
    required this.initialsStyle,
  });

  final CharacterModel character;
  final double size;
  final TextStyle? initialsStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = Text(
      character.initials,
      style: initialsStyle?.copyWith(color: scheme.onPrimaryContainer),
    );
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.primaryContainer,
        border: Border.all(color: character.status.color, width: 3),
      ),
      child: character.image.isEmpty
          ? placeholder
          : Image.network(
              character.image,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => placeholder,
            ),
    );
  }
}
