import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/widgets/app_scaffold.dart';
import 'package:rickandmortyflutter/common/widgets/centered_message.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_state.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/character_card.dart';
import 'package:rickandmortyflutter/features/character/presentation/view/widgets/search_field.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  static const double _maxContentWidth = 720;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final side = math.max(
            16.0,
            (constraints.maxWidth - _maxContentWidth) / 2,
          );
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(side, 16, side, 0),
                child: const SearchField(),
              ),
              Expanded(
                child: BlocBuilder<CharacterListBloc, CharacterListState>(
                  builder: (context, state) => switch (state) {
                    CharacterListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CharacterListNotFound(:final query) => CenteredMessage(
                      icon: Icons.search_off,
                      text: AppLocalizations.of(context).listNotFound(query),
                    ),
                    CharacterListLoaded(:final items) => ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: side,
                        vertical: 16,
                      ),
                      itemCount: items.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          CharacterCard(character: items[index]),
                    ),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
