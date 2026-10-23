import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/common/widgets/app_scaffold.dart';
import 'package:rickandmortyflutter/common/widgets/centered_message.dart';
import 'package:rickandmortyflutter/common/widgets/load_error_view.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_event.dart';
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
                    CharacterListFailure(:final error) => Center(
                      child: LoadErrorView(
                        error: error,
                        onRetry: () => context.read<CharacterListBloc>().add(
                          const CharacterListRetried(),
                        ),
                      ),
                    ),
                    CharacterListNotFound(:final query) => CenteredMessage(
                      icon: Icons.search_off,
                      text: AppLocalizations.of(context).listNotFound(query),
                    ),
                    CharacterListLoaded() => _CharacterList(
                      state: state,
                      side: side,
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

class _CharacterList extends StatefulWidget {
  const _CharacterList({required this.state, required this.side});

  final CharacterListLoaded state;
  final double side;

  @override
  State<_CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<_CharacterList> {
  static const double _loadMoreThreshold = 300;

  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = widget.state;
    if (state.nextPage == null ||
        state.isLoadingMore ||
        state.loadMoreError != null) {
      return;
    }
    if (_controller.position.extentAfter < _loadMoreThreshold) {
      context.read<CharacterListBloc>().add(
        const CharacterListNextPageRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final showFooter = state.isLoadingMore || state.loadMoreError != null;
    return ListView.separated(
      controller: _controller,
      padding: EdgeInsets.symmetric(horizontal: widget.side, vertical: 16),
      itemCount: state.items.length + (showFooter ? 1 : 0),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => index < state.items.length
          ? CharacterCard(character: state.items[index])
          : _Footer(state: state),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state});

  final CharacterListLoaded state;

  @override
  Widget build(BuildContext context) {
    final error = state.loadMoreError;
    return Center(
      child: error == null
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            )
          : LoadErrorView(
              error: error,
              onRetry: () => context.read<CharacterListBloc>().add(
                const CharacterListNextPageRequested(),
              ),
            ),
    );
  }
}
