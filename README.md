# TypeMonkey

Yet another typing app built with Flutter and Riverpod, available on Desktop (Linux / Windows).

## Features

- Time‑based and word‑based typing tests
- Randomized word sequences for each test run
- Multiple language wordlists (e.g. English, Indonesian variants)
- See your WPM and accuracy progression in each test with a chart

## Requirements

- Flutter SDK `^3.8.1` (see `environment` in `pubspec.yaml`)
- Dart SDK bundled with Flutter

## Getting Started

Install dependencies:

```bash
flutter pub get
```

Create your own .env file based on `sample.env`

```env
WORD_API=http://localhost:8080
ENV=development
```

Run `build_runner`

```bash
dart run build_runner build
```

Run the app (choose one target):

```bash
flutter run -d windows     # Windows desktop
flutter run -d linux       # Linux desktop
flutter run                # use default device
```

Enjoy!

## Running Tests

This project uses `flutter_test` and Riverpod:

```bash
flutter test
```

## Project Structure

- `lib/features/*/domain` – Core models and state (text, practice state)
- `lib/features/*/application` – Riverpod view models/controllers
- `lib/features/*/presentation` – UI widgets and screens
- `lib/features/*/data` – HTTP repository and DTOs for remote wordlists
- `lib/config` - Configuration files and libraries declarations

## Notes

- The app fetches wordlists from a configurable base URL (see `typing_repository.dart` and `sample.env`).
  - You can change the base URL to any other wordlist APIs, or use this [thin API companion](https://github.com/BaldGhost-git/typemonkey_api)
  - Currently, this app is able to use MonkeyType official wordlist API, or any other JSON API that returns `words` variable
- Generated files (`*.g.dart`, `*.freezed.dart`) are produced via `build_runner` and should not be edited by hand.
