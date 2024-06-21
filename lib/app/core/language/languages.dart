import 'package:get/get.dart';
import 'package:ilu/app/core/language/bangla_language.dart';
import 'package:ilu/app/core/language/english_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'bn_BD': BanglaLanguage.bangla,
        'en_US': EnglishLanguage.english,
      };
}
