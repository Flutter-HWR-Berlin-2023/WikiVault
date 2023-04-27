
// General
const String appName = "WikiVault";
const String appVersion = "1.0";
const String appLegalese = "Diese App wurde für den HWR Flutter-Kurs erstellt";
const String appAssetIcon = "assets/icon.png";
const String error = "Fehler";
const String success = "Erfolgreich";
const String cancel = "Abbrechen";

// Sidebar
const String searchPage = "Suchen";
const String bookmarkPage = "Lesezeichen";
const String historyPage = "Verlauf";
const String settingsPage = "Einstellungen";
const String help = "Hilfe";

// Search
const String searchHint = "Suchen...";
const String searchAppeal = "Suche nach Artikeln!";
const String searchNoResults = "Keine Ergebnisse";
const String continueButton = "MEHR LADEN";

const String fetchError = "Fehler beim Abrufen des Artikels";
const String fetchSocket = "Es konnte keine Verbindung hergestellt werden";
const String fetchTimeOut = "Verbindung Zeit überschritten";

// Bookmark
const String noBookmarks = "Keine Lesezeichen";

const String changeBookmark = "Lesezeichen Ändern";
String changeBookmarkTitle(String name) => "Änderungen von $name";
const String title = "Titel";
const String description = "Beschreibung";
const String change = "Ändern";

const String addBookmark = "Lesezeichen Hinzufügen";
String buttonAddBookmark(String name) => "Möchtest du $name zu den Lesezeichen hinzufügen?";
const String removeBookmark = "Lesezeichen Entfernen";
const String remove = "Entfernen";
String buttonRemoveBookmark(String name) => "Möchtest du $name von den Lesezeichen entfernen?";
const String add = "Hinzufügen";

String eventAddBookmarkError(String name) => "Artikel $name konnte nicht hinzugefügt werden";
String eventAddBookmarkSuccess(String name) => "Artikel $name wurde hinzugefügt";
String eventChangeBookmarkError(String name) => "Artikel $name konnte nicht geändert werden";
String eventChangeBookmarkSuccess(String name) => "Artikel $name wurde geändert";
String eventRemoveBookmarkError(String name) => "Artikel $name konnte nicht entfernt werden";
String eventRemoveBookmarkSuccess(String name) => "Artikel $name wurde entfernt";

// History
const String noHistory = "Kein Verlauf";

// Settings
const String generalSection = "Allgemein";
const String searchSection = "Suchen";