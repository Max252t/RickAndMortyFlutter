import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_bloc.dart';
import 'package:rickandmortyflutter/features/character/presentation/bloc/list/character_list_event.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: context.read<CharacterListBloc>().state.query,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    context.read<CharacterListBloc>().add(const CharacterListQueryChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasQuery = context.select(
      (CharacterListBloc bloc) => bloc.state.query.isNotEmpty,
    );
    return TextField(
      controller: _controller,
      onChanged: (query) => context.read<CharacterListBloc>().add(
        CharacterListQueryChanged(query),
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        labelText: l10n.searchHint,
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(),
        suffixIcon: hasQuery
            ? IconButton(
                onPressed: _clear,
                tooltip: l10n.actionClearSearch,
                icon: const Icon(Icons.close),
              )
            : null,
      ),
    );
  }
}
