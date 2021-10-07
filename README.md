# vehicles_app

This is a simple clean architecture example app.


## Project setup

```flutter pub get```

```flutter run```


## Unit tests

```flutter test --coverage```

```genhtml coverage/lcov.info -o coverage/html```

```open -a "Google Chrome" coverage/html/index.html``` (on MacOS)

## Integration tests

```flutter drive --target=test_driver/app.dart```

## Other
Generate mock classes (see https://pub.dev/packages/mockito)<br>
```flutter packages pub run build_runner build```