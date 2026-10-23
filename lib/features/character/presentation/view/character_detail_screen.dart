import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/widgets/app_scaffold.dart';
import 'package:rickandmortyflutter/common/widgets/centered_message.dart';
import 'package:rickandmortyflutter/common/widgets/load_error_view.dart';
import 'package:rickandmortyflutter/features/character/domain/character_model.dart';
import 'package:rickandmortyflutter/features/character/domain/i_character_repository.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_event.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/detail/character_detail_state.dart';
import 'package:rickandmortyflutter/features/character/presentation/utils/character_format.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/character_avatar.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/character_card.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/info_row.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/section.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/status_label.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterDetailBloc(context.read<ICharacterRepository>())
            ..add(CharacterDetailOpened(id)),
      child: AppScaffold(
        body: BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
          builder: (context, state) => switch (state) {
            CharacterDetailLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CharacterDetailNotFound(:final id) => CenteredMessage(
              icon: Icons.person_off,
              text: AppLocalizations.of(context).detailNotFound(id),
            ),
            CharacterDetailFailure(:final id, :final error) => Center(
              child: LoadErrorView(
                error: error,
                onRetry: () => context.read<CharacterDetailBloc>().add(
                  CharacterDetailRetried(id),
                ),
              ),
            ),
            CharacterDetailLoaded(:final character, :final neighbours) =>
              _DetailContent(character: character, neighbours: neighbours),
          },
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.character, required this.neighbours});

  final CharacterModel character;
  final List<CharacterModel> neighbours;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final type = character.displayType;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            spacing: 12,
            children: [
              CharacterAvatar(
                character: character,
                size: 160,
                initialsStyle: theme.textTheme.displayMedium,
              ),
              Text(
                character.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium,
              ),
              StatusLabel(character: character),
              Section(title: l10n.sectionInfo),
              Column(
                children: [
                  InfoRow(
                    label: l10n.detailStatus,
                    value: character.status.label(l10n),
                  ),
                  InfoRow(label: l10n.detailSpecies, value: character.species),
                  if (type != null)
                    InfoRow(label: l10n.detailType, value: type),
                  InfoRow(
                    label: l10n.detailGender,
                    value: character.gender.label(l10n),
                  ),
                  InfoRow(
                    label: l10n.detailOrigin,
                    value: character.origin.name,
                  ),
                  InfoRow(
                    label: l10n.detailLocation,
                    value: character.location.name,
                  ),
                  InfoRow(
                    label: l10n.detailEpisodes,
                    value: '${character.episodeIds.length}',
                  ),
                  InfoRow(
                    label: l10n.detailCreated,
                    value: l10n.createdDate(character.created),
                  ),
                ],
              ),
              if (neighbours.isNotEmpty) ...[
                Section(title: l10n.sectionNeighbours),
                for (final neighbour in neighbours)
                  CharacterCard(character: neighbour),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
