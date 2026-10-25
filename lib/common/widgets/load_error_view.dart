import 'package:flutter/material.dart';
import 'package:rickandmortyflutter/common/network/load_exception.dart';
import 'package:rickandmortyflutter/l10n/app_localizations.dart';

class LoadErrorView extends StatelessWidget {
  const LoadErrorView({super.key, required this.error, required this.onRetry});

  final LoadException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final message = switch (error) {
      NoConnectionException() => l10n.errorNoConnection,
      TimeoutLoadException() => l10n.errorTimeout,
      NotFoundException() => l10n.errorNotFound,
      ServerException(:final statusCode) => l10n.errorServer(
        statusCode?.toString() ?? '?',
      ),
      BadResponseException() => l10n.errorBadResponse,
    };
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Icon(
            Icons.cloud_off,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          FilledButton.tonal(onPressed: onRetry, child: Text(l10n.actionRetry)),
        ],
      ),
    );
  }
}
