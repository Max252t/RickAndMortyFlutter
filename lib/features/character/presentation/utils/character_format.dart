import 'package:flutter/material.dart';
import 'package:rickandmortyflutter/common/theme/app_colors.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

extension CharacterFormat on CharacterModel {
  String get initials => name
      .split(' ')
      .where((word) => word.isNotEmpty)
      .take(2)
      .map((word) => word[0].toUpperCase())
      .join();

  String? get displayType => type.isEmpty ? null : type;

  ImageProvider get imageProvider => image.startsWith('http')
      ? NetworkImage(image)
      : AssetImage(image) as ImageProvider;
}

extension CharacterStatusFormat on CharacterStatus {
  Color get color => switch (this) {
    CharacterStatus.alive => AppColors.statusAlive,
    CharacterStatus.dead => AppColors.statusDead,
    CharacterStatus.unknown => AppColors.statusUnknown,
  };

  String label(AppLocalizations l10n) => switch (this) {
    CharacterStatus.alive => l10n.statusAlive,
    CharacterStatus.dead => l10n.statusDead,
    CharacterStatus.unknown => l10n.statusUnknown,
  };
}

extension CharacterGenderFormat on CharacterGender {
  String label(AppLocalizations l10n) => switch (this) {
    CharacterGender.female => l10n.genderFemale,
    CharacterGender.male => l10n.genderMale,
    CharacterGender.genderless => l10n.genderGenderless,
    CharacterGender.unknown => l10n.genderUnknown,
  };
}
