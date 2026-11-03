# Temperaturrechner mit Flutter

Kleine Lern-App mit Material Design: Celsius ↔ Fahrenheit, Dezimalkomma oder
Dezimalpunkt, negative Werte, Eingabeprüfung und Formelanzeige. Keine externen
Pakete, kein Server und kein API-Schlüssel erforderlich.

## Voraussetzungen

Flutter SDK (inklusive Dart), VS Code mit der Erweiterung **Flutter** und für
den einfachen Browserstart Google Chrome.
Installation: https://docs.flutter.dev/install

## Starten

1. ZIP entpacken und den Ordner `temperatur_app` in VS Code öffnen.
2. Im integrierten Terminal ausführen:

```sh
flutter doctor
flutter create --platforms=web --project-name temperatur_app .
flutter pub get
flutter run -d chrome
```

Das ZIP enthält den App-Quellcode und `pubspec.yaml`. Der `flutter create`-Befehl
ergänzt die generierten Web-Plattformdateien im vorhandenen Ordner; die bereits
vorhandene `lib/main.dart` bleibt bestehen.

Für Android stattdessen oder zusätzlich `flutter create --platforms=android .`
ausführen, einen Emulator oder ein Android-Gerät bereitstellen und mit
`flutter run` starten. Dafür ist die Android-Toolchain erforderlich.

## Code verstehen

- `main()` startet die Anwendung mit `runApp()`.
- `TemperaturApp` legt Titel und Design fest.
- `TemperaturSeite` ist ein `StatefulWidget`, weil Eingabe, Richtung und Ergebnis
  während der Verwendung verändert werden.
- `_umrechnen()` prüft die Eingabe und berechnet das Ergebnis.
- `setState()` aktualisiert die Anzeige.
- `dispose()` gibt den Text-Controller frei.

## Manuell prüfen

| Richtung | Eingabe | Erwartetes Ergebnis |
|---|---:|---:|
| °C → °F | 0 | 32,00 °F |
| °C → °F | 100 | 212,00 °F |
| °F → °C | 32 | 0,00 °C |
| °F → °C | 212 | 100,00 °C |
| beide | -40 | -40,00 in der Zieleinheit |
| °C → °F | 20,5 | 68,90 °F |
| beide | leer oder abc | Fehlermeldung |

Richtungswechsel interpretiert die vorhandene Eingabe in der neu gewählten
Ausgangseinheit und berechnet das Ergebnis erneut. Eine Änderung im Eingabefeld
blendet das alte Ergebnis aus, bis erneut umgerechnet wird.

Dieses Beispiel ist ein mathematischer Einheitenrechner; physikalische Grenzen
wie der absolute Nullpunkt werden nicht geprüft.

## Prüfstatus

In der Erstellungsumgebung ist kein Flutter SDK installiert. Daher wurden weder
`flutter analyze` noch ein Build oder ein Laufzeittest ausgeführt. Nach dem
Generieren der Plattformdateien lokal `flutter analyze` ausführen und die obigen
Beispiele prüfen.

Offizielle Anleitung: https://docs.flutter.dev/learn/pathway/tutorial/create-an-app
