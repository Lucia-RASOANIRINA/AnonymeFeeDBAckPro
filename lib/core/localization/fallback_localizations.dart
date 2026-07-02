import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Le malgache (`mg`) n'est pas couvert par `flutter_localizations` : il n'existe
/// pas de `MaterialLocalizations` / `CupertinoLocalizations` pour cette langue.
/// Sans repli, tout widget Material (TextField, SearchBar...) plante avec
/// « No MaterialLocalizations found ».
///
/// Ces délégués interceptent uniquement `mg` et chargent les données du
/// FRANÇAIS à la place (libellés système : "OK", "Annuler", format d'heure...),
/// tout en gardant nos propres textes traduits en malgache via [AppStrings].

class FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mg';

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('fr'));

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
