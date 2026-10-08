# Рик и Морти — каталог персонажей (Flutter)

ЛР2 «Каркас». Список персонажей с поиском, деталь со связанными записями
(«Сейчас там же»), светлая и тёмная тема, русский и английский интерфейс.
Данные — 24 персонажа из [Rick and Morty API](https://rickandmortyapi.com),
пока из моков.

## Запуск

```bash
flutter pub get
flutter run -d edge        # или -d chrome
flutter run -d windows
```

`flutter pub get` генерирует код локализации из `lib/l10n/*.arb`, в git его нет.

## Проверка ARB

```bash
dart run tool/check_arb.dart
```

## Устройство

- `lib/features/character/data` — репозиторий на моках
- `lib/features/character/domain` — модель и интерфейс репозитория
- `lib/features/character/presentation` — Bloc, экраны, виджеты, форматирование
- `lib/common` — навигация (go_router), тема, язык, общие виджеты

State manager — `flutter_bloc` (Bloc с sealed-событиями и состояниями).
