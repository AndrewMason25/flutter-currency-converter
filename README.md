@"
# Currency Converter (Flutter)

Небольшое приложение на Flutter: ввод суммы → выбор валюты (USD/EUR/KZT) → конвертация в RUB.
- Валидация ввода (`Form` + `TextFormField`)
- Анимации (`AnimatedOpacity`, `AnimatedContainer`)
- Деактивация кнопки при неверном вводе
- Иконки флагов (локальные assets)

## Скриншоты
_(добавь изображение в папку `screenshots/` и вставь сюда)_

## Запуск
\`\`\`bash
flutter pub get
flutter run
\`\`\`

## Структура
\`\`\`
lib/
main.dart
assets/
flags/
us_flag.png
eu_flag.png
kz_flag.png
pubspec.yaml
\`\`\`

## Лицензия
MIT
"@ | Out-File -Encoding UTF8 "README.md"
