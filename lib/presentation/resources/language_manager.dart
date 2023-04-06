import 'dart:ui';

enum LanguageType { english, hindi }

const String english = 'en';
const String hindi = 'hi';
const Locale HINDI_LOCAL = Locale("hi","IN");
const Locale ENGLISH_LOCAL = Locale("en","US");
extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.hindi:
        return hindi;
    }
  }
}
